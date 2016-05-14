#require 'rspec-rerun/tasks'
#task default: 'rspec-rerun:spec'
def launch_with(config_filename)
  system("parallel_rspec --test-options '-r ./config/#{config_filename} --order random' spec")
end

#def launch_with(config_filename)
#  system("parallel_rspec -rerun[3]  --test-options  '-r ./config/#{config_filename}' spec")
#end

namespace :local do
  BROWSERS_LOCAL = [ 'firefox', 'chrome' ]
  BROWSERS_LOCAL.each do |browser|
    desc "Run tests locally on #{browser.capitalize}"
    task browser.to_sym do
      ENV['browser'] = browser
      launch_with('local.rb')
    end
  end
end

namespace :cloud do
  BROWSERS_CLOUD =  [ 'firefox', 'chrome', 'internet_explorer']
  BROWSERS_CLOUD.each do |browser|
    desc "Run tests in Sauce Labs on #{browser.capitalize}"
    task browser.to_sym,:browser, :version, :os do |t, args|
      ENV['browser']          = args[:browser]
      ENV['browser_version']  = args[:version]
      ENV['operating_system'] = args[:os]
      launch_with('cloud.rb')
    end
  end
end
=begin
  ##The RUN AGAIN ON FAILURE CODE
  def gather_failures
     opts = ""
     files = Dir.glob('*.failures')
     files.each { |file| opts << File.read(file).gsub(/\n/, ' ') }
     all_failures = './all.failures'
     File.write(all_failures, opts.rstrip)
     return File.read all_failures
  end

  def cleanup(files = '')
      system("rm #{files}") unless Dir.glob("#{files}").empty?
  end

  def launch(params = {})
     if params[:test_options].include? '-e'
     count = params[:test_options].split(/failed/).count - 1
     puts "Retrying #{count} failed tests!"
  end
     system("parallel_rspec -n #{params[:processes] || 5} \
     --test-options '#{params[:test_options]}' spec")
  end

  def run(processes = 5)
    launch(processes: processes,
    test_options: '--require ./failure_catcher.rb \
    --format FailureCatcher')
  end

  def rerun(processes = 5)
    launch(processes: processes, test_options: gather_failures)
  end

  desc "parallel test execution with failure retries"
  task :run_tests, :number_of_processes do |t, args|
    cleanup 'results/*.xml'
    run args[:number_of_processes]
  unless $?.success?
    rerun args[:number_of_processes]
    cleanup '*.failures'
  end
 end
=end

