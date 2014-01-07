class ActionLog < ActiveRecord::Base
    validates_presence_of :log_type, :user_id, :target_user, :do_user, :information
    belongs_to :user

    # 日志类型: memo:备注, action:操作日志
    LOG_TYPE_MEMO = 1
    LOG_TYPE_ACTION = 2
    LOG_TYPE_RECHARGE = 3

    LOG_TYPE_MAP = %w[其他 用户备注 操作日志 充值记录]
end
