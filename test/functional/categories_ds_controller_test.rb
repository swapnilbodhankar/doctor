require 'test_helper'

class CategoriesDsControllerTest < ActionController::TestCase
  setup do
    @categories_d = categories_ds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories_ds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categories_d" do
    assert_difference('CategoriesD.count') do
      post :create, categories_d: @categories_d.attributes
    end

    assert_redirected_to categories_d_path(assigns(:categories_d))
  end

  test "should show categories_d" do
    get :show, id: @categories_d.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categories_d.to_param
    assert_response :success
  end

  test "should update categories_d" do
    put :update, id: @categories_d.to_param, categories_d: @categories_d.attributes
    assert_redirected_to categories_d_path(assigns(:categories_d))
  end

  test "should destroy categories_d" do
    assert_difference('CategoriesD.count', -1) do
      delete :destroy, id: @categories_d.to_param
    end

    assert_redirected_to categories_ds_path
  end
end
