class CustomersView
  def display_all(customers)
    customers.each do |customer|
      # 1. BLUE with capacity of 2 beds
      puts "You are #{customer.name} and your address is #{customer.address}."
    end
  end

  def ask_user_for_customer_name
    puts "What is the customers name?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_customer_address
    puts "What is the customers address? (number)"
    print "> "
    return gets.chomp
  end
end
