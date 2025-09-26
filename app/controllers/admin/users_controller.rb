module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update]

    def index
      @users = policy_scope([:admin, User])
      authorize [:admin, User]
    end

    def edit
      authorize [:admin, @user]
    end

    def update
      authorize [:admin, @user]
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User successfully updated"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email_address, :username, :role)
    end
  end
end