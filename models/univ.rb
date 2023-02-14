require 'sqlite3'
require_relative 'database.rb'

$tablename = 'school'

class School 
    attr_accessor :id,:s_name, :addresse, :locat, :telephone, :email, :password

    def initialize(array)
        @id        = array[0]
        @s_name    = array[1]
        @addresse  = array[2]
        @locat     = array[3]
        @telephone = array[4]
        @email     = array[5]
        @password  = array[6]
    end

    def to_hash
        {id: @id, s_name: @s_name, addresse: @addresse, locat: @locat, telephone: @telephone, email: @email, password: @password}
    end

    def inspect
        %Q| <School id: "#{@id}", name: "#{@s_name}", addresse: "#{@addresse}",location: "#{@locat}", telephone: "#{@telephone}", email: "#{@email}", password: "#{@password}">|
    end

    def self.createSchool(info)
        query = <<-REQUEST
        INSERT INTO school (s_name, addresse, locat,telephone, email, password) VALUES (
            "#{info[:s_name]}",
            "#{info[:addresse]}",
            "#{info[:locat]}",
            "#{info[:telephone]}",
            "#{info[:email]}",
            "#{info[:password]}"
        );
        REQUEST
        Connection.new.execute(query)
    end

    def self.allSchools
        query = <<-REQUEST
            SELECT * FROM #{$tablename}
        REQUEST
        rows = Connection.new.execute(query)
        if rows.any?
            rows.collect do |row|
                School.new(row)
            end
        end 
    end
=begin
    def self.findUser(userId)
        query = <<-REQUEST
            SELECT * FROM #{$tablename} WHERE id = #{userId};
        REQUEST
        p query
        row = Connection.new.execute(query)
        if row.any?
            User.new(row)
        else
            nil
        end
    end
=end
    def self.updateUser(schoolId, attribute, value)
        query = <<-REQUEST
            UPDATE #{$tablename}
            SET #{attribute} = '#{value}'
            WHERE id = #{userId}
        REQUEST
        Connection.new.execute(query)
    end

    def self.destroySchool(schoolId)
        query = <<-REQUEST 
            DELETE FROM #{$tablename}
            WHERE id = #{schoolId}
        REQUEST
        Connection.new.execute(query)
    end

end

def main()
    p School.allSchools
end

main()
