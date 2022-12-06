class UserLeaguesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user_league

  def create
    if !current_user
      session[:attendee] = true
      redirect_to user_session_path
    elsif @league.matches.present?
      redirect_to leagues_path, notice: "Too late... the league has already started :/"
    else
      UserLeague.create(league_id: params[:league_id], user: current_user, points: 0)
      redirect_to league_path(params[:league_id])
    end
  end

  def destroy
    @user_league.destroy
  end

  private

  def set_user_league
    @user_league = UserLeague.find(params[:id])
  end
end
