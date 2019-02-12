require_relative '../views/customers_view.rb'
require_relative '../models/customer.rb'
require_relative '../repositories/customer_repository.rb'


class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomersView.new
  end

  def list
    customers = @customer_repository.all
    @view.display_all(customers)
  end

  def add
    name = @view.ask_user_for_customer_name
    address = @view.ask_user_for_customer_address
    customer = Customer.new({name: name, address: address})
    @customer_repository.add(customer)
  end
end


