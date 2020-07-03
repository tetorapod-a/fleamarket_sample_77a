require 'rails_helper'

describe Card do
  describe '#create' do

    it 'customer_idがなければ登録できないこと' do
      card = build(:card, customer_id: "")
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
    
    it 'card_idがなければ登録できないこと' do
      card = build(:card, card_id: "")
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
  end
end