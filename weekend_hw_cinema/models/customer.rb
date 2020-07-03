require_relative("../db/sql_runner")

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def intialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
        @funds = options['funds'].to_i
    end

end