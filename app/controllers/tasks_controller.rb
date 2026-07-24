class TasksController < ApplicationController
  def index
    @filter = params[:filter] || "my_tasks"
    if @filter == "all"
      @tasks = Task.includes(:user).all
    else
      @tasks = Current.user.tasks.includes(:user)
    end
  end

  def new
    @task = Task.new
    @users = User.all
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path(filter: "all"), notice: "Task was successfully created."
    else
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.expect(task: [ :title, :description, :status, :user_id ])
  end
end
