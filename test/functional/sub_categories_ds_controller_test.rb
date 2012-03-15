require 'test_helper'

class SubCategoriesDsControllerTest < ActionController::TestCase
  setup do
    @sub_categories_d = sub_categories_ds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_categories_ds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_categories_d" do
    assert_difference('SubCategoriesD.count') do
      post :create, sub_categories_d: @sub_categories_d.attributes
    end

    assert_redirected_to sub_categories_d_path(assigns(:sub_categories_d))
  end

  test "should show sub_categories_d" do
    get :show, id: @sub_categories_d.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_categories_d.to_param
    assert_response :success
  end

  test "should update sub_categories_d" do
    put :update, id: @sub_categories_d.to_param, sub_categories_d: @sub_categories_d.attributes
    assert_redirected_to sub_categories_d_path(assigns(:sub_categories_d))
  end

  test "should destroy sub_categories_d" do
    assert_difference('SubCategoriesD.count', -1) do
      delete :destroy, id: @sub_categories_d.to_param
    end

    assert_redirected_to sub_categories_ds_path
  end
end
