require 'test_helper'

class BulltinsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bulltins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bulltin" do
    assert_difference('Bulltin.count') do
      post :create, :bulltin => { }
    end

    assert_redirected_to bulltin_path(assigns(:bulltin))
  end

  test "should show bulltin" do
    get :show, :id => bulltins(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bulltins(:one).to_param
    assert_response :success
  end

  test "should update bulltin" do
    put :update, :id => bulltins(:one).to_param, :bulltin => { }
    assert_redirected_to bulltin_path(assigns(:bulltin))
  end

  test "should destroy bulltin" do
    assert_difference('Bulltin.count', -1) do
      delete :destroy, :id => bulltins(:one).to_param
    end

    assert_redirected_to bulltins_path
  end
end
