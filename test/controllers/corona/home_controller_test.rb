require 'test_helper'

class Corona::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get corona_home_index_url
    assert_response :success
  end

end
