module Api
  module V1
  end

  class Api::V1::ItemsController < ApplicationController
    # GET /items
    def index
      @items = Item.order(created_at: :desc)

      render json: @items
    end

    # GET /items/1
    def show
      item = Item.find_by(id: params[:id])

      if item
        render json: item
      else
        render json: { error: 'Item not found' }, status: :not_found
      end
    end

    # POST /items
    def create
      @item = Item.new(item_params)

      if @item.save
        render json: @item, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end

    # PUT /items/1/restore
    def restore
      item = Item.unscoped.find_by(id: params[:id])

      if item
        if item.deleted_at.present?
          item.restore
          render json: { message: 'Item restored successfully' }
        else
          render json: { error: 'Item is not deleted' }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Item not found' }, status: :not_found
      end
    end

    # PATCH/PUT /items/1
    def update
      if @item.update(item_params)
        render json: @item
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end

    # DELETE /items/1

    def destroy
      item = Item.unscoped.find_by(id: params[:id])
      if item
        if item.deleted_at.present?
          item.destroy!
        else
          item.soft_delete
        end
      else
        render json: { error: 'Item not found' }, status: :not_found
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name)
    end
  end
end
