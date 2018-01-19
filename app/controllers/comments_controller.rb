class CommentsController < ApplicationController
  before_action :set_task,only: [:new,:create]
  before_action :set_comment,only: [:edit,:update,:destroy]

  def create
    @comment = @task.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js{}
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @task = @comment.task
    if @comment.destroy
      respond_to do |format|
        format.js{}
      end
    end
  end

  private
    def set_task
      @task = Task.find_by(id: params[:comment][:task_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:comment,:user_id)
    end
end
