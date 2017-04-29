class UsersController < ApplicationController

  def welcome
    @user = User.new
  end

  def new
    @user = User.new
  end

  def edit_admin
    @user = User.find(params[:id])
  end



end
