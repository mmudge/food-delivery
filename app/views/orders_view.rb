class OrdersView

  def display_all(orders)
    orders.each do |order|
      puts "#{order.meal.name} for #{order.customer.name} is not delivered."
    end
  end

  def list_my_orders(my_list)
    my_list.each do |order|
      puts "#{order.customer.name} #{order.meal.name}"
    end
  end


  def ask_for_meal_id
    puts "What is the meal ID you want to add?"
    print "> "
    gets.chomp.to_i
  end

  def ask_for_customer_id
    puts "What is the customer ID you want to add?"
    print "> "
    gets.chomp.to_i
  end

  def ask_for_employee_id
    puts "What is the employee ID you want to add?"
    print "> "
    gets.chomp.to_i
  end

  def ask_order_id
    puts "Which order got delivered?"
    print "> "
    gets.chomp.to_i
  end

end


#customer.name meal.name
