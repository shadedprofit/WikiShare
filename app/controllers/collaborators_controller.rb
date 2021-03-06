class CollaboratorsController < ApplicationController
  def index
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaborators = @wiki.collaborators
    @users = User.all
    authorize @wiki
  end

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    params[:user_id].each_key do |user_id|
      user = User.find(user_id)
      @collaborator = @wiki.collaborators.create(:user => user)
    end
    @users = User.all
    @non_collaborators = User.all
    @collaborator.wiki = @wiki
    @collaborators = @wiki.collaborators
    
    if @collaborator.save
      flash[:notice] = "Collaborator was added successfully."
      render :index
    else
      flash[:error] = "There was an error. Please try again."
      render :index
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.find(params[:id])
    authorize @wiki
    @users = User.all
    
    if @collaborator.destroy
      flash[:notice] = "Collaborator was removed."
      redirect_to :back
    else
      flash[:error] = "There was an error removing the collaborator. Please try again."
      render :index
    end
    
  end

end