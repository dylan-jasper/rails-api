RSpec.describe 'Items API', type: :request do
  it 'soft deletes an item' do
    item = FactoryBot.create(:item)

    # Perform soft delete
    delete "/api/v1/items/#{item.id}"

    expect(response).to have_http_status(:no_content)

    # Check that the item is soft-deleted
    expect(Item.unscoped.find(item.id).deleted_at).not_to be_nil
  end
  it 'restores a soft deleted item' do
    item = FactoryBot.create(:item, deleted_at: Time.now)

    # Perform the restore
    put "/api/v1/items/#{item.id}/restore"

    expect(response).to have_http_status(:success)

    # Check that the item is restored
    expect(Item.unscoped.find(item.id).deleted_at).to be_nil
  end

  it 'excludes soft deleted items from normal queries' do
    FactoryBot.create(:item)
    FactoryBot.create(:item)
    FactoryBot.create(:item)
    FactoryBot.create(:item)
    soft_deleted_item = FactoryBot.create(:item, deleted_at: Time.now)

    get '/api/v1/items'

    expect(response).to have_http_status(:success)
    items = JSON.parse(response.body)
    expect(items).not_to include(soft_deleted_item.as_json)
    expect(items.length).to eq(4)
  end

  it 'permanently deletes an item after soft delete' do
    item = FactoryBot.create(:item)

    # Perform soft delete
    delete "/api/v1/items/#{item.id}"

    expect(response).to have_http_status(:no_content)

    # Perform hard delete
    delete "/api/v1/items/#{item.id}"

    expect(response).to have_http_status(:no_content)

    # Check that the item is hard-deleted (not found)
    expect { Item.unscoped.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
