class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :destroy]
  before_action :authorize

  # GET /customers
  # GET /customers.json
  def index
    @customers = @current_user.customers
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = @current_user.customers.new(customer_params)

    respond_to do |format|
      if @customer.save
        @customer_address = @customer.customer_addresses.new(customer_params)
        @customer_address[:primary] = true
        if @customer_address.save
          format.html { redirect_to customers_url, notice: 'Customer was successfully created.' }
          format.json { render :index, status: :created, location: @customer }
        else
          format.html { render :new }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end

      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    @customer_address = CustomerAddress.where(:customer_id => @customer[:id], :primary => true)[0]
    @customer_address.update(:primary => false)

    respond_to do |format|
      if @customer.update(customer_params)
        @customer_address = @customer.customer_addresses.new(customer_params)
        @customer_address[:primary] = true
        @customer_address.save
        format.html { redirect_to customers_url, notice: 'Customer was successfully updated.' }
        format.json { render :index, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    respond_to do |format|
      if @customer.destroy
        format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
        format.json { head :no_content }
      else
        message = 'Cannot delete customer with projects! Please delete projects first.'
        format.html { redirect_to customers_path, alert: message }
        format.json { render json: { :message => message}, status: :unprocessable_entity}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :address_line, :address_line_2, :zip_code, :city, :state, :country, :primary)
    end
end
