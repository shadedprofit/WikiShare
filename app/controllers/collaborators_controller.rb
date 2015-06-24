class CollaboratorsController < ApplicationController
  def index
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = @wiki.collaborators
    @users = User.all
    authorize @wiki
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])

    params[:user_id].each_key do |user_id|
      user = User.find(user_id)
      @wiki.collaborators.create(:user => user)
    end
    
    if @wiki.save
      redirect_to [@wiki, @collaborators]
    end
  end

  def update
    @wiki = Wiki.find(params[:wiki_id])

    params[:wiki][:user_ids].each do |user_id|
      user = User.find(user_id)
      @wiki.collaborators.create(:user => user)
    end

  end

  def destroy

  end

end