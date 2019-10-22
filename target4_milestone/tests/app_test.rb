ENV['APP_ENV'] = 'test'

require_relative '../src/app' # <-- your sinatra app
require 'capybara'
require 'capybara/dsl'
require 'test/unit'


class AppTest < Test::Unit::TestCase
  include Capybara::DSL
  # Capybara.default_driver = :selenium # <-- use Selenium driver

  def setup
    Capybara.app = Sinatra::Application.new
  end

  def test_it_works
    visit '/todos'
    assert page.has_content?('Todo List')
  end

  def test_it_creates
    visit '/todos'
    fill_in('title', with: 'Do Something')
    first(:button, '').click # new
    assert page.has_content?('Do Something')
    refute page.has_content?('Deadline')
  end

  def test_it_navigates
    visit '/todos'
    fill_in('title', with: 'Do Something else')
    first(:button, '').click # new
    click_link 'Do Something else'
    assert page.has_content? 'Update Todo!'
  end

  def test_it_updates
    visit '/todos'
    fill_in('title', with: 'Something updates')
    first(:button, '').click # new
    click_link 'Something updates'
    fill_in('title', with: 'Something updated')
    click_on('save changes') # new
    assert page.has_content? 'Todo List'
    assert page.has_content? 'Something updated'
  end

  def test_it_deletes
    visit '/todos'
    fill_in('title', with: 'Something is new')
    first(:button, '').click # new
    page.all("input[value='Delete']").last.click
    refute page.has_content? 'Something is new'
  end

  def test_it_creates_deadline
    visit '/todos'
    fill_in('title', with: 'Do something with deadline')
    fill_in('date', with: '2020-19-11')
    first(:button, '').click # new
    assert page.has_content?('Deadline')
    assert page.has_content?('2020-19-11')
    click_link 'Do something with deadline'
    assert page.has_content?('Deadline')
    assert page.has_content?('2020-19-11')
  end
end
