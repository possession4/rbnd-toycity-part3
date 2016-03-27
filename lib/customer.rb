class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  def self.find_by_name(name)
     @@customers.find {|customer| customer.name == name} 
  end

  def purchase(product)
  	if product.in_stock?
  		Transaction.new(self, product)
  	else
  		raise OutofStockError, "'#{product.title}' is out of stock."
  	end
  end

  def return(id)
    return_transaction = Transaction.find(id)
    Transaction.new(self, return_transaction.product, "return")
  end

 private

  def add_to_customers
     if !@@customers.any? { |customer| customer.name == @name }
     	@@customers << self
  	else 
  		raise DuplicateCustomerError, "'#{@name}' already exists."
  	end
  end
end