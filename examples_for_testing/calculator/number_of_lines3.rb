#!/usr/bin/ruby -w

lines = File.readlines("addition2.feature")
@scenarios_info = []
scenarios = [:name => "", :steps => []]
lines.each do |line|
	line.chomp!
	next if line.empty?
	if line.include? "Scenario:"
		scenarios << {:name => line, :steps => []} 
		next
	end 
	scenarios.last[:steps] << line
end

scenarios.each do |scenario|
	if not scenario[:name].empty?
		puts "#{scenario[:name]} has #{scenario[:steps].size} steps"
	end
end
