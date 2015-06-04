class LineItemsController < ApplicationController

  def delete
    
  end

  def destroy
    LineItem.find(params[:id]).destroy
    redirect_to cart_path, notice: 'Item successfully removed'
  end

end
