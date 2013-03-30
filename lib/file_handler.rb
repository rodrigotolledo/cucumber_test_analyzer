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
end
