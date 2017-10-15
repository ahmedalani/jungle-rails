class ReviewsController < ApplicationController
  before_filter :authorize

  def create
    @review = Review.new review_params
    
    @review.product_id = params[:product_id]
  
    @review.user_id = current_user.id
    
    if @review.save
      redirect_to product_path(params[:product_id])
    else 
      @product = Product.find params[:product_id]
      render "/products/show"
    end
  end 

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

  def destroy    
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy
    redirect_to :back
  end 


end
