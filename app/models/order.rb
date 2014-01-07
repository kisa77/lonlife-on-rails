class Order < ActiveRecord::Base

    STATUS_OPEN = 0
    STATUS_PAY_SUCCESS = 1
    STATUS_CANCEL = 10

    validates_presence_of :email, :user_id, :order_id
    validates_presence_of :quantity, :price, :product_id, :on => :create
    validates_inclusion_of :status, :in => [STATUS_PAY_SUCCESS, STATUS_OPEN, STATUS_CANCEL]

    belongs_to :user

    attr_accessor :quantity, :price

    def self.generate_order_id
        now = Time.now
        "#{now.strftime('%Y%m%d')}-#{Random.rand(10000000..99999999).to_s}-#{now.strftime('%H%M%S')}"
    end

    def open?
        status == STATUS_OPEN
    end

    def complete (attributes)
        if open?
            update_attributes(attributes.merge(:status => STATUS_PAY_SUCCESS))
        end
        # TODO 给用户增加时间
    end

    def alipay_url
        Alipay::Service.create_direct_pay_by_user_url({
            :out_trade_no      => order_id,
            :price             => '0.01', # price
            :quantity          => quantity,
            :discount          => '1',
            :subject           => "#{product_id} 产品编号  x #{quantity}",
            :logistics_type    => 'DIRECT',
            :logistics_fee     => '0',
            :logistics_payment => 'SELLER_PAY',
            :return_url        => "http://106.187.34.7:3000/orders/#{order_id}/alipay_return",
            :notify_url        => "http://106.187.34.7:3000/orders/#{order_id}/alipay_notify",
            :receive_name      => 'none',
            :receive_address   => 'none',
            :receive_zip       => '100000',
            :receive_mobile    => '100000000000'
        })
    end

    def alipay_refund_url
    end

    def tenpay_url
        puts price
        JaslTenpay::Service.create_interactive_mode_url({
            :out_trade_no      => order_id,
            :subject           => '支付测试 By Ruby',
            :body              => '一些描述',
            :total_fee         => "#{(price.to_f * 100).to_i}", # 单位:分
            :spbill_create_ip  => '171.8.102.33',
            :return_url        => "http://106.187.34.7:3000/orders/#{order_id}/tenpay_return",
            :notify_url        => "http://106.187.34.7:3000/orders/#{order_id}/tenpay_notify"
        })
    end
end
