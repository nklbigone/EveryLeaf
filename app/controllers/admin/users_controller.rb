class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @search = Task.ransack(params[:q])
      if params[:q]
        @tasks = @search.result.page(params[:page])
      elsif params[:sorting_deadline]
        @tasks = Task.all.order('deadline DESC').page(params[:page])
      elsif params[:sorting_priority]
        @tasks = Task.all.order('priority DESC').page(params[:page])
      else
        @tasks = Task.all.order('created_at DESC').page(params[:page])
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    unless logged_in? && current_user.id == @user.id
      redirect_to new_session_path, danger: "Sorry, you are only allowed to view other's profile."
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id]=@user.id
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:fname, :lname, :email, :user_type, :password, :password_confirmation)
    end
  def admin
    if logged_in? 
      unless current_user.user_type == 'admin'
      redirect_to new_session_path, notice: 'please log in as Admin'
      end
    end
  end

end
