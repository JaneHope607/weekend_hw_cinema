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

    def self.map_items(data)
        return data.map { |customer| Customer.new(customer) }
    end

end