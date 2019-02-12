require 'csv'

class CustomerRepository
  def initialize(csv_file_path) #, meal_repository)
    @csv_file_path = csv_file_path
    @next_id = 1
    @customers = []

    load_from_csv if File.exist?(@csv_file_path)

    # @meal_repository = meal_repository
  end

  def all
    @customers
  end

  def find(id)
    return @customers.find { |customer| id == customer.id }
  end

  def add(customer)
    customer.id = @next_id
    @next_id += 1

    @customers << customer
    save_to_csv
  end


  def load_from_csv
    options = { headers: :first_row, header_converters: :symbol }

     CSV.foreach(@csv_file_path, options) do |row|

      customer = Customer.new(
        id:       row[:id].to_i,
        name:     row[:name],
        address:  row[:address]
      )

      # meal_id = row[:meal_id].to_i
      # meal    = @meal_repository.find(meal_id)
      # meal.add(customer)
      @customers << customer # (Patient object)
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'address'] #, 'meal_id']

      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address] #, customer.meal.id]
      end
    end
  end
end

# def load_from_csv
#     options = { headers: :first_row, header_converters: :symbol }

#     CSV.foreach(@csv_file, options) do |row|
#       # row => CSV::Row > patient

#       # p row
#       # <CSV::Row id:"1" name:"Frank" illness:"cold" cured:"true" room_id:"1">

#       patient = Patient.new(
#         id:       row[:id].to_i,
#         name:     row[:name],
#         illness:  row[:illness],
#         cured:    row[:cured] == 'true' # (Boolean)
#         # room: row[:room_id] # NOPE! because we want a Room object
#       )

#       # row[:room_id] (String) > Room object
#       room_id = row[:room_id].to_i
#       room    = @room_repository.find(room_id)
#       room.add_patient(patient)

#       @patients << patient # (Patient object)
#     end
#   end

#   def save_to_csv
#     CSV.open(@csv_file, 'wb') do |csv|
#       csv << ['id', 'name', 'illness', 'cured', 'room_id']

#       @patients.each do |patient|
#         csv << [patient.id, patient.name, patient.illness, patient.cured?, patient.room.id]
#       end
#     end
#   end
# end


