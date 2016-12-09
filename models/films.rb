require_relative("../db/sql_runner")
require_relative("./customers")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i unless options['id'].nil?
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "
      INSERT INTO films (title, price)
      VALUES ('#{@title}', #{@price})
      RETURNING id;
    "
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM films;"
    SqlRunner.run( sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    return Film.get_many(sql)
  end

  def self.get_many(sql)
    films = SqlRunner.run(sql)
    films_objects = films.map { |loc| Film.new(loc)}
    return films_objects
  end

  def show_customers
    sql = "
      SELECT customers.* from customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE tickets.film_id = #{@id};
    "
    return Customer.get_many( sql )
  end

  def ticket_sales
    return show_customers.count
  end


end