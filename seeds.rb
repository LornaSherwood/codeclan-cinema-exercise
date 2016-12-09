require_relative( 'models/customers' )
require_relative( 'models/tickets' )
require_relative( 'models/films' )

require( 'pry' )

Customer.delete_all()
Ticket.delete_all()
Film.delete_all()

customer1 = Customer.new({ 'name' => 'Matthew', 'funds' => 50 })
customer2 = Customer.new({ 'name' => 'Rick', 'funds' => 10 })
customer1.save()
customer2.save()

film1 = Film.new({ 'title' => 'Jaws', 'price' => 9 })
film2 = Film.new({ 'title' => 'Jurassic Park', 'price' => 8 })
film1.save()
film2.save()














binding.pry
nil