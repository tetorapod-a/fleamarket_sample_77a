class CardsController < ApplicationController
  require "payjp"
  before_action :set_card
  
  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if @card.exists?
  end

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to new_card_path
      else
        redirect_to action: "new"
      end
    end
  end

  def show
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)

      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "master.png"
      when "American Express"
        @card_src = "american.png"
      when "Diners Club"
        @card_src = "diners.png"
      when "Discover"
        @card_src = "discover.png"
      end
      
      @exp_month = @customer_card.exp_month.to_s
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
      if @card.destroy
        redirect_to user_path(current_user.id), notice: "削除されました。"
      else
        redirect_to cards_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end
  private

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end
end
