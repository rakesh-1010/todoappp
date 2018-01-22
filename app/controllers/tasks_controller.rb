class TasksController < ApplicationController
  before_action :set_task,except: [:new,:index,:create] 

  def index
    @my_tasks = Task.where(user_id: current_user.id)
    @tagged_tasks = current_user.tagings.map{|tag| tag.task}
    @tasks = (@my_tasks + @tagged_tasks).uniq.sort_by &:created_at
  end

  def show
    @comment = @task.comments.build
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
        format.html{ redirect_to tasks_path, notice: 'Task was successfully created.' }
      else
        format.js { redirect_to new_tasks_path }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_task_state
    respond_to do |format|
      if @task.update(is_completed: params[:is_completed])
          format.json {head :no_content}
      else
          format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def tag_user
    @user = User.find_by(id: params[:tagged_user_id])
    @taging = Taging.find_by(user_id: params[:tagged_user_id],task_id: params[:id])
    create_tag(params[:tagged_user_id],params[:id]) if @taging.blank?
    remove_tag if @taging.present?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:description, :is_completed, :user_id)
    end

    def create_tag(user_id,task_id)
      Taging.add_tag(user_id,task_id)
    end

    def remove_tag
      @taging.remove_tag 
    end
end
