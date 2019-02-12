require_relative '../views/meals_view.rb'
require_relative '../models/meal.rb'
require_relative '../repositories/meal_repository.rb'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def list
    meals = @meal_repository.all
    @view.display_all(meals)
  end

  def add
    name = @view.ask_user_for_meal_name
    price = @view.ask_user_for_meal_price
    meal = Meal.new({name: name, price: price})
    @meal_repository.add(meal)
  end
end
