class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 新規会員登録入力画面
  def new
    @user = User.new
  end

  # 新規会員登録入力フォームの保存とバリデーション
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

  # 新規送付先住所の保存とバリデーション
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

  # 会員情報編集画面
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(account_update_params)
      redirect_to user_path(current_user), notice: '更新しました'
      sign_in(current_user, bypass: true)
      # (current_user, bypass: true)はdeviceの仕様上パスワードが変更になるとログアウトする仕組みになっている。確認ようで入れているパスワードも編集変更扱いになるので、それを防ぐために記述。
    else
      flash.now[:alert] = @user.errors.full_messages
      render :edit and return
    end
  end

  # 送付先住所編集画面
  def edit_address
    @address = current_user.address
  end

  # 送付先住所編集画面の更新ボタンをクリックした時のバリデーションと保存。
  def update_address
    @address = current_user.address
    if @address.update(address_params)
      redirect_to root_path notice: '更新しました'
    else
      flash.now[:alert] = @address.errors.full_messages
      render :edit_address
    end
  end

  protected

  # 新規送付先住所登録にemailとpassword以外の登録を許可するための記述。バリデーションもかけるため。
  def address_params
    params.require(:address).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :postal_code,
                                    :prefectur, :city, :house_number, :apartment, :phone)
  end

  protected

  # 会員情報編集画面にemailとpassword以外の編集を許可する記述
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday, :introduce, :avter) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :nickname, :email, :first_name, :first_name_kana, :last_name, :last_name_kana, :birthday, :introduce, :avter) }
  end

  # 会員情報編集画面の更新ボタンをクリックした時に現在のパスワードの入力だけで更新できる
  def update_resource(resource, params)
    resouce.update_without_password(params)
  end

  # protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :postal_code,
  #           :prefectur, :city, :house_number) }
  # end


  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys:
  #   [:nickname,  :birthday, :first_name, :last_name])
  # end

  # def address_params
  #   params.require(:address).permit(:first_name,, :last_name, :first_name_kana,
  #   :last_name_kana, :postal_code, :prefecture, :prefecture_id,  :city, :municipality, 
  #   :address, :apartment, :phone)
  # end

  

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
