FactoryBot.define do

  factory :user do
    id                      {1}
    nickname                {"abc"}
    first_name              {"てすと"}
    first_name_kana         {"テスト"}
    last_name               {"てすと"}
    last_name_kana          {"テスト"}
    birthday                {"2000-04-01"}
    email                   {"test@test.com"}
    password                {"111111a"}
    encrypted_password      {"111111a"}
    avter                   {""}
    introduce               {""}
    adress_id               {""}
  end

end