class UsersController < ApplicationController

  def edit
  end

  def show
    @address = Address.find(current_user.id)
  end  

end