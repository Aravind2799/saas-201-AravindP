# Please use require_relative for requiring any dependencies
 require_relative  './application'
# The Main application that will be running your code
def main_display
  puts "Please choose the action you would like to perform?" \
  "\n1. Enroll into a department" \
  "\n2. Change your department" \
  "\n3. Change your section" \
  "\n4. View details"
end

def common_question_1
  puts 'What is your name?'
end

def common_question_2
  puts "Please select your department from the given choices?" \
  "\nEEE" \
  "\nMECH" \
  "\nCSE" \
  "\nCIVIL"
end

def section_question_3
  puts "Please select your section from the given choices?" \
  "\nA" \
  "\nB" \
  "\nC" \
end

def details_view_options
  puts "Please choose the details you would like to get?" \
  "\n1. List all students in a department" \
  "\n2. List all students in a section" \
  "\n3. List details of a student"
end

application = Application.new

loop do
  main_display
  user_option = gets.chomp.to_i
  case user_option
  when 1
    common_question_1
    student_name = gets.chomp
    common_question_2
    student_dept = gets.chomp
    puts application.enroll student_name, student_dept
  when 2
    common_question_1
    student_name = gets.chomp
    common_question_2
    student_dept = gets.chomp
    puts application.change_dept student_name, student_dept
  when 3
    common_question_1
    student_name = gets.chomp
    section_question_3
    section = gets.chomp
    puts application.change_section student_name, section
  when 4
    details_view_options
    selected_view = gets.chomp.to_i
    case selected_view
    when 1
      common_question_2
      student_dept = gets.chomp
      puts application.department_view student_dept
    when 2
      common_question_2
      student_dept = gets.chomp
      section_question_3
      section = gets.chomp
      puts papplication.section_view student_dept, section
    when 3
      common_question_1
      student_name = gets.chomp
      puts application.student_details student_name
    end
  end
  puts 'Press any key to go back'
  gets
end
