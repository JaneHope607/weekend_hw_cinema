require_relative("../db/sql_runner")

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def intialize(options)
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
        result = SqlRunner.run(sql, values)
        @id = user['id'].to_i
    end

end