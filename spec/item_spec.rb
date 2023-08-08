require_relative "spec_helper"

describe Item do
  describe "set_up" do
    it "exists and has attributes" do
      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: '$0.50'})
      
      expect(item2).to be_a Item
      expect(item2.name).to eq("Tomato")
      expect(item2.price).to eq(0.5)
    end
  end
end
