class Api::V1::CommentsController < ApplicationController
  def index
    render json: { response: "Success",
                   data: Comment.all.sort_by { |comment| - comment.aggregate_vote_count } }
  end

  def show
    if Comment.exists?(params[:id])
      render json: { respone: "Success",
                     data: Comment.find(params.fetch(:id)) }
    else
      render json: { response: "Comment does not exist" }, status: 400
    end
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: { response: "Success",
                     data: comment}
    else
      render json: { response: "Comment could not be created",
                     data: comment.errors }
    end
  end

  def destroy
    if Comment.exists?(params[:id])
      comment = Comment.find(params.fetch(:id))
      comment.destroy
      render json: { response: "Comment destroyed" }
    else
      render json: { response: "Comment does not exist" }, status: 400
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :link_id)
  end
end
