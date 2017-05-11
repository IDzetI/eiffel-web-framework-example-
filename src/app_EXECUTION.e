note
	description: "[	This program is an example of the implementation of the questionnaire server]"
	date: "$Date: 2016-10-21 09:45:18 -0800 (Fri, 21 Oct 2016) $"

class
	APP_EXECUTION

inherit

	WSF_ROUTED_EXECUTION

create
	make

feature -- ROUTER

	bd: DATABASE

	setup_router
			-- Setup `router'
		local
			ny_hendler: MY_HANDLER
		do
			create bd.make
			create router.make (3)
			create ny_hendler.make ("www")
			ny_hendler.set_directory_index (<<"index.html">>)
			router.handle ("/test/{var}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent request_handle), Void)
			router.handle ("", ny_hendler, router.methods_get_post)
		end


	--Function for processing requests
	request_handle (req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_request: attached req
		local
			str : STRING
			l_name: READABLE_STRING_32
		do
			if attached {WSF_STRING} req.item ("var") as p_name then
				l_name := p_name.value
			end

			print (l_name)
			io.new_line

			if l_name.is_case_insensitive_equal_general ("get_labs.txt") then
				res.put_string (bd.get_all_labs)
			end

			if l_name.is_case_insensitive_equal_general ("get_students.txt") then
				get_students(req, res)
			end

			if l_name.is_case_insensitive_equal_general ("get_publications.txt") then
				res.put_string (bd.get_all_publications_by_lab_and_date ("01.01.2017"))
			end

			if l_name.is_case_insensitive_equal_general ("get_collaborations.txt") then
				get_collaborations(req, res)
			end

			if l_name.is_case_insensitive_equal_general ("get_coursesbydate.txt") then
				get_coursesbydate(req, res)
			end

			if l_name.is_case_insensitive_equal_general ("get_cumulativeinfo.txt") then
				get_cumulativeinfo(req, res)
			end

			if l_name.is_case_insensitive_equal_general ("get_allpublications.txt") then
				get_allpublications(req, res)
			end

			if l_name.is_case_insensitive_equal_general ("get_allstudents.txt") then
				get_allstudents(req,res)
			end

			if l_name.is_case_insensitive_equal_general ("admin.txt") then
				check_admin_login(req,res)
			end
		end


	check_name(req: WSF_REQUEST; res: WSF_RESPONSE):BOOLEAN
		require
			invalid_request: attached req
			invalid_name: attached req.item ("name")
		do
			Result := true;
			if req.item ("name").string_representation.same_string ("") then
				print("ERROR%N")
				res.put_string ("ERROR:You have not chose a laboratory</br>")
				Result := false
			end
		ensure
			invalid_response: attached res
		end

	check_date(req: WSF_REQUEST; res: WSF_RESPONSE):BOOLEAN
		require
			invalid_request: attached req
			invalid_date: attached req.item ("in")
		local
			s:STRING_32
		do
			Result := true
			if req.item ("in").string_representation.same_string("Spring") or
					req.item ("in").string_representation.same_string("Fall")  then
			else
				print("ERROR    You have not chosen the start date %N")
				res.put_string ("ERROR:You have not chosen the start date </br>")
				Result := false
			end
		ensure
			invalid_response: attached res
		end

	get_collaborations(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_request: attached req
			invalid_name: attached req.item ("name")
		do
			print(req.item ("name").string_representation+"%N")
			if check_name(req, res) then
				res.put_string (bd.get_collabs_number)
			end
		ensure
			invalid_response: attached res
		end

	check_admin_login(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_request: attached req
			invalid_login: attached req.item ("login")
			invalid_pass: attached req.item ("pass")
		do
			if(req.item ("login").string_representation /= "" and
				req.item ("pass").string_representation /= "")then
					res.put_string ("true")
				else
					res.put_string ("false")
				end
		ensure
			invalid_response: attached res
		end


	get_coursesbydate(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_request: attached req
			invalid_name: attached req.item ("name")
			invalid_date: attached req.item ("in")
		do
			print(req.item ("name").string_representation+"%N")
			print(req.item ("in").string_representation+"%N")
			if check_name(req, res) and check_date (req, res) then
				print(bd.get_all_courses_by_lab (req.item ("name").string_representation,
															req.item ("in").string_representation))
				res.put_string (bd.get_all_courses_by_lab (req.item ("name").string_representation,
															 req.item ("in").string_representation))
			end
		ensure
			invalid_response: attached res
		end


	get_cumulativeinfo(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_request: attached req
			invalid_name: attached req.item ("name")
		do
			print(req.item ("name").string_representation+"%N")
			if check_name(req, res) then
				res.put_string (bd.get_cumulative_info_by_lab (req.item ("name").string_representation))
			end
		ensure
			invalid_response: attached res
		end

	get_allpublications(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_request: attached req
			invalid_name: attached req.item ("in")
		do
			print(req.item ("in").string_representation+"%N")
			if req.item ("in").string_representation.has('-') then
				res.put_string (bd.get_all_publications_by_lab_and_date (revers_date (req.item ("in").string_representation)))
			else
				res.put_string ("ERROR:You have not chosen the start date </br>")
			end
		ensure
			invalid_response: attached res
		end


	revers_date(str:STRING):STRING
		require
			invalid_date: str.has ('-')
		local
			str_list: LIST[STRING]
		do
			str_list := str.split ('-')
			Result := str_list.at (str_list.count) + "." + str_list.at (str_list.count-1) + "." + str_list.at (str_list.count-2)
		ensure
			invalid_out_date: Result.has ('.')
		end


	get_students(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_request: attached req
			invalid_name: attached req.item ("name")
		do
			print(req.item ("name").string_representation+"%N")
			if check_name (req, res) then
				res.put_string (bd.get_number_of_supervised_students_by_lab (req.item ("name").string_representation))
			end
		ensure
			invalid_response: attached res
		end

	check_admin(login, pass:STRING):BOOLEAN
		require
			invalid_login: login.same_string_general ("admin")
			invalid_pass: pass.same_string_general ("admin")
		do
			Result:= true
		ensure
			Result = login.same_string_general ("admin") and pass.same_string_general ("admin")
		end

	get_allstudents(req: WSF_REQUEST; res: WSF_RESPONSE)
		do
				res.put_string (bd.get_student_number)
		ensure
			invalid_response: attached res
		end
end
