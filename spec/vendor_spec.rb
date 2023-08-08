require_relative "spec_helper"

describe Vendor do
  let (:vendor) {vendor = Vendor.new("Rocky Mountain Fresh")}

  let (:item1) {item1 = Item.new({name: 'Peach', price: "$0.75"})}
  let (:item2) {item2 = Item.new({name: 'Tomato', price: '$0.50'})}

  describe "set_up" do
    it "exists and has attributes" do
      expect(vendor).to be_a Vendor
      expect(vendor.name).to eq("Rocky Mountain Fresh")
      expect(vendor.inventory).to eq({})
    end
  end

  describe "#check_stock and stock" do
    it "should have zero stock" do
      expect(vendor.check_stock(item1)).to eq 0
    end
    
    it "can add stock and show count" do
      expect(vendor.check_stock(item1)).to eq 0

      vendor.stock(item1, 30)
      
      expect(vendor.check_stock(item1)).to eq 30
    end
    
    it "can stock on item multiple times" do 
      vendor.stock(item1, 30)
      vendor.stock(item1, 25)
      expect(vendor.check_stock(item1)).to eq 55
    end

    it "can stock mutiple items" do
      vendor.stock(item1, 30)
      vendor.stock(item1, 25)
      vendor.stock(item2, 12)

      expect(vendor.inventory).to match (item1, item2)
    end
  end
end