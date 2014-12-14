# ENV['RACK_ENV'] = 'test'
# require 'minitest/autorun'
# require 'minitest/pride'
# require 'minitest/spec'
# require 'rack/test'

# require_relative 'test_helper'
# require_relative '../lib/app'

# # describe IdeaBoxApp do
# # 	include Rack::Test::Methods

# # 	def app
# # 		IdeaBoxApp.new
# # 	end

# # 	it 'works' do
# # 		get '/'
# # 		assert_equal 200, last_response.status
# # 		assert last_response.ok?
# # 	end
# # end



# class MyTest < MiniTest::Test

#   include Rack::Test::Methods

#   def app
#     IdeaBoxApp
#   end

#   def test_hello_world
#     get '/'
#     assert last_response.ok?
#     assert last_response.body.include?('idea')
#   end
# end

require_relative 'test_helper'
require './lib/app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    IdeaBoxApp
  end

  def test_it_shows_the_correct_number_of_ideas
  	get '/'
  	p last_request
  	p "---------"
  	# p last_response.inspect
  	# idea = IdeaStore.create({title: "testtitle", description: "testdescription"})
  	# assert_equal 1, IdeaStore.all.count

  end

  # def test_index_page_contains_correct_header
  #   response = get '/'
  #   assert response.ok?
  #   home_page = Nokogiri::HTML(response.body)
  #   assert_includes home_page.content, "IdeaBox"
  # end

  # def test_index_page_contains_existing_ideas
  #   response = get '/'
  #   home_page = Nokogiri::HTML(response.body)
  #   assert_includes home_page.content, "Existing Ideas"
  # end

end
