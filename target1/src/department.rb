#require './section'
require_relative './section'

#Department Class
class Department

  attr_accessor :sections
  attr_accessor :total_students
  attr_reader :students
  @section_names
  @dept_name
  
  def initialize(dept_name)
  	@section_names = ['A', 'B', 'C']
  	@dept_name=dept_name
    self.sections = @section_names.map { |sec| Section.new dept_name[0,3]+sec}
    self.total_students=0
    @students=[]
  end

  def enroll(student_name)
    if(@total_students<30)
      	@total_students+=1

      	#indices=[*0..2] # USE IF SECTION ALLOTTMENT SHOULD BE RANDOM : Declare temporary array which will index of sections in which availability is to be checked
        @index=0 # USE IF SECTION ALLOTTMENT SHOULD BE LIKE - FILL A, THEN FILL B, THEN FILL C : Index of section to be filled currently
      	loop do
      		#@index=indices.sample # USE IF SECTION ALLOTTMENT SHOULD BE RANDOM : Select random section index and check the availability in it. If seats are available, enroll him/her
      		if(@sections[@index].total_students<10)
      			@retstring=@sections[@index].enroll student_name
      			@retstring="You have been enrolled to #{@dept_name}\nYou have been allotted section "+@section_names[@index]+"\n"+@retstring

      			@students<<student_name
      			return @retstring
      		else
      			#indices.delete(@index) # USE IF SECTION ALLOTTMENT SHOULD BE RANDOM : Remove index from temp array if that section is filled completely
            @index+=1 # USE IF SECTION ALLOTTMENT SHOULD BE LIKE - FILL A, THEN FILL B, THEN FILL C : This section is filled, check for next section
      		end
      	end

    else
      	return "Error: There are no more seats in #{@dept_name}\n"
    end

  end

  def remove(student_name)
  	if(@students.include? student_name)
  		@students.delete(student_name)

  		@sections.each do |section|
  			section.remove student_name
  		end

  		@total_students-=1
  	else
  		return "Not found"
  	end	
  end

  def department_view
  	@retstring="List of students:\n"
  	@sections.each do |sec|
  		@retstring += sec.sec_view
  	end
  	return @retstring.chop
  end

  def section_view(section)

    #Find index of right section object in the sections array and call its section view func
  	@retstring="List of students:\n"
  	@index=@section_names.index(section)
     
    if(@index != nil)
    	@retstring += sections[@index].sec_view 
    	return @retstring.chop
    else
    	puts "Error: No such section exists\n"
    end

  end

  def student_details(student_name)

  	@retstring=""
  	if(@students.include? student_name)
  		@sections.each do |section|
  			@retstring = section.student_details student_name
  			if(@retstring!="Not found")
  				return @dept_name + " - " + @retstring
  			end
  		end  	
  	else
  		return "Not found"
  	end	
  end

  def change_section(student_name, section)
    #Check if student exists in this department
  	if((@students.include? student_name)==false)
  		return "Not found"
  	end

  	if(@section_names.include? section)
  		@index=@section_names.index(section)
  		if(@sections[@index].total_students<10) #Check if seats are available in the desired section

          if(@sections[@index].studentlist.keys.include? student_name)
            return "Error: The student is already in this section"
          end          

          #Remove existing record from the section before adding the same student in another section
          @sections.each do |sec|   
            sec.remove student_name
          end

      		@retstring=@sections[@index].enroll student_name
      		@retstring="You have been allotted section "+section+"\n"+@retstring
          return @retstring    
      else #In case seats are filled but the student is already in the same section he/she wishes to be in 
         if(@sections[@index].studentlist.keys.include? student_name)
          return "Error: The student is already in this section"
         else
          return "Error: No more seats are available in section "+section
         end
      end
  	else
  		return "Error: No such section exists"
  	end
  end

end