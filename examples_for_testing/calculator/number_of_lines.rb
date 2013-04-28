#!/usr/bin/ruby -w

File.open("addition2.feature") do |f|
	f.slice_before(/^\s*Scenario:/) do |scenario|
		title = scenario.shift.chomp
		ct = scenario.map(&:strip).reject(&:empty?).size
		puts "#{title} --> has #{ct} lines"
	end
end
