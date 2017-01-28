namespace :collection_rake do
  task :create => :environment do
    seed_collection
  end

  def seed_collection
    JSON.parse(open("#{Rails.root}/docs/collections.json").read).each do |collection_json|
      collection = Collection.new(collection_json)
      collection.save! if collection.invoice.present?
    end
  end
end
