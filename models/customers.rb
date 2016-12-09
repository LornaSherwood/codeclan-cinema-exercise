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

  def buy_ticket
    sql = "
      SELECT f.price FROM films f
      INNER JOIN tickets t
      ON t.film_id = #{@id}
      WHERE customer_id = #{@id}
    "
    SqlRunner.run(sql)
  end




end

# sql = "
#   SELECT c.name, f.title FROM customers c
#   INNER JOIN tickets t
#   ON t.customer_id = c.id
#   INNER JOIN films f
#   ON f.id = t.film_id
#   WHERE c.id = #{@id};
# "



