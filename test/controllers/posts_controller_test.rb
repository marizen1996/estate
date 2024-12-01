require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new," do
    get posts_new,_url
    assert_response :success
  end

  test "should get index," do
    get posts_index,_url
    assert_response :success
  end

  test "should get show" do
    get posts_show_url
    assert_response :success
  end
end
