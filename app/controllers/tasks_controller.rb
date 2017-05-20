class TasksController < ApplicationController
  before_action :set_params, :require_user_logged_in, only: [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'users/index'
    end

  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
        flash[:success] = 'タスクが更新されました'
        redirect_to root_url
    else
        flash.now[:danger] = 'タスクは更新されませんでした'
        render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました'
    redirect_to tasks_url
  end

  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_path
      end
  end
end