require_relative 'app/controllers/meals_controller'
require_relative 'app/controllers/customers_controller'
require_relative 'app/controllers/sessions_controller'
require_relative 'app/controllers/orders_controller'

class Router
  def initialize(meal_repository, customer_repository, employee_repository) #, order_repository)
    @meal_repository = meal_repository
    @meals_controller = MealsController.new(@meal_repository)

    @customer_repository = customer_repository
    @customers_controller = CustomersController.new(@customer_repository)

    @employee_repository = employee_repository
    @sessions_controller = SessionsController.new(@employee_repository)

    # @order_repository = order_repository
    # @orders_controller = OrdersController.new(@order_repository)

    @running = true
  end

  def run
    @employee = @sessions_controller.verify
    while @running
      if @employee.manager?
        manager_guy
      else
        delivery_guy
      end
    end
  end


  def manager_guy
    puts '-' * 10
    puts '1. Add a meal'
    puts '2. View all meals'
    puts '3. Add a customer'
    puts '4. View all the customers'
    puts '5. View all undelivered orders'
    puts '6. Add an order for a customer and assign it to a delivery guy'
    puts '7. Exit'

    choice = gets.chomp.to_i

    case choice
    when 1
      @meals_controller.add
    when 2
      @meals_controller.list
      # @customers_controller.list
    when 3
      @customers_controller.add
      # @meals_controller.add
    when 4
      @customers_controller.list
      # @customers_controller.add
    when 5
      puts "add view of undelievered orders"
    when 6
      puts "Add an order for a customer and assign it to a delivery guy"
    when 7
      @running = false
      puts "Goodbye."
    end
  end



  def delivery_guy
   puts "What do you want to do next?"
   puts "1 - List undelivered order"
   puts "2 - Mark order as delivered"
   puts "3 - Stop and exit the program"

   choice = gets.chomp.to_i

    case choice
    when 1
      @orders_controller.add
    when 2
      @meals_controller.list
      # @customers_controller.list
    when 3
      @running = false
      puts "Goodbye."
    end
  end

end
