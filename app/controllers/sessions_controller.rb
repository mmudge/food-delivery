require_relative '../views/sessions_view.rb'
require_relative '../models/employee.rb'
require_relative '../repositories/employee_repository.rb'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def verify
    loop do
      username = @view.ask_username
      password = @view.ask_password

      employee = @employee_repository.find_by_username(username)

      if employee && employee.password == password
        puts "Welcome #{username}"
        return employee
        break
      else
        puts "Invalid credentials, try again."
      end
    end
  end

end
