class Api::V1::LinksController < ApplicationController
  def index
    render json: { response: "Success",
                   data: Link.all }
  end

  def show
    if Link.exists?(params[:id])
      render json: { respone: "Success",
                     data: Link.find(params.fetch(:id)) }
    else
      render json: { response: "Link does not exist" }, status: 400
    end
  end

  def create
    link = Link.new(link_params)
    if link.save
      render json: { response: "Success",
                     data: link}
    else
      render json: { response: "Link could not be created",
                     data: link.errors }
    end
  end

  def destroy
    if Link.exists?(params[:id])
      link = Link.find(params.fetch(:id))
      link.destroy
      render json: { response: "Link destroyed" }
    else
      render json: { response: "Link does not exist" }, status: 400
    end
  end

  private

  def link_params
    params.require(:links).permit(:url, :title)
  end
end
