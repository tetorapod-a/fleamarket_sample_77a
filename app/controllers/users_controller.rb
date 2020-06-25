class UsersController < ApplicationController


  def edit
  end


  def show
    @user = User.find(current_user.id)
    @address = Address.find(current_user.id)
    # unless @address.valid?
    #   flash.now[:alert] = @address.errors.full_messages
    #   render :new_address and return
    # end
    # @user.build_address(@address.attributes)
    # @user.save
    # session["devise.regist_data"]["user"].clear
    # sign_in(:user, @user)
  end  

    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys:
    #   [:nickname,  :birthday, :first_name, :last_name])
    # end

    # def address_params
    #   params.require(:address).permit(:first_name,, :last_name, :first_name_kana,
    #   :last_name_kana, :postal_code, :prefecture, :prefecture_id,  :city, :municipality, 
    #   :address, :apartment, :phone)
    # end

  # private

  #   def address_params
  #     params.require(:address).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :postal_code,
  #                                     :prefectur, :city, :house_number, :apartment, :phone)
  #   end
end