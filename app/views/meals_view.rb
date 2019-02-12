class MealsView

  def display_all(meals)
    meals.each do |meal|
      # 1. BLUE with capacity of 2 beds
      puts "#{meal.name} costs #{meal.price}"
    end
  end

  def ask_user_for_meal_name
    puts "What is the name of your meal?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_meal_price
    puts "How much does your meal cost?"
    print "> "
    return gets.chomp.to_i
  end
end

