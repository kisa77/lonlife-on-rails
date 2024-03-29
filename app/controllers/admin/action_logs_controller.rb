class Admin::ActionLogsController < Admin::BaseController
    load_and_authorize_resource
    before_action :set_action_log, only: [:show, :edit, :update, :destroy]

    # GET /action_logs
    # GET /action_logs.json
    def index
        @action_logs = ActionLog.page(params.permit![:page])
        respond_to do |format|
            format.html {render 'index'}
            format.json {render json:@action_logs}
        end
    end

    # GET /action_logs/1
    # GET /action_logs/1.json
    def show
    end

    # GET /action_logs/new
    def new
        @action_log = ActionLog.new
    end

    # GET /action_logs/1/edit
    def edit
    end

    # POST /action_logs
    # POST /action_logs.json
    def create
        @action_log = ActionLog.new(action_log_params)

        respond_to do |format|
            if @action_log.save
                format.html { redirect_to @action_log, notice: 'Action log was successfully created.' }
                format.json { render action: 'show', status: :created, location: @action_log }
            else
                format.html { render action: 'new' }
                format.json { render json: @action_log.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /action_logs/1
    # PATCH/PUT /action_logs/1.json
    def update
        respond_to do |format|
            if @action_log.update(action_log_params)
                format.html { redirect_to @action_log, notice: 'Action log was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: 'edit' }
                format.json { render json: @action_log.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /action_logs/1
    # DELETE /action_logs/1.json
    def destroy
        @action_log.destroy
        respond_to do |format|
            format.html { redirect_to action_logs_url }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_action_log
        @action_log = ActionLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def action_log_params
        params.require(:action_log).permit(:user_id, :target_user, :do_user, :infomation, :log_type, :description)
    end
end
