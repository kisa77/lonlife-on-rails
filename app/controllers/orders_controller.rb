class OrdersController < FrontendController
    skip_before_filter :require_login, :require_space_access, :verify_authenticity_token,
                       :only => [:alipay_notify, :alipay_return]
#    load_and_authorize_resource
    before_filter :permit_params
    before_filter :set_trade_order_and_user,  :only => [:alipay_notify, :alipay_return,
                                                        :tenpay_return, :tenpay_notify]

    def new
        @order = Order.new
    end

    # 提交订单
    def create
        # TODO check email exists

        @order = Order.new(order_params.merge(:email    => current_user.email,
                                              :status   => Order::STATUS_OPEN,
                                              :user     => current_user,
                                              :order_id => Order.generate_order_id,
                                              :days     => order_params[:days].to_i,
                                              :amount   => order_params[:quantity].to_i * order_params[:price].to_f))

        if @order.save && ['alipay', 'tenpay', 'paypal'].include?(order_params[:pay_type])
            redirect_to @order.send "#{order_params[:pay_type]}_url"
        else
            # TODO flash格式化
            flash.now[:alert] = @order.errors.full_messages
            render new_order_path, :local => @order
        end
    end

    # 支付成功页面
    def show
        @order = Order.where(:order_id => params[:id]).first
    end

    # 接收alipay异步消息
    def alipay_notify
        if alipay_verify? && order_verify?
            handle_alipay_notify

            render :text => 'success'
        else
            render :text => 'error'
        end
    end

    # 接收alipay返回页面
    def alipay_return
        if alipay_verify? && order_verify?
            handle_alipay_notify
        else
            flash.now[:alert] = '支付失败,链接已失效'
        end

        # TODO 支付成功页面
        render 'show', :local => @order ||= Order.new
    end

    # 财付通回调
    def tenpay_return
        debug_log
        if tenpay_verify? && order_verify?
            handle_tenpay_notify
        else
            flash.now[:alert] = '支付失败,链接已失效'
        end

        # TODO 支付成功页面
        render 'show', :local => @order ||= Order.new
    end

    # 财付通异步通知
    def tenpay_notify
        debug_log
        if tenpay_verify? && order_verify?
            handle_tenpay_notify
            render :text => 'success'
        else
            render :text => 'error'
        end
    end

    private
    def alipay_verify?
        notify_params = params.except(*request.path_parameters.keys)
        Alipay::Notify.verify?(notify_params) && ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(params[:trade_status])
    end

    def tenpay_verify?
        notify_params = params.except(*request.path_parameters.keys)
        JaslTenpay::Notify.verify?(notify_params) && params[:trade_status].to_i == 0
    end

    def handle_tenpay_notify
        @order.complete({#:receiver         => params[:seller_email],
                        :third_party_order => params[:transaction_id],
                        :pay_at            => params[:time_end],
        })

        # TODO action_log,charge
        @user.recharge @order.days
    end

    def order_verify?
        @order.present? && @order.open?
    end

    def debug_log
        File.open('/tmp/tenpay_notify', 'a') do |file|
            file.puts "#{request.url}"
            file.puts "#{Time.now.utc.to_s}\t#{ params.to_json}"
            file.close
        end
    end

    # 处理支付宝回调方法
    # 并发处理
    def handle_alipay_notify
        @order.complete({:receiver         => params[:seller_email],
                        :third_party_order => params[:trade_no],
                        :pay_at            => params[:notify_time],
        })

        # TODO action_log,charge
        @user.recharge @order.days
    end

    def set_trade_order_and_user
        @order = Order.where(:order_id => params[:id], :status => Order::STATUS_OPEN).first
        @user = @order.user if @order.present?
    end

    def order_params
        params.require(:order).permit(:quantity, :product_id, :price, :days, :pay_type)
    end

    def require_login
        authenticate_user!
    end

    def permit_params
        params.permit!
    end
end
