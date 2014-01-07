class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email

  has_many :orders
  has_many :action_logs

  attr_reader :memo, :charge_money, :deduct_money

  ROLES = %w[member admin]

  # 记录操作日志
  before_update do |user|
      log_array = []
      User.find_by_id(self.id).attributes.each do |k, v|
          log_array << "#{k}: #{v} => #{user[k]}," if user[k] != v && k != 'updated_at'
      end
      return true if log_array.blank?
      ActionLog.new({
                    :user          => self,
                    :log_type      => ActionLog::LOG_TYPE_ACTION,
                    :target_user   => self.email,
                    :information   => log_array.join(", "),
                    :do_user_id    => User.current.present? ? User.current.id : self.id,
                    :do_user       => User.current.present? ? User.current.email : self.email,
      }).save
  end


  # 存储当前会话用户,供Model调用
  def self.current
      Thread.current[:user]
  end

  def self.current=(user)
      Thread.current[:user] = user
  end

  # 搜索方法 
  # TODO 模糊搜索
  def self.search_by_condition(search_params, page)
      condition = {}
      return [] unless search_params.present?
      search_params.each do |key, value|
          condition.store(key, value) if value.present?
      end
      where(condition).page(page)
  end

  def admin?
      self.role == 'admin'
  end

  # 备注
  def memo=(info)
      return true if info.blank?
      ActionLog.new({
                    :user          => self,
                    :log_type      => ActionLog::LOG_TYPE_MEMO,
                    :target_user   => self.email,
                    :information   => log_array.join(", "),
                    :do_user_id    => User.current.id,
                    :do_user       => User.current.email,
      }).save
  end

  def charge_money=(money)
      # TODO 充值记录
      self.money += money.to_f;
  end

  def deduct_money=(money)
      # TODO 充值记录
      self.money -= money.to_f
  end

  def recharge(days)
      # TODO 验证游戏类型
      expire_time = Time.now if expire_time.blank?
      update_attributes({:expire_time   => expire_time.advance(:days => days)})
  end

end
