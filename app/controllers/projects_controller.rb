# frozen_string_literal: true

# class ProjectsController
class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]

  def index
    @projects = Project.all.includes(:items)
  end

  def show
    @item = @project.items.build
  end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to project_path(@project), notice: 'Project was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

  def clear
    if @project.items.complete.size.positive?
      @project.items.complete.destroy_all
      notice = 'Completed items were successfully cleared.'
    else
      notice = 'There are no completed items for this project.'
    end

    redirect_to project_path(@project), notice: notice
  end

  private

  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: 'Project not found'
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
