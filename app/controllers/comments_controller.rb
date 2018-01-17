class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task,only: [:new,:create]
  before_action :set_comment,only: [:edit,:update,:destroy]

  def create
    @comment = @task.comments.build(comments_params)
    @comment.save
  end
  
  def destroy
    @task = @comment.task
    @comment.destroy
  end

  private
    def set_task
      @task = Task.find_by(id: params[:comment][:task_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comments_params
      params.require(:comment).permit(:comment,:user_id)
    end
end
