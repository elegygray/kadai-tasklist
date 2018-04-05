class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def show
    @user = current_user
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def create
    @task = current_user.tasks.build(task_params)
    @user = current_user
    if @task.save
      flash[:success] = 'タスクが記録されました'
      redirect_to @user
    else
      flash.now[:danger] = 'タスクが記録できませんでした'
      render :new
    end
  end
  
  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  def update
    @user = current_user
    @task = @user.tasks.find_by(id: params[:id])
    if @task.update(task_params)
      flash[:success] = '更新されました'
      redirect_to @user
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = '削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  
end
