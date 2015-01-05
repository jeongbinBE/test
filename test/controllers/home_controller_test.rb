require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get manual" do
    get :manual
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get qna" do
    get :qna
    assert_response :success
  end

end
