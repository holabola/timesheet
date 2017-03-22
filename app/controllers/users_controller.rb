class UsersController < ApplicationController

  def welcome
    @user = User.new
  end

  def new
    @user = User.new
  end




end
