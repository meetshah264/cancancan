class ProjectsController < ApplicationController
  before_action :load_projects, only: :index
  load_and_authorize_resource
  
  def update
    if @project.update(project_params)
    flash[:success] = 'Project was updated!'
    redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def create
    if @project.save
      flash[:success] = 'Project was saved!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = 'Project was destroyed!'
    else
      flash[:warning] = 'Cannot destroy this project...'
      endredirect_to root_path
    end
  end

    private
      
      def project_params
        params.require(:project).permit(:title,:ongoing)
      end
    
      def load_projects
        @projects = Project.accessible_by(current_ability).order('created_at DESC')
      end
end
