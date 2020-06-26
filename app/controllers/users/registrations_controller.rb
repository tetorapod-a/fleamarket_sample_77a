# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @address = @user.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    session["devise.regist_data"]["user"].clear
    sign_in(:user, @user)
  end

  protected

  


  private

  def set_user
    @user = User.find([:id])
  end

  def user_params
    params.fetch(:user, {}).permit(:nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday)
  end
  
  protected

  def update
    p user_params
    respond_to do |format|
      if @user.update_without_current_password(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

  def address_params
    params.require(:address).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :postal_code,
                                    :prefectur, :city, :house_number, :apartment, :phone)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday) }
  end

  



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  

end
