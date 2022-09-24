require 'test_helper'

class BlogFlowTest < ActionDispatch::IntegrationTest
  test 'can see the welcome page' do
    get '/'
    assert_select 'h1', 'Welcome#index'
  end

  test 'can create an article' do
    get '/articles/new'
    assert_response :success

    post '/articles', params: { article: { title: 'can create', body: 'article successfully.' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p', "Title:\n  can create"
  end
end
