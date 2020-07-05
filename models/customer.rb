require_relative("../db/sql_runner")

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @funds = options['funds'].to_i
    end

    # Create method

    def save()
        sql = "INSERT INTO customers
        (name, funds)
        VALUES ($1, $2)
        RETURNING id"
        values = [@name, @funds]
        result = SqlRunner.run(sql, values).first
        @id = result['id'].to_i
    end

    # Read method

    def self.all()
        sql = "SELECT * FROM customers"
        customer_list = SqlRunner.run(sql)
        return Customer.map_items(customer_list)
    end

    # Delete methods

    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql) 
    end

    def delete()
        sql = "DELETE FROM customers
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    # Update method

    def update()
        sql = "UPDATE customers
        SET (name, funds)
        = ($1, $2)
        WHERE id = $3"
        values = [@name, @funds, @id]
        SqlRunner.run(sql, values)
    end

    # Show which films a customer has booked to see

    def films()
        sql = "SELECT films.* FROM films
        INNER JOIN tickets ON
        tickets.film_id = films.id
        WHERE customer_id = $1"
        values = [@id]
        films = SqlRunner.run(sql, values)
        return Film.map_items(films)
    end

    # Map method

    def self.map_items(data)
        return data.map { |customer| Customer.new(customer) }
    end

    # Check how many tickets bought by customer

    def tickets()
        sql = "SELECT * FROM tickets
        WHERE customer_id = $1"
        values = [@id]
        tickets = SqlRunner.run(sql, values)
        return Ticket.map_items(tickets)
    end

    def count_tickets()
        return self.tickets.count()
    end

    # Methods for buying tickets

    def remove_funds(film)
        return @funds -= film.price.to_i
    end

    def sufficient_funds?(film)
        return @funds >= film.price.to_i
    end

    def buy_ticket(film)
        return if !sufficient_funds?(film)
        return if !screening.capacity?
        remove_funds(film)
        update()
        new_ticket = Ticket.new({ 'customer_id' => @id, 'film_id' => film.id })
        new_ticket.save()
        screening.reduce_seats()
        return new_ticket
    end

end