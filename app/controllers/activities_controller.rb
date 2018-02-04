class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:edit, :update, :destroy]
  before_action :authorize

  # GET /activities
  # GET /activities.json
  def index
    @activities = @current_user.activities.order(:start_time)
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    params = activity_params
    if params[:project_id]
      params[:customer_id] = Project.find(params[:project_id]).customer.id
    end
    @activity = @current_user.activities.new(params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activities_url, notice: 'Activity was successfully created.' }
        format.json { render :index, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    params = activity_params
    params[:customer_id] = Project.find(params[:project_id])[:customer_id]
    respond_to do |format|
      if @activity.update(params)
        format.html { redirect_to activities_url, notice: 'Activity was successfully updated.' }
        format.json { render :index, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    if @activity.invoice.nil?
      @activity.destroy
      respond_to do |format|
        format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      message = 'Cannot delete activity included in invoice!'
      respond_to do |format|
        format.html { redirect_to activities_url, alert: message }
        format.json { render json: { :message => message}, status: :unprocessable_entity}
      end

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:description, :project_id, :start_time, :end_time)
    end
end
