# frozen_string_literal: true

# class ItemsController
class ItemsController < ApplicationController
  before_action :set_project

  def new
    @item = @project.items.build
  end

  def create
    @item = @project.items.build(item_params)

    if @item.save
      redirect_to project_path(@project), notice: 'Item was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
    @item = @project.items.find(params[:id])
  end

  def update
    @item = @project.items.find(params[:id])

    if @item.update(item_params)
      redirect_to project_path(@project), notice: 'Item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: 'Project not found'
  end

  def item_params
    params.require(:item).permit(:action, :done)
  end
end
