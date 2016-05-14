require_relative 'spec_helper'
require_relative '../pages/ToDo.rb'

describe 'Task Test' do

    before(:each) do
      @todo = ToDo.new(@driver)
    end

    it 'Add Task ToDo' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      @todo.enter_text('My first task')
      expect(@todo.is_task_created_with_correct_text(0)).to eq('My first task')
      expect(@todo.how_many_items_left?).to eql('1 item left')
    end

    it 'Complete a ToDo task' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      @todo.enter_text('COMPLETE_TASK1')
      expect(@todo.is_task_created_with_correct_text(0)).to eq('COMPLETE_TASK1')
      @todo.complete_todo_list_item
      expect(@todo.clear_completed_link_present?).to equal(true)
      expect(@todo.how_many_items_left?).to eql('0 items left')
    end

    it 'Edit a ToDo task' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      @todo.enter_text('I will return and edit')
      expect(@todo.is_task_created_with_correct_text(0)).to eq('I will return and edit')
      expect(@todo.how_many_items_left?).to eql('1 item left')
      @todo.return_to_todo_and_set_to_edit_mode
      @todo.clear_field
      @todo.enter_new_field_value('Returned!!')
      expect(@todo.is_task_created_with_correct_text(0)).to eq('Returned!!')
    end

    it 'Add Multiple Tasks' do
    expect(@todo.todo_landing_page?).to be_truthy
    expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
    @todo.enter_text('Apple')
    expect(@todo.is_task_created_with_correct_text(0)).to eq('Apple')
    expect(@todo.how_many_items_left?).to eql('1 item left')
    expect(@todo.todo_landing_page?).to be_truthy
    @todo.enter_text('Pear')
    expect(@todo.is_task_created_with_correct_text(1)).to eq('Pear')
    expect(@todo.how_many_items_left?).to eql('2 items left')
    expect(@todo.todo_landing_page?).to be_truthy
    @todo.enter_text('Jam')
    expect(@todo.is_task_created_with_correct_text(2)).to eq('Jam')
    expect(@todo.how_many_items_left?).to eql('3 items left')
    expect(@todo.todo_landing_page?).to be_truthy
    @todo.enter_text('eggs')
    expect(@todo.is_task_created_with_correct_text(3)).to eq('eggs')
    expect(@todo.how_many_items_left?).to eql('4 items left')
    expect(@todo.todo_landing_page?).to be_truthy
    @todo.enter_text('bacon')
    expect(@todo.is_task_created_with_correct_text(4)).to eq('bacon')
    expect(@todo.how_many_items_left?).to eql('5 items left')
    expect(@todo.todo_landing_page?).to be_truthy
    @todo.enter_text('beans')
    expect(@todo.is_task_created_with_correct_text(5)).to eq('beans')
    expect(@todo.how_many_items_left?).to eql('6 items left')
    expect(@todo.todo_landing_page?).to be_truthy

    end
    it 'Complete Multiple Tasks' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      @todo.enter_text('Dog')
      expect(@todo.is_task_created_with_correct_text(0)).to eq('Dog')
      @todo.complete_todo_list_item
      expect(@todo.todo_landing_page?).to be_truthy
      @todo.enter_text('CAT')
      expect(@todo.is_task_created_with_correct_text(1)).to eq('CAT')
      @todo.multi_click(1)
      expect(@todo.clear_completed_link_present?).to be_truthy
      expect(@todo.how_many_items_left?).to eql('0 items left')
      expect(@todo.todo_landing_page?).to be_truthy
      @todo.enter_text('Bear')
      expect(@todo.is_task_created_with_correct_text(2)).to eq('Bear')
      expect(@todo.how_many_items_left?).to eql('1 item left')
      expect(@todo.todo_landing_page?).to be_truthy
      @todo.enter_text('Cow')
      expect(@todo.is_task_created_with_correct_text(3)).to eq('Cow')
      expect(@todo.how_many_items_left?).to eql('2 items left')
      expect(@todo.todo_landing_page?).to equal(true)
      @todo.multi_click(3)
      expect(@todo.clear_completed_link_present?).to be_truthy
      @todo.multi_click(1)
    end

    it 'Delete tasks' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      @todo.enter_text('movies')
      expect(@todo.is_task_created_with_correct_text(0)).to eq('movies')
      @todo.enter_text('Park')
      @todo.enter_text('church')
      expect(@todo.is_task_created_with_correct_text(2)).to eq('church')
      @todo.multi_click(0)
      @todo.enter_text('home')
      @todo.delete_task
      expect(@todo.how_many_items_left?).to eql('1 item left')
    end

    it 'Complete ALL Tasks' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      @todo.enter_text('AAA')
      @todo.enter_text('BBB')
      @todo.enter_text('CCC')
      @todo.enter_text('DDD')
      expect(@todo.how_many_items_left?).to eql('4 items left')
      @todo.click_complete_all
      expect(@todo.how_many_items_left?).to eql('0 items left')
      expect(@todo.clear_completed_link_present?).to eql true
      @todo.click_complete_all
      expect(@todo.how_many_items_left?).to eql('4 items left')
      @todo.click_complete_all
      expect(@todo.how_many_items_left?).to eql('0 items left')
    end

    it 'Clear ALL Complete Tasks' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      @todo.enter_text('AAA')
      @todo.enter_text('BBB')
      @todo.enter_text('CCC')
      @todo.enter_text('DDD')
      @todo.enter_text('EEE')
      @todo.enter_text('FFF')
      @todo.enter_text('GGG')
      @todo.enter_text('HHH')
      @todo.enter_text('III')
      @todo.enter_text('JJJ')
      expect(@todo.how_many_items_left?).to eql('10 items left')
      @todo.click_complete_all
      @todo.clear_completed
      @todo.wait_for_new_dirty_task_item_text
      @todo.enter_text('AAA')
      @todo.enter_text('BBB')
      @todo.enter_text('CCC')
      @todo.enter_text('DDD')
      @todo.enter_text('EEE')
      @todo.enter_text('FFF')
      @todo.enter_text('GGG')
      @todo.enter_text('HHH')
      @todo.enter_text('III')
      @todo.enter_text('JJJ')
      expect(@todo.how_many_items_left?).to eql('10 items left')
    end

    it '100 Tasks' do
      expect(@todo.todo_landing_page?).to be_truthy
      expect(@todo.verify_place_holder_text?).to eql('What needs to be done?')
      $i =0
      $m =5
      $num = 100

      while $i < $num do
        @todo.enter_text("Load = #$i")
        $i +=1
      end

      while $m < $num do
        @todo.multi_click($m)
        $m +=5
      end
      expect(@todo.how_many_items_left?).to eql('81 items left')
    end


  end
