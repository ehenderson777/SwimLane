require 'sauce_whisk'

ENV['base_url']                   ||= 'https://www.qa.smartdollar.com'
ENV['ed_base_url']                ||= 'https://www.qa.everydollar.com'
ENV['enroll_base_url']            ||= 'https://www.qa.smartdollar.com/enroll'
ENV['host']                         = 'saucelabs'
ENV['operating_system']           ||= 'Windows XP'
ENV['browser']                    ||= 'internet_explorer'
ENV['browser_version']            ||= '8'

ENV['SAUCE_USERNAME']               = 'ramsey777'
ENV['SAUCE_ACCESS_KEY']             = '1522c693-1050-4696-96db-d3d71514e1d8'
