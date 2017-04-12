require 'test_helper'

class DevlessControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get devless_index_url
    assert_response :success
  end

end
