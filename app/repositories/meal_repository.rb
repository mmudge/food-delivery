require 'csv'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @next_id = 1
    @meals = []

    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def add(meal)
    meal.id = @next_id
    @next_id += 1

    @meals << meal
    save_to_csv
  end

  def find(id)
    return @meals.find { |meal| id == meal.id }
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file_path, csv_options) do |row|
      meal = Meal.new(
        id:       row[:id].to_i,
        name:     row[:name],
        price:    row[:price].to_i
      )
      @meals << meal
      # puts "ID is #{row[:id]}A #{row[:name]} costs $ #{row[:price]}."
    end

    @next_id = @meals.last.id + 1 unless @meals.empty?
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'price']

      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
