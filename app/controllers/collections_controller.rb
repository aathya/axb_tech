class CollectionsController < ApplicationController
  def index
    collections = Collection.all
    render json: collections, status: :ok
  end

  def create
    collection_params = collection_permit_params(params)
    collection = Collection.new(collection_params)
    if collection.save
      render json: collection, status: :created
    else
      render json: collection.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def collection_permit_params(params)
    params.require(:collection).permit(:collection_amount, :invoice_id)
  end
end
