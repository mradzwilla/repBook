require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get indx" do
    get :indx
    assert_response :success
  end

end
