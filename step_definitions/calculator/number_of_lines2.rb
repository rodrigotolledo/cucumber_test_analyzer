#!/usr/bin/ruby -w

scenario  = nil
scenarios = Hash.new{ |h,k| h[k] = 0 }

File.open("addition2.feature").each do |line|
	next if line.strip.empty?

	if line[/^Scenario:/]
		scenario = line
	else
		scenarios[scenario] += 1
	end
end

p scenarios
