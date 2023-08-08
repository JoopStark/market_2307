require "pry"
class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.select { |vendor| vendor.inventory.include?(item) }
  end

  def sorted_item_list
    sorted_item_list_objects_keys.map { |item_objects| item_objects.name }.sort
  end

  def sorted_item_list_objects_keys
    @vendors.flat_map do |vendor| 
      vendor.inventory.keys
    end.uniq
  end

  def total_inventory
    hash = {}
    sorted_item_list_objects.each do |item, amount|
       hash[item] = {quantity: amount, vendors: vendors_that_sell(item) }
    end
    hash
  end

  def sorted_item_list_objects
    item_hash = Hash.new(0)
    @vendors.each do |vendor| 
      item_hash.merge!(vendor.inventory)
    end
    item_hash
  end

  def overstocked_items
    total_inventory.select do |item, hash|
      hash[:quantity] > 50 && hash[:vendors].count > 1
    end.keys
  end







end


