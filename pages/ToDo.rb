require_relative 'base'
require 'pry'
require 'rspec/expectations'
#include RSpec::Matchers

#The Base.rb contains selenium methods and other tools that are general and non-page specific access
# to these methods are accessed using ruby's inheritance
class ToDo < Base

  #The constants below are the nouns used throughout the test to take actions against. Constants are representations of the·
  #elements on the web page under test.
 
  # ================== Page Locators =============================
  #Constants                                  #Locators
  TODO_HEADING                   = {tag_name: 'h1'}
  NEW_TASK_FIELD                 = {xpath: 'html/body/todo-app/section/header/input'}
  INSTRUCTION_TEXT               = {xpath: '//*[text()="Double-click to edit a todo"]'} 
  AUTHOR_CREDIT_TEXT             = {xpath: '//*[text()="Created by Sam Saccone and Colin Eberhardt using Angular2"]'}
  TEAM_CREDIT_TEXT               = {xpath: '//*[text()="Part of TodoMVC"]'}
  COMPLETE_TOGGLE                = {class: 'toggle-all'}
  TASKS_CHECK_BOX                = {class: 'toggle'}
  ITEMS_LEFT                     = {class: 'todo-count'}
  CLEAR_COMPLETE                 = {class: 'clear-completed'}
  NEW_TASK_ITEM                  = {css: '.view>label'}
  TASK_IN_EDIT_MODE              = {class: 'edit'}
  DIRTY_TASK_FIELD               = {css: '.new-todo.ng-valid.ng-touched.ng-dirty'}
  TRY_THIS                       = {tag_name: 'label'}
 # DESTROY                       = {class: 'destroy'}
  DESTROY                        = {xpath: 'html/body/todo-app/section/section/ul/li[1]/div/button'}

  def initialize(driver)
    @driver = driver
    # Navagate to http://todomvc.com/examples/angular2/
    visit  '/'
  end

  def maximize_current_window
    maximize_window
  end

  # There are 3 basic actions in this test displayed?, send_keys and a click all of which takes action
  ## against constant which are representations of the html locators.

  ### display? -- Verifies that the element represented by the constant is present and returns a boolean (true
  ### if the element exists and false if it doesn't)·

  ### send_keys -- Take the text parameter that being passed and enters it into the field field, represented by the constant(s)·

  ### click -- takes the click action against the  by the constant

  #
  def todo_landing_page?
    wait_until_above_element_appears(20, TODO_HEADING)
    displayed? NEW_TASK_FIELD
    displayed? INSTRUCTION_TEXT
    #displayed? AUTHOR_CREDIT_TEXT
  end

  def verify_place_holder_text?
    compare_text('.new-todo.ng-untouched.ng-pristine.ng-valid').attribute('placeholder')
  end

  def verify_dirty_place_holder_text?
    compare_text('.new-todo.ng-valid.ng-touched.ng-dirty').attribute('placeholder')
  end

  def how_many_items_left?
    compare_text('.todo-count').text
  end

  def complete_todo_list_item
    click TASKS_CHECK_BOX
  end

  def multi_click(n)
    wait_until_above_element_appears(20,TASKS_CHECK_BOX)
    checkboxes = @driver.find_elements(TASKS_CHECK_BOX)
    checkboxes[n].click
  end

  def clear_completed_link_present?
    wait_until_above_element_appears(20, CLEAR_COMPLETE)
  end

  def new_task_item_text?(value)
    wait_until_above_element_appears(20, NEW_TASK_FIELD)
    @driver.find_elements(css: '.new-todo.ng-untouched.ng-pristine.ng-valid').select {|el| el.text == value }.first
  end

  def wait_for_new_dirty_task_item_text
    wait_until_above_element_appears(20, DIRTY_TASK_FIELD)
  end

  def new_dirty_task_item_text?(value)
    wait_until_above_element_appears(20, DIRTY_TASK_FIELD)
    @driver.find_elements(css: '.new-todo.ng-valid.ng-touched.ng-dirty').select {|el| el.text == value }.first
  end


  def is_task_created_with_correct_text(n)
    wait_until_above_element_appears(20, TRY_THIS)
    text = @driver.find_elements(TRY_THIS)[n]
    text.text
  end


  def enter_text(text)
    wait_until_above_element_appears(20, NEW_TASK_FIELD)
    send_keys(NEW_TASK_FIELD, text)
    click(NEW_TASK_FIELD)
    select_the_enter_key
    wait_until_above_element_appears(20, COMPLETE_TOGGLE )
  end

  def delete_task
    hover TASKS_CHECK_BOX
    hover TASKS_CHECK_BOX
    click DESTROY
    hover TASKS_CHECK_BOX
    click DESTROY
    hover TASKS_CHECK_BOX
    click DESTROY
  end

  def click_complete_all
    click COMPLETE_TOGGLE
  end


  def return_to_todo_and_set_to_edit_mode
    wait_until_above_element_appears(20, NEW_TASK_ITEM)
    double_click NEW_TASK_ITEM
  end

  def clear_field
    wait_until_above_element_appears(20, TASK_IN_EDIT_MODE)
    clear_text TASK_IN_EDIT_MODE
    clear_text TASK_IN_EDIT_MODE
  end

  def clear_completed
    click CLEAR_COMPLETE
  end

  def enter_new_field_value(text)
    send_keys(TASK_IN_EDIT_MODE, text)
    select_the_enter_key
    wait_until_above_element_appears(20, NEW_TASK_ITEM )
  end
 
  def select_by_tag_text(value)
    my_select.click
    my_select.find_elements( :tag_name => "label" ).find do |option|
       label.text == value
    end.click
  end
end

