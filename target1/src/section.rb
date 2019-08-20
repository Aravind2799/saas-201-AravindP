#Section Class
class Section

	attr_accessor :total_students
	attr_accessor :prefix_acronym
	attr_reader :studentlist

	def initialize(prefix_acronym)
    self.total_students=0
    self.prefix_acronym=prefix_acronym
    @studentlist={}
  end

  def enroll(student_name)
  	@total_students+=1

  	#Adding new student, sorting and reassigning roll_numbers
    #Details are stored in a hash where all keys are names and values are corresponding roll numbers
  	names=@studentlist.keys #Store all names in a temporary array called names
  	names<<student_name #Add newname to ths names array
  	names.sort! #Sort this array alphabetically
  	rno=1
  	@studentlist={} #Clear the hash
    #Insert all the names as key (now present in the sorted order) and assign them new roll numbers as values in the same hash.
  	names.each do |key|
  		if(rno<10)
  			@studentlist.merge!({key=>@prefix_acronym+"0"+rno.to_s}) #If number is single digit, add 0 before it.
  		else
  			@studentlist.merge!({key=>@prefix_acronym+rno.to_s})
  		end

  		rno+=1
  	end
  	return "Your roll number is #{@studentlist[student_name]}"		
  end

   def remove(student_name)
    #If student is present in this section delete his record
  	if(@studentlist.keys.include? student_name)
  		@studentlist.delete(student_name)

      #Create temporary array names consisting names of remaining students.
  		names=@studentlist.keys
  		rno=1
      # Clear the hash, loop through names array (this does not contain the deleted name now) and insert it in the studentlist hash with new roll numbers as values.
  		@studentlist={}
  		names.each do |key|
  			if(rno<10)
  				@studentlist.merge!({key=>prefix_acronym+"0"+rno.to_s})
  			else
  				@studentlist.merge!({key=>prefix_acronym+rno.to_s})
  			end

  			rno+=1
  		end
  		@total_students-=1
  	end	
  end

  def sec_view
    #Return name and roll number details of all students in this section
  	@retstring = ""
  	@studentlist.each do |key,value|
  		@retstring = @retstring + "#{key} - #{value}" + "\n"
  	end
  	return @retstring
  end

  def student_details(student_name)
    #If student is present inside the studentlist, print his/her details
  	@retstring=""
  	if(@studentlist.keys.include? student_name)
  		@retstring = "Section "+prefix_acronym[3] + " - #{@studentlist[student_name]}" 
  		return @retstring
  	else
  		return "Not found"
  	end	
  end

end