require_relative("../db/sql_runner")

class Screening 

    attr_reader
    attr_accessor

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @film_id = options['film_id'].to_i
        @time = options['time']
        @seats_available = options['seats_available'].to_i
    end

end