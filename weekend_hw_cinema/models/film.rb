require_relative("../db/sql_runner")

class Film

    attr_reader :id
    attr_accessor :title, :price

    def intialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title']
        @price = options['price'].to_i
    end

    def save()
        sql = "INSERT INTO films
        (title, price) 
        VALUES
        ($1, $2) RETURNING id"
        values = [@title, @price]
        result = SqlRunner.run(sql, values).first
        @id = result['id'].to_i
    end

end