note
	description: "Work with sql data dase"
	author: "r.shaydulin"
	date: "$05.03.2017$"

class
	DATABASE

create
	make

feature
		-- Access
	labor_id: INTEGER
	stud_id: INTEGER
	collab_number: INTEGER

feature

	make
		local
			db: SQLITE_DATABASE
			db_insert_statement: SQLITE_INSERT_STATEMENT
			query: READABLE_STRING_8
		do
			labor_id := 1
			stud_id := 1
			collab_number := 1
			create db.make_create_read_write ("eiffel2.db")
			create db.make_open_read_write ("eiffel2.db")

			query := "PRAGMA foreign_keys=on;"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS labs (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				name TEXT NOT NULL,
				head TEXT NOT NULL,
				reporting_start STRING,
				reporting_end STRING
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS patents(
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				name TEXT NOT NULL,
				country TEXT NOT NULL,
				license STRING,
				lab_id INTEGER,
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query :="[
			CREATE TABLE IF NOT EXISTS courses (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			name TEXT,
			semester TEXT,
			lab_id INTEGER,
			uroven TEXT,
			student_number INTEGER,
			FOREIGN KEY (lab_id) REFERENCES labs(id)
			);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS students (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				name TEXT NOT NULL,
				nature_of_work TEXT,
				lab_id INTEGER,
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS reports (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				name TEXT NOT NULL,
				student_id INTEGER NOT NULL,
				lab_id INTEGER,
				FOREIGN KEY (student_id) REFERENCES students(id),
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS grants (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				project_name TEXT NOT NULL,
				granting_agency TEXT NOT NULL,
				beginning STRING NOT NULL,
				ending STRING NOT NULL,
				amount INTEGER,
				lab_id INTEGER,
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS researches(
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				beginning STRING NOT NULL,
				ending STRING NOT NULL,
				lab_id INTEGER,
				name TEXT,
				finance TEXT,
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS collabs (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				lab_id INTEGER,
				name TEXT,
				nature TEXT,
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS publications (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				lab_id INTEGER,
				name TEXT,
				type TEXT,
				begin INTEGER,
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			-------------------------------------------------

			query := "[
				CREATE TABLE IF NOT EXISTS exams (
				id INTEGER PRIMARY KEY AUTOINCREMENT,
				name TEXT,
				semester TEXT,
				lab_id INTEGER,
				kind TEXT, 
				student_number INTEGER,
				FOREIGN KEY (lab_id) REFERENCES labs(id)
				);
			]"

			create db_insert_statement.make (query, db)
			db_insert_statement.execute

			db.close
		end


feature
		--Adding lab unit
	add_to_labs(name: STRING; head: STRING; start: STRING; ending: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string,cur: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO labs (name, head) VALUES ('" + name + "','" + head + "');"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
		string := "UPDATE labs SET reporting_start = '" + start + "' WHERE head ='" + head + "';"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
		string := "UPDATE labs SET reporting_end = '" + ending + "' WHERE head ='" + head + "';"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
		create db_query.make ("SELECT last_insert_rowid();", db)
		cur := "";
		across
			db_query.execute_new as db_cursor
		loop
			cur := db_cursor.item.string_value (1)
		end
		labor_id := labor_id + 1
	end

feature
	add_to_patents(name: STRING; country: STRING; license: STRING; lab: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, temp: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT id FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    		loop
      		temp:= db_cursor.item.string_value (1)
    		end

		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO patents (name, country, license, lab_id) VALUES ('" + name + "','" + country + "','" + license + "'," + temp + ");"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute

	end




feature
		--Adding course
	add_to_courses(name: STRING; semester: STRING; level: STRING; number: INTEGER;lab: STRING_8)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, temp: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT id FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end
		print(temp)
		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO courses (name, semester, uroven, student_number, lab_id) VALUES ('" + name + "','" + semester + "','" + level + "'," + number.out + ",'" + temp + "');"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
	end

feature
		--Adding exam
	add_to_exams(name: STRING; semester: STRING; kind: STRING; number: INTEGER; lab: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, temp: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end

		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO exams (name, semester, kind, student_number, lab_id) VALUES ('" + name + "','" + semester + "','" + kind + "'," + number.out + ",'" + temp + "');"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
	end

feature
		--Adding student
	add_to_students(name: STRING; nature: STRING; lab: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, cur: STRING
		db_query: SQLITE_QUERY_STATEMENT
		temp: STRING
		do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end


		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO students (name, nature_of_work, lab_id) VALUES ('" + name + "','" + nature + "'," + temp + ");"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
		create db_query.make ("SELECT last_insert_rowid();", db)
		cur := "";
		across
			db_query.execute_new as db_cursor
		loop
			cur := db_cursor.item.string_value (1)
		end
		stud_id := stud_id + 1
	end

feature
		--Adding report
	add_to_reports(name: STRING; lab: STRING; stud: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, temp, t: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end

    	create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM students WHERE name = '" + stud + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	t:= db_cursor.item.string_value (1)
    	end

		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO reports (name, student_id, lab_id) VALUES ('" + name + "'," + t + "," + temp+ ");"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
	end

feature
		--Adding grant
	add_to_grants(project_name: STRING; granting_agency: STRING; beginning: STRING; ending: STRING; amount: INTEGER; lab: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, temp: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end

		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO grants (project_name, granting_agency, beginning, ending, amount, lab_id) VALUES ('" + project_name + "','" + granting_agency + "','" + beginning + "','" + ending + "'," + amount.out + "," + temp + ");"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
	end

feature
		--Adding research
	add_to_researches(beginning: STRING; ending: STRING; name: STRING; finance: STRING; lab: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, temp: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end

		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO researches (beginning, ending, name, finance, lab_id) VALUES ('" + beginning + "','" + ending + "','" + name + "','" + finance + "'," + temp + ");"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
	end

feature
		--Adding collab
	add_to_collabs(name: STRING; nature: STRING; lab: STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, cur, temp: STRING
		db_query: SQLITE_QUERY_STATEMENT
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end

		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO collabs (name, nature, lab_id) VALUES ('" + name + "','" + nature + "'," + temp + ");"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
		create db_query.make ("SELECT last_insert_rowid();", db)
		cur := "";
		across
			db_query.execute_new as db_cursor
		loop
			cur := db_cursor.item.string_value (1)
		end
		collab_number := cur.to_integer
	end

feature
		--Adding publicatoin
	add_to_publications(name: STRING; type: STRING; begin: STRING; lab:STRING)
	local
		db: SQLITE_DATABASE
		db_insert_statement: SQLITE_INSERT_STATEMENT
		string, temp: STRING
		db_query: SQLITE_QUERY_STATEMENT
		t: INTEGER
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + lab + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end
		t := begin.split ('.').at (3).to_integer * 10000 + begin.split ('.').at (2).to_integer * 100 + begin.split ('.').at (1).to_integer * 10
		create db.make_create_read_write ("eiffel2.db")
		string := "INSERT INTO publications (name, type, lab_id, begin) VALUES ('" + name + "','" + type + "'," + temp + ", " + t.out + ");"
		create db_insert_statement.make (string, db)
		db_insert_statement.execute
	end


-- Getters

feature

	get_student_number: STRING
	local
		db_query: SQLITE_QUERY_STATEMENT
		db: SQLITE_DATABASE
		answer: STRING
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM students;", db)
		answer:=""
		across
			db_query.execute_new as db_cursor
		loop

			answer:= db_cursor.item.string_value (1)
		end
		Result := answer
	end

feature
	get_collabs_number: STRING
	local
		db_query: SQLITE_QUERY_STATEMENT
		db: SQLITE_DATABASE
		answer: STRING
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM collabs;", db)
		answer:=""
		across
			db_query.execute_new as db_cursor
		loop

			answer:= db_cursor.item.string_value (1)
		end
		Result := answer
	end

feature
	get_all_labs: STRING
	local
		db_query: SQLITE_QUERY_STATEMENT
		db: SQLITE_DATABASE
		cur,answer: STRING
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs;", db)
		cur:=""
		answer:=""
		across
			db_query.execute_new as db_cursor
		loop

			cur:= db_cursor.item.string_value (2) + ";"
			answer:= answer + cur
		end
		Result := answer
	end


feature
  get_all_publications_by_lab_and_date(begin: STRING): STRING
  local
    db_query: SQLITE_QUERY_STATEMENT
    db: SQLITE_DATABASE
    cur,answer, temp: STRING
   	t:INTEGER
  do
  	t := begin.split ('.').at (3).to_integer * 10000 + begin.split ('.').at (2).to_integer * 100 + begin.split ('.').at (1).to_integer * 10

    create db.make_create_read_write ("eiffel2.db")
    create db_query.make ("SELECT * FROM publications WHERE begin > " + t.out + ";", db)
    cur:=""
    answer:=""
    across
      db_query.execute_new as db_cursor
    loop

      cur:= db_cursor.item.string_value (3) + ";"
      answer:= answer + cur
    end
    Result := answer
  end


feature
	get_all_courses_by_lab(name: STRING; date: STRING): STRING
	local
		db_query, db_query_second: SQLITE_QUERY_STATEMENT
		db, db_second: SQLITE_DATABASE
		answer, temp, cur: STRING
	do
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + name + "';", db)
		across
      		db_query.execute_new as db_cursor
    	loop

      	temp:= db_cursor.item.string_value (1)

    	end

		cur := ""
		answer := ""
		create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM courses WHERE lab_id = '" + temp + "' AND semester = '" + date + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= db_cursor_second.item.string_value (2) + ";"
      		answer:= answer + cur
    	end
    	Result := answer
	end

feature
	get_number_of_supervised_students_by_lab(name: STRING): STRING
	local
		db_query, db_query_second: SQLITE_QUERY_STATEMENT
		db, db_second: SQLITE_DATABASE
		answer, temp, cur: STRING
		t: INTEGER
	do
		temp  := ""
		answer := ""
		cur := ""
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + name + "';", db)

		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end

		create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM students WHERE lab_id = '" + temp + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= db_cursor_second.item.string_value (2) + ";"
      		answer:= answer + cur
    	end
		t := answer.split (';').count - 1
    	Result := t.out
	end


feature
	get_number_of_collabs_by_lab(name: STRING): STRING
	local
		db_query, db_query_second: SQLITE_QUERY_STATEMENT
		db, db_second: SQLITE_DATABASE
		answer, temp, cur: STRING
		t: INTEGER
	do
		temp  := ""
		answer := ""
		cur := ""
		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + name + "';", db)

		across
      		db_query.execute_new as db_cursor
    		loop
      		temp:= db_cursor.item.string_value (1)
    		end

		create db_second.make_create_read_write ("eiffel2.db")
    		create db_query_second.make ("SELECT * FROM collabs WHERE lab_id = '" + temp + "';", db_second)

    		across
    		db_query_second.execute_new as db_cursor_second
    		loop
    		cur:= db_cursor_second.item.string_value (3) + ";"
      		answer:= answer + cur
    		end
		t := answer.split (';').count - 1
    	Result := t.out
	end

feature
	get_cumulative_info_by_lab(name: STRING): STRING
	local
		db_query, db_query_second: SQLITE_QUERY_STATEMENT
		db, db_second: SQLITE_DATABASE
		answer, temp, cur: STRING
	do
		temp := ""
		answer := ""
		cur := ""

		create db.make_create_read_write ("eiffel2.db")
		create db_query.make ("SELECT * FROM labs WHERE name = '" + name + "';", db)

		across
      		db_query.execute_new as db_cursor
    	loop
      	temp:= db_cursor.item.string_value (1)
    	end

	---------------------------------------------------------------------------------------------------------	
		answer := answer + "Courses taught by this laboratory: "
		create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM courses WHERE lab_id = '" + temp + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= db_cursor_second.item.string_value (2) + ";"
      		answer:= answer + cur
    	end
    ---------------------------------------------------------------------------------------------------------
    	answer := answer + "</br>Examnations by this laboratory:  "
    	create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM exams WHERE lab_id = '" + temp + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= db_cursor_second.item.string_value (2) + ";"
      		answer:= answer + cur
    	end
	---------------------------------------------------------------------------------------------------------
		answer := answer + "</br>Reports made by this laboratory: "
		create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM reports WHERE lab_id = '" + temp + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= db_cursor_second.item.string_value (2) + ";"
      		answer:= answer + cur
    	end
	---------------------------------------------------------------------------------------------------------
		answer := answer + "</br>Researches made by this laboratory: "
		create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM researches WHERE lab_id = '" + temp + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= db_cursor_second.item.string_value (5) + " financed by " + db_cursor_second.item.string_value (6) + ";"
      		answer:= answer + cur
    	end
	---------------------------------------------------------------------------------------------------------
		answer := answer + "</br>Information about patents and licenses: "
		create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM patents WHERE lab_id = '" + temp + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= "Name of patent '" + db_cursor_second.item.string_value (2) + "' country of patent '" + db_cursor_second.item.string_value (3) + "' license title '" + db_cursor_second.item.string_value (4) + "';"
      		answer:= answer + cur
    	end
	---------------------------------------------------------------------------------------------------------
		answer := answer + "</br>Information about grants: "
		create db_second.make_create_read_write ("eiffel2.db")
    	create db_query_second.make ("SELECT * FROM grants WHERE lab_id = '" + temp + "';", db_second)

    	across
    		db_query_second.execute_new as db_cursor_second
    	loop
    		cur:= "project name is '" + db_cursor_second.item.string_value (2) + "' granted by '" + db_cursor_second.item.string_value (3) + "' in amount of " + db_cursor_second.item.string_value (6) +  ";"
      		answer:= answer + cur
    	end


		Result := answer
	end

end
