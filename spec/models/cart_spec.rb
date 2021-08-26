require 'rails_helper'

RSpec.describe Cart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe "#add_product" do
  context "adding unique products" do
    before do
      cart.add_product(book_one).save!
      cart.add_product(book_two).save!
    end

    it "has two line items" do
      expect(cart.line_items.size).to eq(2)
    end
    it "has a total price of the two items' price" do
      expect(cart.total_price).to eq(book_one.price + book_two.price)
    end
  end

  context "adding duplicate products" do
    before do
      cart.add_product(book_one).save!
      cart.add_product(book_one).save!
    end

    it "has one line item" do
      expect(cart.line_items.size).to eq(1)
    end
    it "has a line item with a quantity of 2" do
      expect(cart.line_items.first.quantity).to eq(2)
    end
    it "has a total price of twice the product's price" do
      expect(cart.total_price).to eq(book_one.price * 2)
    end
  end