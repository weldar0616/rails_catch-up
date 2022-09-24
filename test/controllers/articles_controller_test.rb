require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # 各テストの実行前に呼ばれる
  setup do
    @article = articles(:one)
  end

  # 各テストの実行後に呼ばれる
  teardown do
    # コントローラがキャッシュを使っている場合、テスト後にリセットしておくとよい
    Rails.cache.clear
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { body: 'Rails is awesome!', title: 'Hello Rails', status: 'public' } },
                         headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
    end

    assert_redirected_to article_path(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article),
             headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
    end
    assert_redirected_to root_path
  end

  test 'should update article' do
    patch article_url(@article), params: { article: { title: 'updated' } },
                                 headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }

    assert_redirected_to article_path(@article)
    # 更新されたデータをフェッチするために関連付けをリロードし、タイトルが更新されたというアサーションを行う
    @article.reload
    assert_equal 'updated', @article.title
  end
end
