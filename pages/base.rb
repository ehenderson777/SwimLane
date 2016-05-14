require 'pry'

class Base

   def initialize(driver)
     @driver = driver
   end

   def visit(url_path)
     @driver.get ENV['base_url'] + url_path
   end

   def visit_other(url_path_2)
     @driver.get ENV['base_url'] + url_path_2
   end

   def visit_every_dollar(ed_base_url_path)
     @driver.get ENV['ed_base_url'] + ed_base_url_path
   end

   def visit_smart_enroll(enroll_base_url_path)
     @driver.get ENV['enroll_base_url'] + enroll_base_url_path
   end

   def select_from_dropdown(locator, option)
     dropdown = @driver.find_elements(locator)
     select_list = Selenium::WebDriver::Support::Select.new(dropdown)
     select_list.select_by(:text, option)
   end
   
   def visit_site(url)
     @driver.get url
   end

   def find_element(locator)
     @driver.find_element locator
   end

   def close_browser
     @driver.quit
   end

   def maximize_window
     @driver.manage.window.maximize
   end

   def compare_element?(locator, text_value)
     #@driver.find_element locator ['value'].should == text_value
     #expect(@driver.find_element(locator).value).to eq text_value
      @driver.find_element(locator).text == text_value
   end

   def compare_text(css)
     #page_message = @driver.find_element(css: css).text
     @driver.find_element(:css, css)
   end

   def double_click(locator)
     dc = @driver.find_element(locator)
     @driver.action.double_click(dc).perform
   end

   def wait_until_text_pattern_appears(seconds, text)
     Selenium::WebDriver::Wait.new(timeout:seconds).until { @driver.find_element(xpath:"//*[contains(text(),'#{(text)}')]").displayed? }
   end

   def switch_to_current_window
     @driver.switch_to.window @driver.window_handles.last
   end

   def switch_to_active_window 
     @driver.switchTo().activeElement()
   end

   def click(locator)
     find_element(locator).click
   end

   def array_click(locator)
     @driver.find_elements(locator).click
   end
   def css_click(locator)
     find_element(css:locator).click
   end
   def id_click(locator)
     find_element(id:locator).click
   end

   #this is not working in SDNegEmployeeEnrollment_spec.rb in process of creating new method
   def clear(locator)
     @driver.find_element(locator).send_keys [:command, 'a'], :delete
   end

   def clear_text(locator)
     @driver.find_element(locator).clear()
   end
 
   def select_the_enter_key
     #@browser.action.send_keys("\n").perform
     @driver.action.send_keys(:enter).perform
   end


   def send_keys(locator, text)
     find_element(locator).send_keys text
   end

  # def random_name(size)
  #     charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}
  #     (size).map{ charset.to_a[rand(charset.size)] }.join
  # end

  def change_focus_to_frame_under_test(iframe_locator)
    @driver.switch_to.frame(iframe_locator)
  end

  #use in cases where there's no id or name for an iframe the index parameter is zero based
  #example: page has 2 frames and you want to access the second on, then you woule use 1
  #see used in SDAddFirm.rb
  def change_to_iframe(index)
    @driver.switch_to.frame(index)
  end

   def iterate_list_and_click(tag_name, value)
     items = @driver.find_elements(tag_name: tag_name)
     items.each do |label|
       input = @driver.find_element(id: value).click
     end
   end

   def select_item_from_an_array(items)
     @driver.find_elements(css: items)
   end

   def select_element_from_an_array(tag_name)
     list = @driver.find_elements(tag_name: tag_name)
     list[0].click
   end

  def is_element_disabled(state)
    @driver.find_elements(css: 'button[disabled=(state)]')
  end

  def displayed?(locator)
    rescue_exceptions { find_element(locator).displayed? }
  end

  def hover(locator) 
    hover = @driver.find_element(locator)
    @driver.action.move_to(hover).perform
  end

  def wait_until_above_element_appears(seconds, locator)
    Selenium::WebDriver::Wait.new(timeout:seconds).until { @driver.find_element(locator).displayed? }
  end

  def get_current_partial_web_address(url)
    @driver.current_url.include?(url)
  end

  def wait_for(seconds = 15)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end

  def validation_check(args)
     #Get local vars from hash
     expected_value = args[:expected_value]
     actual_value = args[:actual_value]
     validation_type = args[:validation_type]
     logging_option = args[:logging_option] || '' # Default
     logging_info = args[:logging_info] || '' # Default
   
     expected_value_processed = expected_value #Create a copy for processing
     actual_value_processed = actual_value #Create a copy for processing
     
 # ========== Perform 'Within' validation ========== (Begin)
      if validation_type.downcase == 'within'
 # Process values for validation
      expected_value_processed = expected_value_processed.to_s #Convert to String
      actual_value_processed = actual_value_processed.to_s #Convert to String
 # Perform validation
      result = actual_value_processed.include? expected_value_processed
 # Check validation result
      if result true
      validation_result = "[Pass] - Expected Value #{34.chr}#{expected_value}#{34.chr} == Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
      else
      validation_result = "[Fail] - Expected Value #{34.chr}#{expected_value}#{34.chr} != Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
      end
 # ========== Perform 'Within' validation ========== (End)
     elsif validation_type.downcase == 'strip'
 # Process values for validation
      expected_value_processed = expected_value_processed.to_s #Convert to String
      expected_value_processed = expected_value_processed.gsub((0.chr),'') # NULL
      expected_value_processed = expected_value_processed.gsub((9.chr),'') # Tab
      expected_value_processed = expected_value_processed.gsub((10.chr),'') # Line Feed
      expected_value_processed = expected_value_processed.gsub((13.chr),'') # Carriage Return
      expected_value_processed = expected_value_processed.gsub((32.chr),'') # Space
      expected_value_processed = expected_value_processed.gsub((44.chr),'') # Comma
      expected_value_processed = expected_value_processed.gsub((160.chr),'') # Alt Space
     
      actual_value_processed = actual_value_processed.to_s #Convert to String
      actual_value_processed = actual_value_processed.gsub((0.chr),'') # NULL
      actual_value_processed = actual_value_processed.gsub((9.chr),'') # Tab
      actual_value_processed = actual_value_processed.gsub((10.chr),'') # Line Feed
      actual_value_processed = actual_value_processed.gsub((13.chr),'') # Carriage Return
      actual_value_processed = actual_value_processed.gsub((32.chr),'') # Space
      actual_value_processed = actual_value_processed.gsub((44.chr),'') # Comma
      actual_value_processed = actual_value_processed.gsub((160.chr),'') # Alt Space
   
# Perform validation
 result = actual_value_processed.include? expected_value_processed

 # Check validation result
    if result == true
      validation_result = "[Pass] - Expected Value #{34.chr}#{expected_value}#{34.chr} == Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
    else
      validation_result = "[Fail] - Expected Value #{34.chr}#{expected_value}#{34.chr} != Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
    end
# ========== Perform 'Strip' validation ========== (End)


# ========== Perform 'Exact' validation ========== (Begin)
    elsif validation_type.downcase == 'exact'
  
 # Process values for validation
 # N/A

 # Perform validation
   result = actual_value_processed.include? expected_value_processed
   
   
   # Check validation result
   if result == true
     validation_result = "[Pass] - Expected Value #{34.chr}#{expected_value}#{34.chr} == Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
   else
     validation_result = "[Fail] - Expected Value #{34.chr}#{expected_value}#{34.chr} != Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
   end
   # ========== Perform 'Exact' validation ========== (End)

   # ========== Perform 'Empty' validation ========== (Begin)
   elsif validation_type.downcase == 'empty'

   # Process values for validation
   # N/A

   # Perform validation
   if actual_value.length == 0



      validation_result = "[Pass] - Actual Value #{34.chr}#{actual_value}#{34.chr} (empty) - Validation Type:#{validation_type}"
    else
      validation_result = "[Fail] - Actual Value #{34.chr}#{actual_value}#{34.chr} (not empty) - Validation Type:#{validation_type}"
    end
    # ========== Perform 'Empty' validation ========== (End)


    # ========== Perform 'Integer' validation ========== (Begin)
    elsif validation_type.downcase == 'integer'

    # Process values for validation
    expected_value_processed = expected_value_processed.to_i #Convert to Integer
    actual_value_processed = actual_value_processed.to_i #Convert to Integer

    # Perform validation
    result = actual_value_processed == expected_value_processed

    # Check validation result
    if result == true
      validation_result = "[Pass] - Expected Value #{34.chr}#{expected_value}#{34.chr} == Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
    else
      validation_result = "[Fail] - Expected Value #{34.chr}#{expected_value}#{34.chr} != Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
    end
    # ========== Perform 'Integer' validation ========== (End)


    # ========== Perform 'Float' validation ========== (Begin)
    elsif validation_type.downcase == 'float'

    # Process values for validation
    expected_value_processed = expected_value_processed.to_f #Convert to Float
    actual_value_processed = actual_value_processed.to_f #Convert to Float

    # Perform validation
    result = actual_value_processed == expected_value_processed

    # Check validation result
    if result == true
      validation_result = "[Pass] - Expected Value #{34.chr}#{expected_value}#{34.chr} == Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
    else
      validation_result = "[Fail] - Expected Value #{34.chr}#{expected_value}#{34.chr} != Actual Value #{34.chr}#{actual_value}#{34.chr} - Validation Type:#{validation_type}"
    end
    # ========== Perform 'Float' validation ========== (End)




    # ========== Perform 'Unknown' validation ========== (Begin)
    else
    # Process values for validation
    expected_value_processed = expected_value_processed.to_s #Convert to String
    actual_value_processed = actual_value_processed.to_s #Convert to String

    # Perform validation
    # N/A

    # Set validation result
    validation_result = "[Fail] - Expected Value #{34.chr}#{expected_value_processed}#{34.chr} ?? Actual Value #{34.chr}#{actual_value_processed}#{34.chr} - Validation Type:#{validation_type} (unknown)"
    # ========== Perform 'Unknown' validation ========== (End)
    end

    # Perform appropriate logging of results
    if logging_option.downcase == 'log'

    if validation_result[0,6].upcase == '[PASS]'
      logit(:event_status => 'Pass', :step_name => logging_info, :step_details => validation_result[9..-1]) #Log a Pass
    else
    logit(:event_status => 'Fail', :step_name => logging_info, :step_details => validation_result[9..-1]) #Log a Fail
    end

    elsif logging_option.downcase == 'stop'

    if validation_result[0,6].upcase == '[PASS]'
      logit(:event_status => 'Pass', :step_name => logging_info, :step_details => validation_result[9..-1]) #Log a Pass
    else
      logit(:event_status => 'Fail', :step_name => logging_info, :step_details => validation_result[9..-1]) #Log a Fail
    abort #Halt execution
    end

    else
    # Do not log, just return back to application
    end
    #Return results
    return validation_result

  end 
   
   
  #**********************************************************************************************************
  # Method Name: Logit
  # Description: This Method provides a simple way to make entries to the log file
  # Parameters:
  #     event_status - How to make the log entry
  #       Options:
  #         Pass = Causes the status of this step to be passed and sends the specified message to the report.
  #         Fail = Causes the status of this step to be failed and sends the specified message to the report. When this step runs, the test fails.
  #         Done = Sends a message to the report without affecting the pass/fail status of the test.
  #         Note = Adds a basic note to the log file.
  #         Warn = Sends a warning message to the report, but does not cause the test to stop running, and does not affect the pass/fail status of the test.
  #         Debug = Pauses the script execution
  #     step_name - Step name
  #     step_details - Details about this step
  # Return value:
  # Example:
  #**********************************************************************************************************
  def logit(args)

  #Get local vars from hash
    event_status = args[:event_status] || 'Note'
    step_name = args[:step_name]
    step_details = args[:step_details]

#    @logger = Logger.new('logs/LO_TestResults.txt','daily')

  #Format date
  formatter = proc do |severity, datetime, progname, msg|
   date_format = datetime.strftime("%Y-%m-%d %H:%M:%S") #Formate the date/time
   "#{date_format} #{msg}\n" #Format the log string
  end

  #Write to log file.
  if event_status.downcase == 'pass'
    error("#{step_name} [PASS] - #{step_details}")
  elsif event_status.downcase == 'fail'
    error("#{step_name} [FAIL] - #{step_details}")
  elsif event_status.downcase == 'done'
    error("#{step_name} [DONE] - #{step_details}")
  elsif event_status.downcase == 'note'
    error("#{step_name} [NOTE] - #{step_details}")
  elsif event_status.downcase == 'warn'
    error("#{step_name} [WARN] - #{step_details}")
  elsif event_status.downcase == 'debug'
    error("#{step_name} [DBUG] - #{step_details}")
  abort 'Logit sent Debug command'
  else
    info("#{step_name} [#{event_status}] - #{step_details}")
  end
end 
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   private

     def rescue_exceptions
       begin
         yield
       rescue Selenium::WebDriver::Error::NoSuchElementError
         false
       end
     end
  end

