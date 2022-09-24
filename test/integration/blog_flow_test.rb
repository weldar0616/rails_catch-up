require 'test_helper'

class BlogFlowTest < ActionDispatch::IntegrationTest
  test 'can see the welcome page' do
    get '/'
    assert_select 'h1', 'Articles'
  end

  test 'can create an article' do
    get '/articles/new',
        headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
    assert_response :success

    post '/articles', params: { article: { title: 'can create', body: 'article successfully.', status: 'public' } },
                      headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'can create'
  end
end
