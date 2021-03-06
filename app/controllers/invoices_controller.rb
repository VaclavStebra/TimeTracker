class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = @current_user.invoices
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf do
        render pdf: @invoice.customer_address[:name]
      end
    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    @customers = []
    user_customers = @current_user.customers.order(:name)
    user_customers.each do |customer|
      if customer.activities.where(:invoice_id => nil).length > 0
        @customers.push(customer)
      end
    end
    if @customers.length == 0
      redirect_to invoices_url, alert: 'No activities to associate with the invoice'
      return
    end
    if @current_user.user_addresses.where(:primary => true).length == 0
      redirect_to invoices_url, alert: 'No address! Please fill address in settings first'
    end
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice[:date] = DateTime.now
    @invoice[:user_id] = @current_user[:id]
    @invoice[:user_address_id] = @current_user.user_addresses.where(:primary => true)[0][:id]
    @invoice[:customer_address_id] = CustomerAddress.where(:customer_id => @invoice[:customer_id], :primary => true)[0][:id]

    @invoice[:total_cost] = 0
    activities = Activity.where(:invoice_id => nil, :customer_id => @invoice[:customer_id])
    activities.each  do |activity|
      diff = activity.end_time.to_time - activity.start_time.to_time
      hours = diff / 60 / 60
      @invoice[:total_cost] += (activity.project[:rate] * hours).round
    end

    respond_to do |format|
      if @invoice.save
        activities.each do |activity|
          activity.update(:invoice_id => @invoice[:id], :rate => activity.project[:rate])
        end
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:customer_id)
    end
end
