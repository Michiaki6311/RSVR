require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup (users#new)" do
    get signup_url
    assert_response :success
  end

end
