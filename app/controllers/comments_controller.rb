class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task,only: [:new,:create,:update,:edit]

  def create
    @comment = @task.comments.build(comments_params)
    @comment.save!
  end
  
  def edit

  end

  def update

  end

  def delete

  end

  private
    def set_task
      @task = Task.find_by(id: params[:comment][:task_id])
    end

    def comments_params
      params.require(:comment).permit(:comment,:user_id)
    end
end
