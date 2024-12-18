require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relationships_index_url
    assert_response :success
  end

  test "should get show" do
    get relationships_show_url
    assert_response :success
  end
end
