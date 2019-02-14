require 'test_helper'

class Api::V1::RailsControllerTest < ActionDispatch::IntegrationTest
  test "should get c" do
    get api_v1_rails_c_url
    assert_response :success
  end

end
