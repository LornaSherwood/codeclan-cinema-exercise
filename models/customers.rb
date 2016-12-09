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

  def buy_ticket(film)
      # works in ruby, could use sql to find film price (assuming have ticket)
     @funds = @funds - film.price
  end

  def count_tickets
    return show_films.count
  end




end




