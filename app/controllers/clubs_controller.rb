class ClubsController < ApplicationController
  include Pundit::Authorization

  skip_before_action :require_authentication, only: [:index, :show]
  before_action :set_club, only: [:show, :join]
  before_action :set_user_club, only: [:edit, :update, :destroy]


  def index
    @clubs = policy_scope(Club.all)
  end

  def new
    @club = Club.new
    authorize @club
  end

  def show
    authorize @club
  end

  def create
    @club = Current.user.clubs_admin.new(club_params)
    authorize @club

    if @club.save
      redirect_to @club, notice: "Successfully created the club!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @club
  end

  def update
    authorize @club
    if @club.update(club_params)
      redirect_to @club, notice: "Successfully updated the club!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @club
    @club.users.clear
    @club.destroy

    redirect_to clubs_path, notice: "Successfully destroyed the club!"
  end

  def join
    authorize @club, :join?
    ClubMembership.create(user: Current.user, club: @club)
    redirect_to @club, notice: "You have joined the club."
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def set_user_club
    if Current.user.admin? || Current.user.moderator?
      set_club
    else
      @club = Current.user.clubs_admin.find(params[:id])
    end
  end

  def club_params
    params.require(:club).permit(:title, :description)
  end
end
