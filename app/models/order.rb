class Order
  attr_accessor :id, :customer, :employee, :meal

  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal]
    @employee = attributes[:employee]
    @customer = attributes[:customer]
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  # def meal
  #   @meal
  # end

  # def employee
  #   @employee
  # end

  # def customer
  #   @customer
  # end

  def deliver!
    @delivered = true
    @delivered
  end
end
