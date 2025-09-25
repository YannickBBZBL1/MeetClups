class UsersController < ApplicationController
  before_action :require_authentication
  before_action :set_user

  def show
    @user = Current.user
  end

  def edit
    @user = Current.user
  end

  def update
    old_email = @user.email_address
    if @user.update(user_params)
      if old_email != @user.email_address
        confirmation_link = "http://localhost:3000/confirm-email?email=#{CGI.escape(@user.email_address)}"
        Rails.logger.debug "📧 Neuer Bestätigungslink für #{@user.username}: #{confirmation_link}"
      end

      redirect_to user_path, notice: "Account updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :name, :password, :password_confirmation)
  end

  def set_user
    @user = Current.user # oder User.find(params[:id]) – je nach App-Logik
  end
end

