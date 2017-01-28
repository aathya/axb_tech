class CollectionsController < ApplicationController
  before_action :set_new_collection, only: [:index]

  def index
    @collections = Collection.ransack(search_params).result
    respond_to do |format|
      format.html
      format.json { render json: @collections, status: :ok }
    end
  end

  def create
    collection_params   = collection_permit_params(params)
    @collection_created = Collection.new(collection_params)
    respond_to do |format|
      if @collection_created.save
        format.json { render json: @collection_created, status: :created }
        format.js
        format.html { redirect_to collections_path(reference_cont: @collection_created.reference ), flash: { success: "Collection Saved Successfully" }}

      else
        format.json { render json: @collection_created.errors.full_messages, status: :unprocessable_entity }
        format.js
        format.html {redirect_to collections_path(reference_cont: @collection_created.reference ), flash: { error: @collection_created.errors.full_messages }}

      end
    end
  end

  private

  def collection_permit_params(params)
    params.require(:collection).permit(:amount, :reference)
  end

  def search_params
    params.permit(:reference_cont)
  end

  def set_new_collection
    @collection = Collection.new
  end
end
