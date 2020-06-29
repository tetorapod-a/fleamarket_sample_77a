require 'rails_helper'
describe Item do
  describe '#create' do

    it "image, name, detail, price, status_id, postage_id, shipping_day_id, shipping_method_id, prefecture_id, category_id, seller_idがあれば出品できること" do
      user = create(:user)
      item = build(:item, seller_id: user[:id])
      expect(item).to be_valid
    end

    it 'brandがなくても出品できること' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], brand: nil)
      expect(item).to be_valid
    end

    it "imageが0枚だと出品できないこと" do
      user = create(:user)
      item = Item.new(name: "abc", detail: "abc", price: 1000, status_id: 1, postage_id: 1, shipping_day_id: 1, shipping_method_id: 1, prefecture_id: 1, category_id: 1, seller_id: user[:id])
      item.valid?
    end

    it 'nameがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], name: nil)
      item.valid?
    end

    it 'nameが40字以上だと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], name: "1111111111222222222233333333334444444444555555555")
      item.valid?
    end

    it 'detailがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], detail: nil)
      item.valid?
    end

    it 'priceがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], price: nil)
      item.valid?
    end

    it 'status_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], status_id: nil)
      item.valid?
    end

    it 'postage_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], postage_id: nil)
      item.valid?
    end

    it 'shipping_day_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], shipping_day_id: nil)
      item.valid?
    end

    it 'shipping_method_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], shipping_method_id: nil)
      item.valid?
    end

    it 'prefecture_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], prefecture_id: nil)
      item.valid?
    end

    it 'category_idがないと出品できないこと' do
      user = create(:user)
      item = build(:item, seller_id: user[:id], category_id: nil)
      item.valid?
    end

  end
end