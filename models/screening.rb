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

    def save()
        sql = "INSERT INTO screenings
        (film_id, time, seats_available)
        VALUES ($1, $2, $3)
        RETURNING id"
        values = [@film_id, @time, @seats_available]
        result = SqlRunner.run(sql, values).first
        @id = result['id'].to_i
    end

end