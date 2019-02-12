require_relative '../views/orders_view'
require_relative '../models/order'
require_relative '../repositories/order_repository'

require_relative '../views/meals_view'
require_relative '../models/meal'
require_relative '../repositories/meal_repository'

require_relative '../views/customers_view'
require_relative '../models/customer'
require_relative '../repositories/customer_repository'

require_relative '../views/sessions_view'
require_relative '../models/employee'
require_relative '../repositories/employee_repository'

class OrdersController
  def initialize(meal_repository, employee_repository, customer_repository, order_repository)
    @meal_repository      = meal_repository
    @employee_repository  = employee_repository
    @customer_repository  = customer_repository
    @order_repository     = order_repository
    @view = OrdersView.new
  end

  def list_undelivered_orders
    undelivered_orders = @order_repository.undelivered_orders
    @view.display_all(undelivered_orders)
  end

  def add
    meal_id = @view.ask_for_meal_id
    meal = @meal_repository.find(meal_id)

    customer_id = @view.ask_for_customer_id
    customer = @customer_repository.find(customer_id)

    employee_id = @view.ask_for_employee_id
    employee = @employee_repository.find(employee_id)

    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.add(order)
  end

  def list_my_orders(employee)

    not_deilivered_array = @order_repository.undelivered_orders
    my_list = []
    not_deilivered_array.each do |order|
      my_list << order if order.employee == employee
    end
    @view.list_my_orders(my_list)

  end

  # def list_my_orders(employee_id)
  #   my_list = []
  #   undelivered_orders = @order_repository.undelivered_orders
  #   undelivered_orders.each do |order|
  #     my_list << order if order.employee == employee_id
  #   end
  #   @orders_view.list_my_orders(my_list)
  # end

  def mark_as_delivered(employee)
    order_id = @view.ask_order_id
    # 3. Fetch task from repo
    orders = @order_repository.undelivered_orders
    my_order = orders.find { |order| order.employee.id == employee.id && order.id == order_id }
    # 4. Mark task as done
    my_order.deliver!
    @order_repository.save_to_csv
  end
end

  # private

  # def ask_user_for_meal
  #   # MealsController.new(@meal_repository).all
  #   meal_id = @view.ask_for_meal_id
  #   @meal_repository.find(meal_id)
  # end

  # def ask_user_for_customer
  #   # CustomersController.new(@customer_repository).all
  #   customer_id = @view.ask_for_customer_id
  #   @customer_repository.find(customer_id)
  # end

  # def ask_user_for_employee
  #   # SessionsController.new(@employee_repository).all
  #   employee_id = @view.ask_for_employee_id
  #   @customer_repository.find(employee_id)
  # end

