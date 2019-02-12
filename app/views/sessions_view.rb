class SessionsView

  def ask_username
    puts "What is your username?"
    print "> "
    return gets.chomp
  end

  def ask_password
    puts "What is your password?"
    print "> "
    return gets.chomp
  end

end
