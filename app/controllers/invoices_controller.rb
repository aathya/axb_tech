class InvoicesController < ApplicationController

  def index
    invoices = Invoice.all
    render json: invoices, status: :ok
  end

  def create
    invoice_params = invoice_permit_params(params)
    invoice = Invoice.new(invoice_params)
    if invoice.save
      render json: invoice, status: :created
    else
      render json: invoice.errors.full_messages, status: :unprocessable_entity
    end
  end


  private

  def invoice_permit_params(params)
    params.require(:invoice).permit(:brand_manager, :customer_name, :narration, :amount)
  end
end
