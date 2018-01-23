class UserAddressesController < ApplicationController
  before_action :set_user_address, only: [:edit, :update]
  before_action :authorize

  # GET /user_addresses
  # GET /user_addresses.json
  def index
    current_address = current_user.user_addresses.where(:primary => true)
    if current_address.empty?
      redirect_to new_user_address_path
    else
      redirect_to edit_user_address_path(current_address[0][:id])
    end
  end

  # GET /user_addresses/new
  def new
    @user_address = UserAddress.new
  end

  # GET /user_addresses/1/edit
  def edit
  end

  # POST /user_addresses
  # POST /user_addresses.json
  def create
    @user_address = current_user.user_addresses.new(user_address_params)
    @user_address[:primary] = true

    respond_to do |format|
      if @user_address.save
        format.html { redirect_to activities_path, notice: 'User address was successfully created.' }
        format.json { render :show, status: :created, location: @user_address }
      else
        format.html { render :new }
        format.json { render json: @user_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_addresses/1
  # PATCH/PUT /user_addresses/1.json
  def update
    UserAddress.transaction do
      @user_address.update({:primary => false})
      respond_to do |format|
        new_user_address = current_user.user_addresses.new(user_address_params)
        new_user_address[:primary] = true

        if new_user_address.save
          format.html { redirect_to activities_path, notice: 'User address was successfully updated.' }
          format.json { render :show, status: :ok, location: @user_address }
        else
          format.html { render :edit }
          format.json { render json: @user_address.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_address
      @user_address = UserAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_address_params
      params.require(:user_address).permit(:address_line, :address_line_2, :zip_code, :city, :state, :country)
    end
end
