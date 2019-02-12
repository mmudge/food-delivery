require_relative 'app/repositories/employee_repository.rb'
require_relative 'app/repositories/customer_repository.rb'
require_relative 'app/repositories/meal_repository.rb'
require_relative 'app/repositories/order_repository.rb'

require_relative 'app/models/employee.rb'
require_relative 'app/models/customer.rb'
require_relative 'app/models/meal.rb'
require_relative 'app/models/order.rb'
require_relative 'app/controllers/orders_controller.rb'

mike = Employee.new(id: 1, username: "Mike", password: "asdf", role: "boss")
# mike


employee_repository = EmployeeRepository.new('data/employees.csv')
customer_repository = CustomerRepository.new('data/customers.csv')
meal_repository     = MealRepository.new('data/meals.csv')
order_repository    = OrderRepository.new('data/orders.csv', meal_repository, employee_repository, customer_repository)



# # pizza = Meal.new(name: "pizza", price: 5)
# pizza = meal_repository.find(1) #Meal.new(name: "pizza", price: 5)
bob   = employee_repository.find(1) # Employee.new(username: "paul", password: "secret", role: "manager")
# mike  = customer_repository.find(1) #Customer.new(name: "mike", address: "1234")

# pizza_order = Order.new(meal: pizza, employee: bob, customer: mike, delivered: false)
# pizza_order
# p order_repository.add(pizza_order)

# # pizza = Meal.new(name: "pizza", price: 5)
# pizza = meal_repository.find(2) #Meal.new(name: "pizza", price: 5)
# bob   = employee_repository.find(2) # Employee.new(username: "paul", password: "secret", role: "manager")
# mike  = customer_repository.find(2) #Customer.new(name: "mike", address: "1234")

# burger_order = Order.new(meal: pizza, employee: bob, customer: mike, delivered: false)


# p order_repository.add(burger_order)

orders_controller = OrdersController.new(meal_repository, employee_repository, customer_repository, order_repository)

p orders_controller




# # .load_from_csv('employees.csv')

# loop do
#   puts "whats your name?"
#   username = gets.chomp

#   puts "whats your password"
#   password = gets.chomp

#   if username == "Mike" && password == "asdf"
#     puts "Welcome #{username}"
#     break
#   else
#     puts "Invalid credentials, try again."
#   end
# end


