require_relative '../src/application'
require 'minitest/autorun'
require 'minitest/hyper'

class FunctionDefinitionTest < Minitest::Test
  def setup
    @application = Application.new
  end

  def test_enroll_method_must_not_return_nil
    assert @application.enroll 'abc', 'EEE'
  end

  def test_change_dept_method_must_not_return_nil
    assert @application.change_dept 'abc', 'EEE'
  end

  def test_change_section_method_must_not_return_nil
    assert @application.change_section 'abc', 'EEE'
  end

  def test_department_view_method_must_not_return_nil
    assert @application.department_view 'EEE'
  end

  def test_section_view_method_must_not_return_nil
    assert @application.section_view 'EEE', 'A'
  end

  def test_student_details_view_method_must_not_return_nil
    assert @application.student_details 'abc'
  end
end

class EnrollBasicTest < Minitest::Test
  def test_enroll_into_correct_department
    application = Application.new
    out = application.enroll('arjun', 'EEE').split "\n"
    assert_equal 'You have been enrolled to EEE', out[0], 'EEE Department allocation is incorrect'
    out = application.enroll('das', 'MECH').split "\n"
    assert_equal 'You have been enrolled to MECH', out[0], 'MECH Department allocation is incorrect'
    out = application.enroll('arjun1', 'CSE').split "\n"
    assert_equal 'You have been enrolled to CSE', out[0], 'CSE Department allocation is incorrect'
    out = application.enroll('das1', 'CIVIL').split "\n"
    assert_equal 'You have been enrolled to CIVIL', out[0], 'CIVIL Department allocation is incorrect'
  end

  def test_enroll_into_correct_section
    application = Application.new
    out = application.enroll('arjun', 'EEE').split("\n")
    assert_equal 'You have been allotted section A', out[1], 'Section allocated is incorrect'
  end

  def test_generate_correct_roll_no
    application = Application.new
    out = application.enroll('arjun', 'EEE').split("\n")
    assert_equal 'Your roll number is EEEA01', out[2],  'roll number generated is incorrect'
  end
end

class ChangeDeptBasicTest < Minitest::Test
  def test_change_department
    application = Application.new
    application.enroll('arjun', 'CSE').split "\n"
    out = application.change_dept('arjun', 'EEE').split("\n")
    assert_equal 'You have been enrolled to EEE', out[0], 'EEE Department re-allocation is incorrect'
    assert_equal 'You have been allotted section A', out[1], 'Section allocated is incorrect'
    assert_equal 'Your roll number is EEEA01', out[2], 'roll number generated is incorrect'
  end
end

class ChangeSectionBasicTest < Minitest::Test
  def test_change_section
    application = Application.new
    application.enroll('arjun', 'CSE').split "\n"
    out = application.change_section('arjun', 'B').split("\n")
    assert_equal 'You have been allotted section B', out[0], 'Section allocated is incorrect'
    assert_equal 'Your roll number is CSEB01', out[1], 'roll number generated is incorrect'
  end
end

class DepartmentViewBasicTest < Minitest::Test
  def test_view_students_in_dept
    application = Application.new
    application.enroll('arjun', 'CSE')
    application.enroll('das', 'CSE')
    out = application.department_view 'CSE'
    assert_equal "List of students:\narjun - CSEA01\ndas - CSEA02", out, 'Department list is incorrect'
  end
end

class SectionViewBasicTest < Minitest::Test
  def test_view_students_in_section
    application = Application.new
    application.enroll('arjun', 'CSE')
    application.enroll('das', 'CSE')
    out = application.section_view 'CSE', 'A'
    assert_equal "List of students:\narjun - CSEA01\ndas - CSEA02", out, 'Section list is incorrect'
  end
end

class StudentDetailsBasicTest < Minitest::Test
  def test_view_student_details
    application = Application.new
    application.enroll('Arjun', 'CSE')
    out = application.student_details 'Arjun'
    assert_equal "Arjun - CSE - Section A - CSEA01", out, 'Student details are incorrect'
  end
end
