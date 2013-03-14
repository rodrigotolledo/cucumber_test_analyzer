#!/usr/bin/ruby -w

class FileHandler

	def open_step_definitions_files(step_definitions_path)
		@current_directory = Dir.pwd
		Dir.chdir(step_definitions_path)
		#TODO: add exception handler
		@all_ruby_step_definitions_files = Dir.glob("**/*.rb")
		puts "Step Definitions files to be analyzed: #{@all_ruby_step_definitions_files}."
	end

	def verify_how_many_tests_exist(step_definitions_files)
		@amount_of_existing_tests = 0
		@all_ruby_step_definitions_files.each do |file|
			File.open(file).each_line do |line|
				if line.include?("Given")
					@amount_of_existing_tests +=1
					#TODO: Fix commented 'Given's'
				end
			end
		end
		return @amount_of_existing_tests
	end
end
