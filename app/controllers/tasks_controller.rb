class TasksController < ApplicationController
  before_action :set_task,except: [:new,:index,:create] 

  def index
    @tasks = current_user.all_tasks.uniq.sort_by &:created_at
  end

  def show
    @comment = @task.comments.build
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
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

  def change_state
    respond_to do |format|
      if @task.update(is_completed: params[:is_completed])
          format.json {head :no_content}
      else
          format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle_tag
    @user = User.find_by(id: params[:tagged_user_id])
    @task = Task.find(params[:id])
    @task.toggle_tag(@user)
  end

  private
  def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :is_completed, :user_id)
    end

end
