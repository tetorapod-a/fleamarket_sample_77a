class UsersController < ApplicationController

  def edit
  end

  def show
    @user = User.find(current_user.id)
    @address = Address.find(current_user.id)
  end  

end