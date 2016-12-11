require('minitest/autorun')
require('minitest/rg')
require_relative('../models/customers.rb')


class CustomerSpec < Minitest::Test

  # def test_ticket_reduces_funds
  #   customer1 = Customer.new({ 'name' => 'Matthew', 'funds' => 50 })
  #   customer1.save
  #   film1 = Film.new({ 'title' => 'Jaws', 'price' => 9 })
  #   film1.save
  #   customer1.buy_ticket(film1)
  #   customer1.update
  #   assert_equal(41, customer1.funds)
  # end

  def test_can_buy_tickets
    customer1 = Customer.new({ 'name' => 'Matthew', 'funds' => 50 })
    customer1.save
    film1 = Film.new({ 'title' => 'Jaws', 'price' => 9 })
    film2 = Film.new({ 'title' => 'Jurassic Park', 'price' => 8 })
    film2.save
    film1.save
    prices = customer1.buy_tickets
    customer1.pay_ticket(prices)
    customer1.update
    assert_equal(33, customer1.funds)

  end



end
