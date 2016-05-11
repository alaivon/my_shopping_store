module ProductsHelper
	def render_avg_rating(product)
		product.comments.average(:rating)
	end
end
