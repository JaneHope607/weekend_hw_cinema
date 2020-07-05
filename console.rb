require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()
Screening.delete_all()

customer1 = Customer.new({ 'name' => 'Darren Smith', 'funds' => '30' })
customer1.save()
customer2 = Customer.new({ 'name' => 'Jane Hope', 'funds' => '25' })
customer2.save()
customer3 = Customer.new({ 'name' => 'Louis Ross', 'funds' => '15' })
customer3.save()
customer4 = Customer.new({ 'name' => 'Jessica Joe', 'funds' => '40' })
customer4.save()


film1 = Film.new({ 'title' => 'Mulan', 'price' => '10'})
film1.save()
film2 = Film.new({ 'title' => 'Knives Out', 'price' => '12' })
film2.save()
film3 = Film.new({ 'title' => 'Dunkirk', 'price' => '8' })
film3.save()
film4 = Film.new({ 'title' => '1917', 'price' => '6' })
film4.save()

screening1 = Screening.new({ 'film_id' => film1.id, 'time' => '20:00', 'seats_available' => '25'})
screening1.save()

screening2 = Screening.new({ 'film_id' => film4.id, 'time' => '18:00', 'seats_available' => '40'})
screening2.save()

screening3 = Screening.new({ 'film_id' => film2.id, 'time' => '15:30', 'seats_available' => '55'})
screening3.save()

screening4 = Screening.new({ 'film_id' => film2.id, 'time' => '19:45', 'seats_available' => '55'})
screening4.save()

ticket1 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id, 'screening_id' => screening1.id })
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film4.id, 'screening_id' => screening2.id })
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
ticket3.save()

# customer4.delete()

# customer3.name = 'Jessica Joe'
# customer3.update()

# film1.price = '14'
# film1.update()

# screening2.time = '17:30'
# screening2.update()

binding.pry
nil
