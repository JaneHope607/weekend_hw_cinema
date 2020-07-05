require_relative("../db/sql_runner")

class Screening 

    attr_reader :id
    attr_accessor :film_id, :time, :seats_available

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @film_id = options['film_id'].to_i
        @time = options['time']
        @seats_available = options['seats_available'].to_i
    end

    # Create method

    def save()
        sql = "INSERT INTO screenings
        (film_id, time, seats_available)
        VALUES ($1, $2, $3)
        RETURNING id"
        values = [@film_id, @time, @seats_available]
        result = SqlRunner.run(sql, values).first
        @id = result['id'].to_i
    end

    # Read method

    def self.map_items(data)
        return data.map { |screening| Screening.new(screening) }
    end

    def self.all()
        sql = "SELECT * FROM screenings"
        screenings = SqlRunner.run(sql)
        return Screening.map_items(screenings)
    end

    # Update method

    def update()
        sql = "UPDATE screenings
        SET (film_id, time, seats_available)
        = ($1, $2, $3)
        WHERE id = $4"
        values = [@film_id, @time, @seats_available, @id]
        SqlRunner.run(sql, values) 
    end

    # Delete methods

    def delete()
        sql = "DELETE FROM screenings
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end
    
    def self.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
    end

    def capacity()
        return @seats_available >= 0
    end

    def tickets()
        sql = "SELECT * FROM tickets
        WHERE screening_id = $1"
        values = [@id]
        tickets = SqlRunner.run(sql, values)
        return Ticket.map_items(tickets)
    end

    def count_tickets_bought()
        return tickets.count()
    end

    def reduce_seats()
        return @seats_available -= count_tickets_bought
    end

    def film_price()
        sql = "SELECT * FROM films
        WHERE id = $1"
        values = [@film_id]
        films = SqlRunner.run(sql, values)
        result = Film.map_items(films).first
        return result.price.to_i
    end

    def film_title()
        sql = "SELECT * FROM films
        WHERE id = $1"
        values = [@film_id]
        films = SqlRunner.run(sql, values)
        result = Film.map_items(films).first
        return result.title
    end


end