require 'csv'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_from_csv if File.exist?(@csv_file_path)
  end

  def all_delivery_guys
    delivery_guys = []
    @employees.each do |employee|
      delivery_guys << employee if employee.role == "delivery_guy"
    end
    return delivery_guys
  end

  def find(id)
    return @employees.find { |employee| id == employee.id }
  end

  def find_by_username(username)
    # username
    return @employees.find { |employee| username == employee.username }
  end

  def load_from_csv
    options = { headers: :first_row, header_converters: :symbol }

     CSV.foreach(@csv_file_path, options) do |row|

      employee = Employee.new(
        id:         row[:id].to_i,
        username:   row[:username],
        password:   row[:password],
        role:       row[:role]
      )

      @employees << employee # (employee object)
      # puts "ID is #{row[:id]} username is #{row[:user_name]} role is #{row[:role]}."
    end
  end
end
