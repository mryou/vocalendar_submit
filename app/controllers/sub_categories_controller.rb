class SubCategoriesController < ApplicationController
  before_filter :set_variable

  # GET /sub_categories
  # GET /sub_categories.xml
  def index
    @sub_categories = SubCategory.all
    respond_with(@sub_categories)
  end

  # GET /sub_categories/1
  # GET /sub_categories/1.xml
  def show
    @sub_category = SubCategory.find(params[:id])
    respond_with(@sub_category)
  end

  # GET /sub_categories/new
  # GET /sub_categories/new.xml
  def new
    @sub_category = SubCategory.new
    respond_with(@sub_category)
  end

  # GET /sub_categories/1/edit
  def edit
    @sub_category = SubCategory.find(params[:id])
  end

  # POST /sub_categories
  # POST /sub_categories.xml
  def create
    @sub_category = SubCategory.new(params[:sub_category])
    @sub_category.save
    respond_with @sub_category, :location => sub_categories_path
  end

  # PUT /sub_categories/1
  # PUT /sub_categories/1.xml
  def update
    params[:sub_category].try(:delete, :name)
    @sub_category = SubCategory.find(params[:id])
    @sub_category.update_attributes(params[:sub_category])
    respond_with @sub_category, :location => sub_categories_path
  end

  # DELETE /sub_categories/1
  # DELETE /sub_categories/1.xml
  def destroy
    return redirect_to sub_categories_path # disable delete
    @sub_category = SubCategory.find(params[:id])
    @sub_category.destroy
    respond_with(@sub_category)
  end

  private
  def set_variable
    @show_admin_menu = true
  end
end
