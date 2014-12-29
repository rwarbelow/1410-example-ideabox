require_relative 'test_helper'
require 'app'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    IdeaBoxApp
  end

  def teardown
    IdeaStore.delete_all
  end

  def test_an_idea_is_created_using_ideastore
    # this only tests IdeaStore functionality -- doesn't have anything to do with the web app
    idea = IdeaStore.create({title: "testtitle", description: "testdescription"})
    assert_equal 1, IdeaStore.all.count
  end

  def test_it_creates_an_idea_by_posting_params
    post '/', { idea: { title: "here is a new idea", description: "here is the description"} }
    follow_redirect!
    assert last_response.ok?
    assert_equal 1, IdeaStore.all.count
    html = Nokogiri::HTML(last_response.body)
    assert_equal 'here is a new idea', html.css('#ideas h3').text
    assert_equal 'here is the description', html.css('#ideas p').text
  end  
end
