# coding:utf-8
class Admin::UsersController < Admin::BaseController
    load_and_authorize_resource
    before_action :set_user, only: [:show, :edit, :update, :destroy, :show_my_log]

    # GET /users
    # GET /users.json
    def index
        if params[:commit].present?
            @users = User.search_by_condition(user_params, params.permit![:page])
        else
            @users = User.order('updated_at DESC, id DESC').page(params.permit![:page])
        end

        # for search
        @user = User.new(user_params)
    end

    # GET /users/1
    # GET /users/1.json
    def show
    end

    # GET /users/new
    def new
        @user = User.new
    end

    # GET /users/1/edit
    def edit
        @action_logs = @user.action_logs.where(log_type: ActionLog::LOG_TYPE_MEMO).order(id: :desc).page(params.permit![:page]).per(30)
    end

    # POST /users
    # POST /users.json
    def create
        @user = User.new(user_params)

        respond_to do |format|
            if @user.save
                format.html { redirect_to [:admin,@user], notice: 'User was successfully created.' }
                format.json { render action: 'show', status: :created, location: @user }
            else
                format.html { render action: 'new' }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to edit_admin_user_path(@user), notice: 'User was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { redirect_to edit_admin_user_path(@user), alert: @user.errors.full_messages.to_sentence}
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to admin_users_url }
            format.json { head :no_content }
        end
    end

    def show_my_log
        @action_logs = @user.action_logs.where(log_type: ActionLog::LOG_TYPE_ACTION).order(id: :desc).page(params.permit![:page]).per(30)
        respond_to do |format|
            format.js {render 'show_my_log', layout: false} #{render json: {msg: 'success!'}}
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:name, :comment_mode, :comment_sort, :theme, :signature, :signature_format,
                                     :status, :timezone, :language, :picture, :init_email, :data, :phone, :qq,
                                     :expire_date, :expire_days, :expire_time, :introducer, :invite_token,
                                     :is_verify_email, :is_buy, :money, :game_type, :is_pause, :pause_time,
                                     :is_mac, :login_success_times, :login_fail_times, :allow_client_number,
                                     :is_blocked, :register_source, :email, :current_sign_in_ip, :memo,
                                     :role, :charge_money, :deduct_money) if params[:user].present?
    end

end
