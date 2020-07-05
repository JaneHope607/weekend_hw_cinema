require_relative("../db/sql_runner")

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @funds = options['funds'].to_i
    end

    def save()
        sql = "INSERT INTO customers
        (name, funds)
        VALUES ($1, $2)
        RETURNING id"
        values = [@name, @funds]
        result = SqlRunner.run(sql, values).first
        @id = result['id'].to_i
    end

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

    def self.all()
        sql = "SELECT * FROM customers"
        customer_list = SqlRunner.run(sql)
        return Customer.map_items(customer_list)
    end

    def update()
        sql = "UPDATE customers
        SET (name, funds)
        = ($1, $2)
        WHERE id = $3"
        values = [@name, @funds, @id]
        SqlRunner.run(sql, values)
    end

    def films()
        sql = "SELECT films.* FROM films
        INNER JOIN tickets ON
        tickets.film_id = films.id
        WHERE customer_id = $1"
        values = [@id]
        films = SqlRunner.run(sql, values)
        return Film.map_items(films)
    end

    def self.map_items(data)
        return data.map { |customer| Customer.new(customer) }
    end

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

    def remove_funds(film)
        return @funds -= film.price.to_i
    end

    def sufficient_funds?(film)
        return @funds >= film.price.to_i
    end

    def buy_ticket(film)
        return if !sufficient_funds?(film)
        new_ticket = Ticket.new({ 'customer_id' => @id, 'film_id' => film.id })
        new_ticket.save()
        remove_funds(film)
        update()
    end

end