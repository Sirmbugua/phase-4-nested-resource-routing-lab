# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :set_user

  def index
    items = @user.items
    render json: items
  end

  def show
    item = @user.items.find(params[:id])
    render json: item
  end

  def create
    item = @user.items.create(item_params)
    if item.valid?
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end
end
