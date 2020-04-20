class MinifiedLinksController < ApplicationController
  before_action :set_minified_link, only: [:show]

  # GET /minified_links
  # GET /minified_links.json
  def index
    @minified_link = MinifiedLink.new
    @minified_links = MinifiedLink.all.order(id: 'desc')
  end

  # GET /minified_links/1
  # GET /minified_links/1.json
  def show
  end

  def goto_link
    @minified_link = MinifiedLink.search_by_url_key(params[:id])
    if @minified_link.present?
      redirect_to @minified_link.original_url
    else
      redirect_to '/', error: 'Não encontrado'
    end
  end

  # POST /minified_links
  # POST /minified_links.json
  def create

    creator = MinifiedLinkCreator.call(params: minified_link_params)
    @minified_link = creator.minified_link

    respond_to do |format|
      if creator.success?
        format.html { redirect_to root_path, notice: 'Minified link was successfully created.' }
        format.json { render :show, status: :created, location: @minified_link }
      else
        format.html do
          @minified_links = MinifiedLink.all.order(id: 'desc')
          render :index
        end
        format.json { render json: creator.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_minified_link
      @minified_link = MinifiedLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def minified_link_params
      params.require(:minified_link).permit(:original_url)
    end
end
