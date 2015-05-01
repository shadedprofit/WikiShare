class WikisController < ApplicationController
  def index
    @wikis = Wiki.all 
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def create
    @user = current_user
    @wiki = current_user.wikis.build(wiki_params)
    @wiki.user = @user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki.  Please try again."
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @user = current_user
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    authorize @wiki
    @wiki.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
