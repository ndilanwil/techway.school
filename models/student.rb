require 'sqlite3'
require_relative 'database.rb'

$student = 'student'

class Student 
    attr_accessor :id,:name, :telphone, :email,:year, :filiere, :univ,:password

    def initialize(array)
        @id        = array[0]
        @name      = array[1]
        @telphone  = array[2]
        @email     = array[3]
        @year      = array[4]
        @filiere   = array[5]
        @univ      = array[6]
        @password  = array[7]
    end

    def to_hash
        {id: @id, name: @name, telephone: @telephone, email: @email,year: @year, filiere: @filiere,univ: @univ, password: @password}
    end

    def inspect
        %Q| <School id: "#{@id}", name: "#{@name}", telephone: "#{@telephone}",email: "#{@email}", year: "#{@year}",filiere: "#{@filiere}",univ: "#{@univ}",password: "#{@password}">|
    end

    def self.createStudent(info)
        query = <<-REQUEST
        INSERT INTO student (name,telephone,email,year,filiere,univ,password) VALUES (
            "#{info[:name]}",
            "#{info[:telephone]}",
            "#{info[:email]}",
            "#{info[:year]}",
            "#{info[:filiere]}",
            "#{info[:univ]}",
            "#{info[:password]}"
        );
        REQUEST
        Connection.new.execute(query)
    end

    def self.allStudent
        query = <<-REQUEST
            SELECT * FROM #{$student}
        REQUEST
        rows = Connection.new.execute(query)
        if rows.any?
            rows.collect do |row|
                Student.new(row)
            end
        end 
    end
=begin
    def self.findUser(userId)
        query = <<-REQUEST
            SELECT * FROM #{$student} WHERE id = #{userId};
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
    def self.updateUser(studentId, attribute, value)
        query = <<-REQUEST
            UPDATE #{$student}
            SET #{attribute} = '#{value}'
            WHERE id = #{studentId}
        REQUEST
        Connection.new.execute(query)
    end

    def self.updateP(email, value)
        query = <<-REQUEST
            UPDATE #{$student}
            SET password = '#{value}'
            WHERE email = '#{email}'
        REQUEST
    Connection.new.execute(query)
    end

    def self.deleteUser(studentId)
        query = <<-REQUEST 
            DELETE FROM #{$student}
            WHERE id = #{studentId}
        REQUEST
        Connection.new.execute(query)
    end

end

def main()
    t=Student.allStudent
    p t
end

main()
