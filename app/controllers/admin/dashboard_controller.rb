class Admin::DashboardController < ApplicationController
  def show
    @products_length = Product.all.length
    @categories_length = Category.all.length
  end
end
