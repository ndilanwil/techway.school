require 'sqlite3'
require_relative 'database.rb'

$teacher = 'teacher'

class Teacher 
    attr_accessor :id,:name, :telphone, :email,:password

    def initialize(array)
        @id        = array[0]
        @name      = array[1]
        @telephone = array[2]
        @email     = array[3]
        @password  = array[4]
    end

    def to_hash
        {id: @id, name: @name, telephone: @telephone, email: @email,password: @password}
    end

    def inspect
        %Q| <School id: "#{@id}", name: "#{@name}", telephone: "#{@telephone}",email: "#{@email}",password: "#{@password}">|
    end

    def self.createTeacher(info)
        query = <<-REQUEST
        INSERT INTO teacher (name,telephone,email,password) VALUES (
            "#{info[:name]}",
            "#{info[:telephone]}",
            "#{info[:email]}",
            "#{info[:password]}"
        );
        REQUEST
        Connection.new.execute(query)
    end

    def self.allTeacher
        query = <<-REQUEST
            SELECT * FROM #{$teacher}
        REQUEST
        rows = Connection.new.execute(query)
        if rows.any?
            rows.collect do |row|
                Teacher.new(row)
            end
        end 
    end
=begin
    def self.findUser(userId)
        query = <<-REQUEST
            SELECT * FROM #{$teacher} WHERE id = #{userId};
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
    def self.updateUser(teacherId, attribute, value)
        query = <<-REQUEST
            UPDATE #{$teacher}
            SET #{attribute} = '#{value}'
            WHERE id = #{teacherId}
        REQUEST
        Connection.new.execute(query)
    end

    def self.deleteUser(teacherId)
        query = <<-REQUEST 
            DELETE FROM #{$teacher}
            WHERE id = #{teacherId}
        REQUEST
        Connection.new.execute(query)
    end

end

def main()
    p Teacher.allTeacher
end

main()
