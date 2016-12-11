require_relative("../db/sql_runner")
require_relative( "./films" )

class Customer

  attr_reader :id
  attr_accessor :funds, :name

  def initialize(options)
    @id = options['id'].to_i unless options['id'].nil?
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "
      INSERT INTO customers ( name, funds )
      VALUES ('#{@name}', #{funds})
      RETURNING id;
      "
    customer = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM customers;"
    SqlRunner.run( sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return Customer.get_many(sql)
  end

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    customers_objects = customers.map { |loc| Customer.new(loc)}
    return customers_objects
  end

  def show_films
    sql = "SELECT films.* FROM films
    INNER JOIN tickets t
    ON t.film_id = films.id
    WHERE customer_id = #{@id};"

    return Film.get_many( sql )
  end

  def update
    sql = "
      UPDATE customers
      SET (name, funds) = 
      ('#{@name}', #{@funds})
      WHERE id = #{@id};"
      SqlRunner.run(sql)
  end

  def buy_tickets
    sql = "
      SELECT f.price FROM films f
      INNER JOIN tickets t
      ON t.film_id = f.id
      WHERE customer_id = #{@id}
    "
    ticket_prices = SqlRunner.run(sql) #{"price"=>"9"}, {"price"=>"8"}, {"price"=>"5"}
    price_array = []
    for price in ticket_prices
      price_array << price["price"].to_i
    end
    return price_array
     # [9, 8, 5]
  end

  def pay_tickets(prices) #prices is result of .buy_tickets
     for price in prices
       @funds = @funds - price
     end
  end

  def count_tickets
    return show_films.count
  end




end




