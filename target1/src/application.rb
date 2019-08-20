# Include other files in the same directory
#require './department' 
require_relative './department'

# Your application
class Application
  attr_accessor :departments
  @department_names

  def initialize
  	@department_names = ['EEE', 'MECH', 'CSE', 'CIVIL']
    self.departments = @department_names.map { |dept| Department.new dept}
  end

  def enroll(student_name, student_department)
    # This is a sample implementation. you can write your own code

    #Find index of section and enroll in that department if it exists
    @index=@department_names.index(student_department)
     
    if(@index != nil)
    	return departments[@index].enroll student_name 
    else
    	return "Error: No such department exists\n\n"
    end

    #"You have been enrolled to #{student_department}" \
    #"\nYou have been allotted section C" \
    #"\nYour roll number is EEEC01"
  end

  def change_dept(student_name, student_department)
    ## write some logic to frame the string below

    #Find index of new deptartment and check if department exists
    @index=@department_names.index(student_department)
     
    if(@index != nil)

        #Check if any more seats are available in the department
        if(@departments[@index].total_students<30)

            if(@departments[@index].students.include? student_name)
                return "Error: The student is already in this department"
            end

    	   @retstring=""
    	   @departments.each do |dept|
    		  @retstring=dept.remove student_name
    		  break if @retstring!="Not found"
    	   end

    	   if(@retstring=="Not found")#Check if the student exists in any of the departments. If so, enroll into desired department
    		  return "Error: No such student is found\n\n"
    	   end

    	   return departments[@index].enroll student_name
        else #In case seats are filled but the student is already in the same department he/she wishes to be in
            if(@departments[@index].students.include? student_name)
                return "Error: The student is already in this department"
            else
                return "Error: There are no more seats in #{student_department}\n"
            end
        end
    else
    	return "Error: No such department exists\n\n"
    end

    #"You have been enrolled to #{student_department}" \
    #"\nYou have been allotted section B" \
    #"\nYour roll number is MECB01"
  end

  def change_section(student_name, section)
    ## write some logic to frame the string below

    #Check if student exists. If so, change his/her section in that department
    @retstring=""
    @departments.each do |dept|
    	@retstring = dept.change_section student_name, section
    	if(@retstring!="Not found")
    		return @retstring+"\n"
    	end
    end
    return "Error: No such student is found\n\n"

    #"You have been allotted section #{section}" \
    #"\nYour roll number is MECB01"
  end

  def department_view(student_dept)
    ## write some logic to frame the string below

    #Find index of that department object in the departments array and print its details
    @index=@department_names.index(student_dept)
     
    if(@index != nil)
    	return departments[@index].department_view 
    else
    	return "Error: No such department exists\n\n"
    end

    #{}"List of students:" \
    #{}"\nTom - MECB01"
  end

  def section_view(student_dept, section)
    ## write some logic to frame the string below
    
    #Find index of department, use it to access the right department object and call its section view function 
    @index=@department_names.index(student_dept)
     
    if(@index != nil)
    	return departments[@index].section_view section 
    else
    	return "Error: No such department exists\n\n"
    end

    #"List of students:" \
    #"\nTom - MECB01"
  end

  def student_details(student_name)
    ## write some logic to frame the string below
    
    #Search for student in all departments. If found, show his/her details. Else indicate that no such student was found
    @departments.each do |dept|
    	@retstring = dept.student_details student_name
    	if(@retstring!="Not found")
    		return student_name + " - " + @retstring
    	end
    end
    return "Error: No such student is found\n"

    #"Tom - MECH - Section B - MECB01"
  end
end