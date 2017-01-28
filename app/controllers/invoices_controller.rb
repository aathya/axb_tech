class InvoicesController < ApplicationController
  before_action :set_new_invoice, only: [:index]

  def index
    invoices = Invoice.collected_bills if params[:bill] == "collected_bills"
    invoices = Invoice.pending_bills if params[:bill] == "pending_bills"
    invoices = Invoice.all if params[:bill].nil?
    @invoices = invoices.paginate(page: params[:page]).order("created_at DESC")
    respond_to do |format|
      format.html
      format.json { render json: @invoices, status: :ok }
    end
  end

  def create
    invoice_params = invoice_permit_params(params)
    @invoice_created = Invoice.new(invoice_params)
    respond_to do |format|
      if @invoice_created.save
        format.json {render json: @invoice_created, status: :created }
        format.js
        format.html {redirect_to root_path, flash: { success: "Invoice Saved Successfully" }}
      else
        format.json {render json: @invoice_created.errors.full_messages, status: :unprocessable_entity }
        format.js
        format.html {redirect_to root_path, flash: { error: @invoice_created.errors.full_messages }}
      end
    end
  end


  private

  def invoice_permit_params(params)
    params.require(:invoice).permit(:brand_manager, :customer_name, :narration, :amount)
  end

  def set_new_invoice
    @invoice = Invoice.new
  end
end
