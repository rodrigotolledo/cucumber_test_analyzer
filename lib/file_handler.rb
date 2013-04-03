#!/usr/bin/ruby -w

class FileHandler

	def open_files(files_path, files_format)
		@current_directory = Dir.pwd
		Dir.chdir(files_path)
		@all_files = Dir.glob("**/*.#{files_format}")
		if files_format == "rb"
			puts "Step Definitions files to be analyzed: #{@all_files}."
		elsif files_format == "feature"
			puts "Feature files to be analyzed: #{@all_files}."
		end
	end

	def verify_how_many_tests_exist
		@amount_of_existing_tests = verify_how_many("Given")
		return @amount_of_existing_tests
	end

	def verify_how_many(word)
		amount_of_existing_tests = 0
		@all_files.each do |file|
			File.open(file).each_line do |line|
				if line.include?(word)
					amount_of_existing_tests +=1
					#TODO: Fix commented 'Given's'
				end
			end
		end
		return amount_of_existing_tests
	end

	def print_directory_path_message
		puts "What's the directory path of your step_definitions? [example: /Users/Rodrigo/myApp/step_definitions]"
		print "> "
	end

	def is_path_a_directory?
		while not File.directory?(@step_definitions_path)
			puts "This path doesn't exist. Please type a valid path that contains your step_definitions."
			print "> "
			@step_definitions_path = gets.chomp
		end
		return true
	end

	def while_files_is_empty_then_read_again(files)
		while files.empty?
			puts "Sorry, there isn't any step definitions (*.rb) files inside this path. Please type a valid path that contains your step definitions."
			print "> "
			@step_definitions_path = gets.chomp
		end
	end

	def read_and_validate_step_definitions_path
		print_directory_path_message
		@step_definitions_path = gets.chomp
		if(is_path_a_directory?)
			files = Dir.glob("**/*.rb")
		end
		while_files_is_empty_then_read_again(files)
	end
end
