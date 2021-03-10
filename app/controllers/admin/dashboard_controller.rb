class Admin::DashboardController < ApplicationController
  
  # HTTP Basic authentication
  http_basic_authenticate_with name: ENV["USERNAME"], password:ENV["PASSWORD"]

  def show
    @products_length = Product.all.length
    @categories_length = Category.all.length
  end
end
