class UsersController < ApplicationController

  def edit
  end

  def show
    @address = Address.find_by(user_id: current_user.id)
  end  

end