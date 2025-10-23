require "test_helper"

class TheatreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get theatre_index_url
    assert_response :success
  end

  test "should get show" do
    get theatre_show_url
    assert_response :success
  end

  test "should get create" do
    get theatre_create_url
    assert_response :success
  end

  test "should get destroy" do
    get theatre_destroy_url
    assert_response :success
  end

  test "should get update" do
    get theatre_update_url
    assert_response :success
  end
end
