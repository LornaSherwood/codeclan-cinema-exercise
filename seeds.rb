require_relative( 'models/customers' )
require_relative( 'models/tickets' )
require_relative( 'models/films' )

require( 'pry' )

Customer.delete_all()
Ticket.delete_all()
Film.delete_all()

customer1 = Customer.new({ 'name' => 'Matthew', 'funds' => 50 })
customer2 = Customer.new({ 'name' => 'Rick', 'funds' => 10 })
customer3 = Customer.new({ 'name' => 'Beth', 'funds' => 60 })

customer1.save()
customer2.save()
customer3.save()


film1 = Film.new({ 'title' => 'Jaws', 'price' => 9 })
film2 = Film.new({ 'title' => 'Jurassic Park', 'price' => 8 })
film3 = Film.new({ 'title' => 'Godzilla', 'price' => 5 })
film1.save()
film2.save()
film3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket4 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id})
ticket5 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id})
ticket6 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id})
ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()















binding.pry
nil