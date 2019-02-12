class Employee
  attr_accessor :id, :role
  attr_reader :username, :password

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role] # manager or delivery guy
  end

  def manager?
    @role == "manager"
  end

  def delivery_guy?
    @role == "delivery_guy"
  end
end
