class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  
  def index
    #@tasks = Task.all
    #ログイン確認後、自分専用のタスクへ移行
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end

  def show
    set_task
  end

  def new
    @task = Task.new#(task_params)
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスク作成完了しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "タスクが作成できませんでした。"
      render :new
    end
  end

  def edit
    set_task
  end

  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは更新できませんでした。"
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy
    
    flash[:success] = "タスクを削除しました。"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
