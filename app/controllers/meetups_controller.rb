class MeetupsController < ApplicationController
    include Pundit::Authorization

    skip_before_action :require_authentication, only: [:index, :show]
    before_action :set_club
    before_action :set_meetup, only: [:show, :edit, :destroy, :participate, :update]


    def index
      @meetups = @club.meetups.all
    end

    def new
      @meetup = Meetup.new
      authorize @meetup
    end

    def create
      @meetup = @club.meetups.build(meetup_params)
      @meetup.organizer = Current.user
      @meetup.users << Current.user
      authorize @meetup

      if @meetup.save
        redirect_to [@club, @meetup]
      else
        render :new, status: :unprocessable_content
      end
    end

    def show
       authorize @meetup
    end

    def edit
      authorize @meetup
    end

    def update
      authorize @meetup
      if @meetup.update(meetup_params)
        redirect_to [@club, @meetup]
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      authorize @meetup
      @meetup.users.clear
      @meetup.destroy
      redirect_to club_meetups_path(@club)
    end

    def participate
      authorize @meetup, :participate?

      @meetup.users << Current.user
      redirect_to [@club, @meetup], notice: "You have successfully joined the meetup."
    end

    private

    def set_club
      @club = Club.find(params[:club_id])
    end

    def set_meetup
      @meetup = @club.meetups.find(params[:id])
    end

    def meetup_params
      params.require(:meetup).permit(:title, :subject, :datetime, :location, :max_participants)
    end

end
