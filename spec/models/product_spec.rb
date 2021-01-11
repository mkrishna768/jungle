require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with all fields" do
      @category = Category.new(name:"Appliance")
      @product = Product.new(name: "TEST", price:100, quantity:2, category:@category)
      expect(@product).to be_valid
    end
    it "is invalid without a name" do
      @category = Category.new(name:"Appliance")
      @product = Product.new(name: nil, price:100, quantity:2, category:@category)
      expect(@product).to_not be_valid
    end
    it "is invalid without a price" do
      @category = Category.new(name:"Appliance")
      @product = Product.new(name: "TEST", price:nil, quantity:2, category:@category)
      expect(@product).to_not be_valid
    end
    it "is invalid without a quantity" do
      @category = Category.new(name:"Appliance")
      @product = Product.new(name: "TEST", price:100, quantity:nil, category:@category)
      expect(@product).to_not be_valid
    end
    it "is invalid without a categor" do
      @category = Category.new(name:"Appliance")
      @product = Product.new(name: "TEST", price:100, quantity:2, category:nil)
      expect(@product).to_not be_valid
    end
  end
end
