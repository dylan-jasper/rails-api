require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#soft_delete' do
    it 'sets the deleted_at attribute' do
      item = FactoryBot.create(:item)

      expect do
        item.soft_delete
      end.to change { item.deleted_at }.from(nil)
    end
  end

  describe '#restore' do
    it 'resets the deleted_at attribute to nil' do
      item = FactoryBot.create(:item, deleted_at: Time.now)

      expect do
        item.restore
      end.to change(item, :deleted_at).to(nil)
    end
  end
end
