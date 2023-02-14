require "sqlite3"

class Connection
    def new
        @db=nil
    end

    def get_connection
        if @db==nil
            @db||=SQLite3::Database.new "../controller/db.sql"          
              createdb
        end
        @db
    end
    
    def createdb
        rows=self.get_connection().execute <<-SQL
        CREATE TABLE IF NOT EXISTS school(
            id INTEGER PRIMARY KEY,
            s_name varchar(20),
            addresse varchar(20),
            locat varchar(20),
            telephone INTEGER,
            email varchar(20),
            password varchar(20)
        );
        CREATE TABLE IF NOT EXISTS teacher(
            id INTEGER PRIMARY KEY,
            name varchar(20),
            telephone INTEGER,
            email varchar(20), 
            password varchar(20)
        );
        CREATE TABLE IF NOT EXISTS student(
            id INTEGER PRIMARY KEY,
            name varchar(20),
            telephone INTEGER,
            email varchar(20),
            year INTEGER,
            filiere varchar(20),
            univ varchar(20),
            password varchar(20)
        );
        SQL
    end

    def execute(query)
        self.get_connection().execute(query)
    end
end