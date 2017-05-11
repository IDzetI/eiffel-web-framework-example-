note
	description: "Handl main pages"
	author: "Dzet"
	date: "$12.03.2017$"

class
	MY_HANDLER

inherit

	WSF_FILE_SYSTEM_HANDLER
		redefine
			execute
		end

create
	make

feature

	bd: DATABASE
	unit_name:STRING
	temp: PLAIN_TEXT_FILE

	check_number(str:STRING):BOOLEAN
		require
			invalid_inpt: str /= Void
		do
			Result:= str.is_number_sequence
		ensure
			Result = str.is_number_sequence
		end

	form1(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			ivalid_name: attached req.item ("unit")
			ivalid_unit_head: attached req.item ("unitHead")
		local
			unit,unit_head,unit_start_data, unit_finish_data : STRING_8
		do
			create temp.make_create_read_write ("temp")
			create unit.make_from_string (req.item ("unit").string_representation)
			create unit_head.make_from_string ( req.item ("unitHead").string_representation)
			create unit_start_data.make_from_string ( req.item ("startDate").string_representation)
			create unit_finish_data.make_from_string (req.item ("endDate").string_representation)


			temp.put_string (unit)
			temp.close

			if unit_start_data.has ('-') then
				unit_start_data := revers_data (unit_start_data)
			end
			if unit_finish_data.has ('-') then
				unit_finish_data := revers_data (unit_finish_data)
			end
			print(unit + unit_head + unit_start_data + unit_finish_data+"%N")
			bd.add_to_labs (unit, unit_head, unit_start_data, unit_finish_data)
		ensure
			valid_response: attached res
		end


	form2(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_courses_taught : attached req.item ("coursesTaught")
			invalid_report_titles : attached req.item ("reportTitles")
			invalid_student_report : attached req.item ("studentReport")
			invalid_work_nature : attached req.item ("workNature")
			invalid_students_name : attached req.item ("studentsName")
			invalid_students_exam : attached req.item ("studentsExam")
			invalid_exams : attached req.item ("exams")
			invalid_semesters_exam : attached req.item ("semestersExam")
			invalid_courses_exam : attached req.item ("coursesExam")
			invalid_students_taught : attached req.item ("studentsTaught")
			invalid_levels_taught : attached req.item ("levelsTaught")
			invalid_semesters_taught : attached req.item ("semestersTaught")
		local
			lab_name, lab_sem, lab_lvl, lab_nstud: LINKED_LIST[STRING_8]
			ex_name, ex_sem, ex_kind, ex_nstud: LINKED_LIST[STRING_8]
			student_name_sup, nature_of_work, student_name_rep, title_of_report: LINKED_LIST[STRING_8]
			buff_wt: WSF_TABLE
			i :INTEGER
		do
			create temp.make_open_read ("temp")
			temp.read_line
			create unit_name.make_from_string (temp.last_string)

			print(unit_name)
			create lab_name.make
			create lab_sem.make
			create lab_lvl.make
			create lab_nstud.make

			create ex_name.make
			create ex_sem.make
			create ex_kind.make
			create ex_nstud.make

			create student_name_sup.make
			create nature_of_work.make
			create student_name_rep.make
			create title_of_report.make


			buff_wt ?= req.item ("coursesTaught")
			across buff_wt as wt_inerator
			loop
				lab_name.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("semestersTaught")
			across buff_wt as wt_inerator
			loop
				lab_sem.extend (wt_inerator.item.string_representation)
			end
			buff_wt ?= req.item ("levelsTaught")
			across buff_wt as wt_inerator
			loop
				lab_lvl.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("studentsTaught")
			across buff_wt as wt_inerator
			loop
				lab_nstud.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("coursesExam")
			across buff_wt as wt_inerator
			loop
				ex_name.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("semestersExam")
			across buff_wt as wt_inerator
			loop
				ex_sem.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("exams")
			across buff_wt as wt_inerator
			loop
				ex_kind.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("studentsExam")
			across buff_wt as wt_inerator
			loop
				ex_nstud.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("studentsName")
			across buff_wt as wt_inerator
			loop
				student_name_sup.extend (wt_inerator.item.string_representation)
				io.new_line
			end

			buff_wt ?= req.item ("workNature")
			across buff_wt as wt_inerator
			loop
				nature_of_work.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("studentReport")
			across buff_wt as wt_inerator
			loop
				student_name_rep.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("reportTitles")
			across buff_wt as wt_inerator
			loop
				title_of_report.extend (wt_inerator.item.string_representation)
			end


			from i := 1
			until i > lab_name.count
			loop
				print(	lab_name.i_th (i).out+" "+
						lab_sem.i_th (i).out+" "+
						lab_lvl.i_th (i).out+" "+
						lab_nstud.i_th (i).out+" "+unit_name+" %N")
				bd.add_to_courses (lab_name.i_th (i), lab_sem.i_th (i), lab_lvl.i_th (i), lab_nstud.i_th (i).to_integer_32, unit_name)
				i:=i+1
			end

			from i := 1
			until i > ex_name.count
			loop
				print(	ex_name.i_th (i).out+" "+
						ex_sem.i_th (i).out+" "+
						ex_kind.i_th (i).out+" "+
						ex_nstud.i_th (i).out+" %N")
				bd.add_to_exams (ex_name.i_th (i), ex_sem.i_th (i), ex_kind.i_th (i), ex_nstud.i_th (i).to_integer_32,unit_name)
				i:=i+1
			end

			from i := 1
			until i > student_name_sup.count
			loop
				print(	student_name_sup.i_th (i).out+" "+
						nature_of_work.i_th (i).out+" %N")
				bd.add_to_students (student_name_sup.i_th (i), nature_of_work.i_th (i),unit_name)
				i:=i+1
			end

			from i := 1
			until i > student_name_rep.count
			loop
				print(	student_name_rep.i_th (i).out+" "+
						title_of_report.i_th (i).out+" %N")
						if student_name_sup.has (student_name_rep.i_th (i)) then
							bd.add_to_reports (title_of_report.i_th (i),unit_name, student_name_rep.i_th (i))
						end
				i:=i+1
			end
		ensure
			valid_response: attached res
		end


	form3(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_publications_type : attached req.item ("publicationsType")
			invalid_publications : attached req.item ("publications")
			invalid_financing : attached req.item ("financing")
			invalid_research_end : attached req.item ("researchEnd")
			invalid_research_start : attached req.item ("researchStart")
			invalid_researches_title : attached req.item ("researchesTitle")
			invalid_grants_amoun : attached req.item ("grantsAmoun")
			invalid_ending : attached req.item ("ending")
			invalid_receive : attached req.item ("receive")
			invalid_grants_agency : attached req.item ("grantsAgency")
			invalid_grants_title : attached req.item ("grantsTitle")
			invalid_publication_date: attached req.item ("publicationDate")
		local
			buff_wt: WSF_TABLE
			title_of_project, grant_agency,receiveing_date,ending_date,grant_amount: LINKED_LIST[STRING_8]
			title_of_research,research_start_date,research_end_date,source_of_financing: LINKED_LIST[STRING_8]
			title_of_publication,type_of_publications,publication_date: LINKED_LIST[STRING_8]
			i:INTEGER
		do
			create temp.make_open_read ("temp")
			temp.read_line
			create unit_name.make_from_string (temp.last_string)

			create title_of_project.make
			create grant_agency.make
			create receiveing_date.make
			create ending_date.make
			create grant_amount.make

			create title_of_research.make
			create research_start_date.make
			create research_end_date.make
			create source_of_financing.make

			create title_of_publication.make
			create type_of_publications.make
			create publication_date.make

			buff_wt ?= req.item ("grantsTitle")
			across buff_wt as wt_inerator
			loop
				title_of_project.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("grantsAgency")
			across buff_wt as wt_inerator
			loop
				grant_agency.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("receive")
			across buff_wt as wt_inerator
			loop
				receiveing_date.extend ( wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("ending")
			across buff_wt as wt_inerator
			loop
				ending_date.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("grantsAmoun")
			across buff_wt as wt_inerator
			loop
				grant_amount.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("researchesTitle")
			across buff_wt as wt_inerator
			loop
				title_of_research.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("researchStart")
			across buff_wt as wt_inerator
			loop
				research_start_date.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("researchEnd")
			across buff_wt as wt_inerator
			loop
				research_end_date.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("financing")
			across buff_wt as wt_inerator
			loop
				source_of_financing.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("publications")
			across buff_wt as wt_inerator
			loop
				title_of_publication.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("publicationsType")
			across buff_wt as wt_inerator
			loop
				type_of_publications.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("publicationDate")
			across buff_wt as wt_inerator
			loop
				if wt_inerator.item.string_representation.has ('-') then
					publication_date.extend (revers_data(wt_inerator.item.string_representation))
				end

			end

			from i := 1
			until i > title_of_project.count
			loop
				print(	title_of_project.i_th (i).out+" "+
						grant_agency.i_th (i).out+" "+
						receiveing_date.i_th (i).out+" "+
						ending_date.i_th (i).out+" "+
						grant_amount.i_th (i).out+"%N")
				bd.add_to_grants (title_of_project.i_th (i), grant_agency.i_th (i), receiveing_date.i_th (i), ending_date.i_th (i), grant_amount.i_th (i).to_integer_32,unit_name)
				i:=i+1
			end

			from i := 1
			until i > title_of_research.count
			loop
				print(	title_of_research.i_th (i).out+" "+
						research_start_date.i_th (i).out+" "+
						research_end_date.i_th (i).out+" "+
						source_of_financing.i_th (i).out+"%N")
				bd.add_to_researches (research_start_date.i_th (i), research_end_date.i_th (i), title_of_research.i_th (i), source_of_financing.i_th (i),unit_name)
				i:=i+1
			end

			from i := 1
			until i > title_of_publication.count
			loop
				print(	title_of_publication.i_th (i).out+" "+
						type_of_publications.i_th (i).out+"%N")
				bd.add_to_publications (title_of_publication.i_th (i), type_of_publications.i_th (i),publication_date.i_th (i),unit_name)
				i:=i+1
			end
		end

	form4( req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			valid_request: attached req
		local
			i:INTEGER
			buff_wt:WSF_TABLE
			patents,patents_country,licenses_granted:LINKED_LIST[STRING_8]
		do

			create temp.make_open_read ("temp")
			temp.read_line
			create unit_name.make_from_string (temp.last_string)

			create patents.make
			create patents_country.make
			create licenses_granted.make

			if attached req.item ("patents") then
				buff_wt ?= req.item ("patents")
				across buff_wt as wt_inerator
				loop
					print(wt_inerator.item.string_representation+" ")
					patents.extend (wt_inerator.item.string_representation)
				end
			end

			if attached req.item ("patentsCountries") then
				buff_wt ?= req.item ("patentsCountries")
				across buff_wt as wt_inerator
				loop
					print(wt_inerator.item.string_representation+" ")
					patents_country.extend (wt_inerator.item.string_representation)
				end
			end

			if attached req.item ("licensesGranted") then
				buff_wt ?= req.item ("licensesGranted")
				across buff_wt as wt_inerator
				loop
					licenses_granted.extend (wt_inerator.item.string_representation)
				end
			end

			if attached req.item ("patents")
					and attached req.item ("patentsCountries")
					and attached req.item ("licensesGranted") then
				from
					i:=1
				until
					i>patents.count or
					i>patents_country.count or
					i>licenses_granted.count
				loop
					bd.add_to_patents (patents.at (i),
										patents_country.at (i),
										licenses_granted.i_th (i),
										unit_name)
					i:=i+1
				end
				if  patents.count = 0 or
					patents_country.count = 0 or
					licenses_granted.count = 0 then
						bd.add_to_patents ("", "", "", unit_name)
				end
			end

			ensure
				invalid_response: attached res
		end

	form5(req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			invalid_company_name: attached req.item ("companyName")
			invalid_colloboration_nature: attached req.item ("colloborationNature")
		local
			company_name,colloboration_nature:LINKED_LIST[STRING_8]
			buff_wt: WSF_TABLE
			i:INTEGER
		do

			create temp.make_open_read ("temp")
			temp.read_line
			create unit_name.make_from_string (temp.last_string)

			create company_name.make
			create colloboration_nature.make

			buff_wt ?= req.item ("companyName")
			across buff_wt as wt_inerator
			loop
				company_name.extend (wt_inerator.item.string_representation)
			end

			buff_wt ?= req.item ("colloborationNature")
			across buff_wt as wt_inerator
			loop
				colloboration_nature.extend (wt_inerator.item.string_representation)
			end

			from i := 1
			until i > colloboration_nature.count
			loop
				bd.add_to_collabs (company_name.i_th (i),colloboration_nature.i_th (i),unit_name)
				i:=i+1
			end
		ensure
			invalid_response: attached res
		end


	execute (a_start_path: READABLE_STRING_8; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			path: STRING_32
			error : BOOLEAN
		do
			create bd.make
			create unit_name.make_empty

			if req.path_info.same_string ("/templates/form2.html") then
				form1(req,res)
			end
			if req.path_info.same_string ("/templates/form3.html") then
				form2(req,res)
			end
			if req.path_info.same_string ("/templates/form4.html") then
				form3(req,res)
			end
			if req.path_info.same_string ("/templates/form5.html") then
				form4(req,res)
			end

			if req.path_info.same_string ("/templates/form6.html") then
				form5(req,res)
			end

			create path.make_from_string (req.path_info)
			if path.starts_with_general (a_start_path) then
				path.remove_head (a_start_path.count)
			else
				check
					starts_with_base: False
				end
			end
			process_uri (path, req, res)
		end

	revers_data(str:STRING):STRING
		local
			str_list: LIST[STRING]
		do
			str_list := str.split ('-')
			Result := str_list.at (str_list.count) + "." + str_list.at (str_list.count-1) + "." + str_list.at (str_list.count-2)
		end
end
