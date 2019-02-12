require 'csv'

class OrderRepository
  def initialize(csv_file_path, meal_repository, employee_repository, customer_repository)
    @csv_file_path            = csv_file_path
    @meal_repository          = meal_repository
    @employee_repository      = employee_repository
    @customer_repository      = customer_repository
    @next_id = 1


    @orders = []
    load_from_csv if File.exist?(@csv_file_path)
  end

  def undelivered_orders
    undelivered_orders = []
    @orders.each do |order|
      if order.delivered? == false
        undelivered_orders << order
      end
    end
    undelivered_orders
  end

  def find(id)
    return @orders.find { |order| id == order.id }
  end


  def add(order)
    order.id = @next_id
    @next_id += 1

    @orders << order
    save_to_csv
  end

  def load_from_csv
    options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file_path, options) do |row|

      order = Order.new(
        id:           row[:id].to_i, #id, meal, employee, customer, delivered
        delivered:    row[:delivered] == "true" # id
        )

      meal_id = row[:meal_id].to_i
      meal    = @meal_repository.find(meal_id)
      order.meal = meal

      employee_id = row[:employee_id].to_i
      employee    = @employee_repository.find(employee_id)
      order.employee = employee

      customer_id = row[:customer_id].to_i
      customer    = @customer_repository.find(customer_id)
      order.customer = customer

      @orders << order
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'employee_id', 'customer_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.employee.id, order.customer.id, order.delivered?]
      end
    end
  end
end


