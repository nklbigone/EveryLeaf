class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :check_if_loggin
    def check_if_loggin
      unless logged_in?
        redirect_to new_session_path, notice: "To go to this page, you have first login"
      end
    end
    helper_method :count
    def count
      current_user.tasks.count
    end
    def index
      @search = Task.ransack(params[:q])
      if params[:q]
        @tasks = @search.result.page(params[:page])
      elsif params[:search_label]
        @tasks = Task.joins(:labels)
            .where("labels.title ILIKE ?", "%#{params[:search_label]}%").page params[:page]
      elsif params[:sorting_deadline]
        @tasks = Task.all.order('deadline DESC').page(params[:page])
      elsif params[:sorting_priority]
        @tasks = Task.all.order('priority DESC').page(params[:page])
      else
        @tasks = Task.all.order('created_at DESC').page(params[:page])
      end
    end
  
    def show
    end
  
    def new
      @task = Task.new
    end

    def edit
    end
  

    def create
      @task = Task.new(task_params)
  
      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  

    def update
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to @task, notice: 'Task was successfully updated.' }
          format.json { render :show, status: :ok, location: @task }
        else
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  

    def destroy
      @task.destroy
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      def set_task
        @task = Task.find(params[:id])
      end
      
      def task_params
        params.require(:task).permit(:title, :task_name, :status, :priority, :deadline, :user_id, label_ids: [])
      end
end
