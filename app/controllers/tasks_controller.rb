class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page])
  end

  def show 
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスクが記録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが記録できませんでした'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = '更新されました'
      redirect_to @task
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = '削除されました'
    redirect_to tasks_url
  end
  
  private
  def set_tasks
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
end
