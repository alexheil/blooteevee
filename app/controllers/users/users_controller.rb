class Users::UsersController < ApplicationController
  
  def show
    @user = User.friendly.find(params[:id])
    if user_signed_in?
      @subscription = Subscription.new
    end
  end
  
end