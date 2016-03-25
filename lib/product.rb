class Product
  attr_reader :title, :price, :stock
  attr_writer :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
     @@products.find {|product| product.title == title} 
  end

  def in_stock?
     self.stock > 0
  end

  def self.in_stock
     @@products.select {|product| product.in_stock? == true} 
  end

  def update_stock()
    @stock = @stock - 1
  end

  private

  def add_to_products
     if !@@products.any? { |product| product.title == @title }
     	@@products << self
  	else 
  		raise DuplicateProductError, "'#{@title}' already exists."
  	end
  end

end