class Item
  attr_reader :name, :price

  def initialize (item_data)
    @item_data = item_data
    @name = item_data[:name]
    @price = format_price
  end

  def format_price
    @item_data[:price][1..-1].to_f
  end
end