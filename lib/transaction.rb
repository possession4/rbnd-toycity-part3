class Transaction
  attr_reader :id, :product, :customer, :transaction_type

  @@transactions = []
  @@id = 1

  def initialize(customer, product, transaction_type = "purchase")
    @id = @@id
    @@id += 1
    @customer = customer
    @product = product
    @transaction_type = transaction_type
    adjust_stock
    add_to_transactions
  end

  def self.all
    @@transactions
  end

  def self.find(id)
     @@transactions.find {|transaction| transaction.id == id} 
  end

  def self.delete(id)
     @@transactions.delete(@@transactions.find {|transaction| transaction.id == id} ) 
  end

  def self.find_transaction(options={})
    matches = @@transactions
    if options[:product_title]
      matches = matches.select {|match| match.product.title == options[:product_title]} 
    end
    if options[:customer]
      matches = matches.select {|match| match.customer.name == options[:customer]} 
    end
    if options[:id]
      matches = matches.select {|match| match.id == options[:id]} 
    end

    return matches
  end

  def self.print_transactions(transactions)
    transactions.each {|transaction| puts "ID: #{transaction.id}, Customer: #{transaction.customer.name}, Product: #{transaction.product.title}"} 
  end

  private

  def add_to_transactions
     	@@transactions << self
  end

  def adjust_stock
    if transaction_type == "purchase"
      @product.purchase_stock()
    elsif transaction_type == "return"
      @product.return_stock()
    end
  end
end