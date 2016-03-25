require_relative "customer"
require_relative "product"

class Transaction
  attr_reader :id, :product, :customer

  @@transactions = []
  @@id = 1

  def initialize(customer, product)
    @id = @@id
    @@id += 1
    @customer = customer
    @product = product
    @product.update_stock()
    add_to_transactions
  end

  def self.all
    @@transactions
  end

  def self.find_by_id(id)
     @@transactions.find {|transaction| transaction.id == id} 
  end

  private

  def add_to_transactions
     	@@transactions << self
  end
end