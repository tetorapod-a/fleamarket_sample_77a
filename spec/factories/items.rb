FactoryBot.define do

  factory :item do
    id                  {1}
    name                {"abc"}
    detail              {"abc"}
    price               {1000}
    status_id           {1}
    postage_id          {1}
    shipping_day_id     {1}
    shipping_method_id  {1}
    prefecture_id       {1}
    category_id         {12}
    seller_id           {1}
    brand               {"abc"}
    buyer_id            {""}
    after(:build) do |item|
      item.images << build(:image, item: item)  
    end                                                  
  end

end