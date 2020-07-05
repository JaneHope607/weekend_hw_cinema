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

end