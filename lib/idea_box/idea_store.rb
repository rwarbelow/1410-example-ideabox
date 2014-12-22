require 'yaml/store'

class IdeaStore

	def self.all
		raw_ideas.map.with_index do |data, i|
			Idea.new(data.merge("id" => i))
		end
	end

	def self.raw_ideas
		database.transaction do |db|
			db['ideas'] || []
		end
	end

	def self.delete(id)
		database.transaction do |db|
			database['ideas'].delete_at(id)
		end
	end

	def self.find(id)
		raw_idea = find_raw_idea(id)
		Idea.new(raw_idea.merge("id" => id))
	end

	def self.find_raw_idea(id)
		database.transaction do |db|
			database['ideas'].at(id)
		end
	end

	def self.update(id, data)
		database.transaction do |db|
			database['ideas'][id] = data
		end
	end

	def self.database
		return @database if @database
		if ENV["RACK_ENV"] == "test"
			@database = YAML::Store.new('test/fake_ideabox')
		else
			@database = YAML::Store.new('db/ideabox')
		end
		@database.transaction do
			@database['ideas'] ||= []
		end
		@database	
	end

	def self.create(attributes)
		database.transaction do
			database['ideas'] << attributes
		end
	end

	def self.delete_all
		database.transaction do 
			database['ideas'] = []
		end
	end
end
