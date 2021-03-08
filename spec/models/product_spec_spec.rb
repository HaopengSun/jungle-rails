require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should be valid if all conditions are satisfied" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "test", price_cents: 100, quantity: 3, :category => @category)
      @product.valid?
      expect(@product.errors).not_to include("can\'t be blank")
    end

    it "should be invalid if the name is missing" do
      @category = Category.new(name: "test")
      @product = Product.new(price_cents: 100, quantity: 3, :category => @category)
      @product.valid?
      expect(@product.errors[:name]).to include("can\'t be blank")
    end

    it "should be invalid if the price_cents is missing" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "test", quantity: 3, :category => @category)
      @product.valid?
      expect(@product.errors[:price_cents]).to include("is not a number")
    end

    it "should be invalid if the name is missing" do
      @category = Category.new(name: "test")
      @product = Product.new(price_cents: 100, name: "test",  :category => @category)
      @product.valid?
      expect(@product.errors[:quantity]).to include("can\'t be blank")
    end

    it "should be invalid if the name is missing" do
      @product = Product.new(price_cents: 100, quantity: 3, name: "test")
      @product.valid?
      expect(@product.errors[:category]).to include("can\'t be blank")
    end
  end
end
