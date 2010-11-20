class WikiStylesController < ApplicationController
  before_filter :find_wiki, :find_style, :authorize
  
  def edit
  end
  
  verify :method => :put, :only => :update, :render => {:nothing => true, :status => :method_not_allowed }
  def update
    @style.attributes = params[:style]
    @style.author = User.current
    
    if @style.save
      redirect_to :controller => :wiki, :action => 'show', :project_id => @project, :id => @page ? @page.title : nil
    end
  end

private
  def find_wiki
    @project = Project.find(params[:project_id])
    @wiki = @project.wiki
    render_404 unless @wiki
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_style
    if params[:id]
      @page = @wiki.find_page(params[:id])
      return render_404 unless @page
      @style = @page.style || @page.style.build(:wiki => @wiki)
    else
      @style = @wiki.style || @wiki.build
    end
  end
end  