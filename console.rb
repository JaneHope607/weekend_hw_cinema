require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

customer1 = Customer.new({ 'name' => 'Darren Smith', 'funds' => '30' })
customer1.save()
customer2 = Customer.new({ 'name' => 'Jane Hope', 'funds' => '25' })
customer2.save()
customer3 = Customer.new({ 'name' => 'Louis Ross', 'funds' => '15' })
customer3.save()

# film1 = Film.new

# film2 = Film.new

# film3 = Film.new
 
# film4 = Film.new

# ticket1 = Ticket.new

# ticket2 = Ticket.new

# ticket3 = Ticket.new

