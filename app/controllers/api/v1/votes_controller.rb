class Api::V1::VotesController < ApplicationController
  def index
    render json: { response: "Success",
                   data: Vote.all }
  end

  def show
    if Vote.exists?(params[:id])
      render json: { respone: "Success",
                     data: Vote.find(params.fetch(:id)) }
    else
      render json: { response: "Vote does not exist" }, status: 404
    end
  end

  def create
    vote = Vote.new(vote_params)
    if vote.save
      render json: { response: "Success",
                     data: vote}
    else
      render json: { response: "Vote could not be created",
                     data: vote.errors, status: 422}
    end
  end

  def destroy
    if Vote.exists?(params[:id])
      vote = Vote.find(params.fetch(:id))
      vote.destroy
      render json: { response: "Vote destroyed" }
    else
      render json: { response: "Vote does not exist" }, status: 422
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:vote_type, :votable_id, :votable_type)
  end
end
