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
        redirect_to admin_users_path, notice: "User successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      permitted = [:name, :email_address, :username]
      permitted << :role if current_user.admin?
      params.require(:user).permit(permitted)
    end

  end
end