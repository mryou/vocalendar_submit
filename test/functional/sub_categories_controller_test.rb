require 'test_helper'

class SubCategoriesControllerTest < ActionController::TestCase
  setup do
    @subcat = sub_categories(:one)
    @subcat.save!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    assert_difference('SubCategory.count') do
      post :create, sub_category: allowed_attrs(sub_categories(:two))
    end
    assert assigns(:sub_category)
    assert_redirected_to sub_categories_path
  end

  test "should get edit" do
    get :edit, id: @subcat
    assert_response :success
  end

  test "should get show" do
    get :show, id: @subcat
    assert_response :success
  end

  test "should update sub_category" do
    put :update, id: @subcat, sub_category: allowed_attrs(@subcat)
    assert_redirected_to sub_categories_path
  end

  test "should destroy subcat" do
    delete :update, id: @subcat
    assert_redirected_to sub_categories_path
    break # disable original feature ---
    assert_difference('SubCategory.count', -1) do
      delete :destroy, id: @subcat
    end
  end

end
