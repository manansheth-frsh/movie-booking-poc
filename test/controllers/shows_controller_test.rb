require "test_helper"

class ShowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shows_index_url
    assert_response :success
  end

  test "should get create" do
    get shows_create_url
    assert_response :success
  end

  test "should get new" do
    get shows_new_url
    assert_response :success
  end

  test "should get show" do
    get shows_show_url
    assert_response :success
  end
end
