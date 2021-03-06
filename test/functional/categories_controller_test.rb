require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = rand_cat
    @category.save
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, category: allowed_attrs(rand_cat)
    end
    assert assigns(:category)
    assert_redirected_to categories_path
  end

  test "should show category" do
    get :show, id: @category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category
    assert_response :success
  end

  test "should update category" do
    put :update, id: @category, category: allowed_attrs(@category)
    assert_redirected_to categories_path
  end

  test "should destroy category" do
    delete :destroy, id: @category
    assert_redirected_to categories_path
    break # disable original feature ---
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categories_path
  end
end
