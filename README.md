# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

# fleamarket_sample_77a DB設計

## userテーブル
|Column|Type|Option|
|------|----|------|
|nickname|string|null:false, unique:true|
|email|string|null:false|
|first_name|string|null:false|
|first_name_kana|string|null:false|
|last_name|string|null:false|
|last_name_kana|string|null:false|
|birthday|date|null:false|
|avatar|text||
|introduce|text||
### Association
- has_many :items, dependent: :destroy
- has_many :addresses, dependent: :destroy
- has_many :pays, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :like_items, through: :like, source: :item, dependent: :destroy
- has_many :sns_credentials, dependent: :destroy
- has_many :purchase dependent: :destroy

## addressテーブル
|Column|Type|Option|
|------|----|------|
|first_name|string|null:false|
|first_name_kana|string|null:false|
|last_name|string|null:false|
|last_name_kana|string|null:false|
|postal_code|string|null:false|
|prefecture_id(active_hash)|integer|null:false|
|city|string|null:false|
|house_number|string|null:false|
|apartment|string||
|phone|string||
|user_id|references|null:false,foreign_key:true|
### Association
- belongs_to :user

## itemテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null:false|
|detail|text|null:false|
|price|string|null:false|
|status_id(active_hash)|integer|null:false|
|postage_id(active_hash)|integer|null:false|
|shipping_day_id(active_hash)|integer|null:false|
|shipping_method_id(active_hash)|integer|null:false|
|prefecture_id(active_hash)|integer|null:false|
|brand|string||
|category_id|references|null:false,foreign_key:true|
|buyer_id|references|foreign_key :true|
|seller_id|references|null:false, foreign_key :true|
### Association
- belongs_to :user, dependent: :destroy
- belongs_to :category, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :like, dependent: :destroy
- has_many :images, dependent: :destroy
- has_many :purchase, dependent: :destroy
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'

## categoriesテーブル（gem'ancestry'）
|Column|Type|Option|
|------|----|------|
|name|string|null:false|
|ancestry|string|null:false|
### Association
- has_many:items

## imageテーブル
|Column|Type|Option|
|------|----|------|
|image|text|null:false|
|item_id|references|null:false,foreign_key:true|
### Association
- belongs_to :item

## commentテーブル
|Column|Type|Option|
|------|----|------|
|content|text|null:false|
|item_id|references|null:false,foreign_key:true|
|user_id|references|null:false,foreign_key:true|
### Association
- belongs_to :user
- belongs_to :item

## likeテーブル
|Column|Type|Option|
|------|----|------|
|user_id|references|null:false,foreign_key:true|
|item_id|references|null:false,foreign_key:true|
### Association
- belongs_to :user
- belongs_to :item

## cardテーブル(payjp使用)
|Column|Type|Option|
|------|----|------|
|user_id|integer|null:false|
|customer_id|string|null:false|
|card_id|string|null:false|
### Association
- belongs_to :user


## sns_credentialテーブル
|Column|Type|Option|
|------|----|------|
|user_id|integer|null:false,foreign_key:true|
|uid|string||
|provider|string||
### Association
- belongs_to :user