require_relative "spec_helper"

describe Market do
  let (:market) {market = Market.new("South Pearl Street Farmers Market")}

  let (:vendor1) {vendor1 = Vendor.new("Rocky Mountain Fresh")}
  let (:vendor2) {vendor2 = Vendor.new("Ba-Nom-a-Nom")}
  let (:vendor3) {vendor3 = Vendor.new("Palisade Peach Shack")}

  let (:item1) {item1 = Item.new({name: 'Peach', price: "$0.75"})}
  let (:item2) {item2 = Item.new({name: 'Tomato', price: '$0.50'})}
  let (:item3) {item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let (:item4) {item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})}

  describe "set_up" do
    it "exists and has attributes" do
      expect(market).to be_a Market
      expect(market.name).to eq ("South Pearl Street Farmers Market")
      expect(market.vendors).to eq ([])
    end
  end

  describe "#add_vendors" do
    it "can add vendors" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors).to match ([vendor1, vendor2, vendor3])
    end
  end

  describe "#vendor_names" do
    it "can list the names of vendors" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendor_names).to match (["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe "#vendors_that_sell(item)" do
    it "can list items by vendor that sell them" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors_that_sell(item1)).to match ([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq ([vendor2])
    end
  end

  describe "#potential_revenue" do
    it "vendors can list total possible revenue" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(vendor1.potential_revenue).to eq (29.75)
      expect(vendor2.potential_revenue).to eq (345.00)
      expect(vendor3.potential_revenue).to eq (48.75)
    end
  end

  describe "#sorted_item_list" do
    it "gives a list of all item names in the market alphbetically" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.sorted_item_list).to eq (["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end

  describe "#total_inventory" do
    it "gives a hash that includes item name, total stock, and vendors" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      expect(market.total_inventory).to be_a Hash
    end
  end

  describe "#overstocked_items" do
    it "give an array items that are overstocked" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor1.stock(item2, 10)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor2.stock(item3, 20)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.overstocked_items).to eq ([item1])
    end

    it "give an array items that are overstocked 2" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item2, 50)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor2.stock(item3, 20)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.overstocked_items).to eq ([item1, item2])
    end
  end
end