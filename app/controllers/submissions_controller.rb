class SubmissionsController < ApplicationController
  def index
    @new_subs = Submission.where(:status_id => Submission.status.new)
      .order('created_at').paginate :page => params[:page], :per_page => 15
    @accepted_subs = Submission.where(:status_id => Submission.status.accepted)
      .order('accepted_at desc').limit(10)
    respond_with @new_subs
  end

  def list
    @show_admin_menu = true
    @submissions = Submission.reorder('created_at desc')
      .paginate :page => params[:page], :per_page => 50
    params[:category_id] and
      @submissions = @submissions.where(:category_id => params[:category_id])
    params[:status_id] and
      @submissions = @submissions.where(:status_id => params[:status_id])
    respond_with @submissions
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])
    respond_with @submission
  end

  # GET /submissions/new
  # GET /submissions/new.json
  def new
    @submission = Submission.new
    respond_with @submission
  end

  # GET /submissions/1/edit
  def edit
    @show_admin_menu = true
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(params[:submission])
    @submission.save
    respond_with @submission, :location => submissions_path
  end

  # PUT /submissions/1
  # PUT /submissions/1.json
  def update
    @submission = Submission.find(params[:id])
    @submission.update_attributes(params[:submission].select{|k, v| %w(status_id).member? k})
    respond_with @submission
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    return redirect_to submissions_path # disable delete
    @submission = Submission.find(params[:id])
    @submission.destroy
    respond_with @submission
  end
end
