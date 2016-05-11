class CommentsController < ApplicationController
	before_action :authenticate_user!

	def new
		@product = Product.find(params[:product_id])
		@comment = @product.comments.new
	end

	def create
		@product = Product.find(params[:product_id])
		@comment = @product.comments.create(comment_params)
		@comment.user = current_user
		if @comment.save
			flash[:success] = "You leave a message!"
		else
			flash[:notice] = "You have to enter your message!"
		end
		redirect_to :back
	end

	private
	def comment_params
		params.require(:comment).permit(:comment, :rating)
	end

end
