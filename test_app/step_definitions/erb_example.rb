require 'rubygems'
require 'nokogiri'
require 'erb'

class LanguagesHTMLCreator
	attr_accessor :list_of_langauges

	def initialize
		@list_of_langauges = []
	end

	def create_language_list
		doc = Nokogiri::XML(open("data.xml"))

		count = 1
		doc.xpath('//languages-list/*').each  do |node|
			if node.name.eql?("language") 
				node_name = "#{node.name}[#{count}]"
				puts node_name
				lang_name = doc.xpath("//languages-list/#{node_name}/name").first.content
				lang_users = doc.xpath("//languages-list/#{node_name}/users").first.content
				lang_family = doc.xpath("//languages-list/#{node_name}/family").first.content
				lang_region = doc.xpath("//languages-list/#{node_name}/region").first.content

				puts lang_name, lang_family, lang_users, lang_region
				@list_of_langauges << Language.new(lang_name, lang_family, lang_users, lang_region)
				count+=1
			end
		end
	end

	def convert_erb_html_file
		template_file = File.open("converted.htm.erb", 'r').read
		erb = ERB.new(template_file)
		File.open("converted.htm", 'w+') { |file| file.write(erb.result(binding)) }
	end

end

class Language
	attr_reader :name, :family, :users, :region
	def initialize(name, family, users, region)
		@name = name
		@family = family
		@users = users
		@region = region
	end

end

creator = LanguagesHTMLCreator.new
creator.create_language_list
creator.convert_erb_html_file


