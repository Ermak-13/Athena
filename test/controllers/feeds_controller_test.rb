require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  test 'index' do
    get :index

    assert_response :success
    assert_not_nil assigns(@feeds)
  end

  test 'create feed with invalid url' do
    url = 'http://examplefeeds.com'
    post :create, feed: {url: url}

    assert flash[:alert].present?
  end

  test 'create feed with valid url' do
    assert false, 'mock Feedzirra::Feed.fetch_and_parse'
  end
end
