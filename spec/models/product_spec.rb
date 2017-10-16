require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'given a product missing a price' do 
      it 'should be invalid without price' do 
        @test_cat = Category.new
        @product = Product.new(name: 'a', quantity: 5, category: @test_cat)
        expect(@product).to_not be_valid
        expect(@product.errors.messages[:price]).to include('is not a number')
      end 
    end 
    
    context 'given a product missing a name' do 
      it 'should be invalid without name' do 
        @test_cat = Category.new
        @product = Product.new(price: 5, quantity: 5, category: @test_cat)
        expect(@product).to_not be_valid
        expect(@product.errors.messages[:name]).to include('can\'t be blank')
      end 
    end 

    context 'given a product missing a quantity' do 
      it 'should be invalid without quantity' do 
        @test_cat = Category.new
        @product = Product.new(name: 'a', price: 5, category: @test_cat)
        expect(@product).to_not be_valid
        expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
      end 
    end 

    context 'given a product missing a category' do 
      it 'should be invalid without category' do 
        @product = Product.new(name: 'a', price: 5, quantity: 5)
        expect(@product).to_not be_valid
        expect(@product.errors.messages[:category]).to include('can\'t be blank')
      end 
    end 
  end 
end
