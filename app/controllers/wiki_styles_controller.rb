class WikiStylesController < ApplicationController
  before_filter :find_wiki, :find_style, :authorize
  
  def edit
  end
  
  verify :method => :put, :only => :update, :render => {:nothing => true, :status => :method_not_allowed }
  def update
    @style.attributes = params[:style]
    @style.author = User.current
    
    # delete the style record by setting :text to ""
    if @style.text.blank? && !@style.new_record?
      @style.destroy
    # try to save the style if we have some text
    elsif !@style.text.blank? && !@style.save
      # TODO: Changes are not echoed back to the user currently
      flash.now[:error] = "Error saving CSS"
    end

    if params[:continue]
      redirect = {:action => 'edit', :tab => (params[:id] ? :styles : :styles_global)}
    else
      redirect = {:action => 'show'}
    end
    redirect_to redirect.merge({:controller => :wiki, :project_id => @project, :id => @page ? @page.title : @wiki.start_page})
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
      @style = @page.style || WikiStyle.new(:wiki => @wiki, :page => @page)
    else
      @style = @wiki.style || WikiStyle.new(:wiki => @wiki)
    end
  end
end  