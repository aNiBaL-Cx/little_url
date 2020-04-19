class MinifiedLinksController < ApplicationController
  before_action :set_minified_link, only: [:show]

  # GET /minified_links
  # GET /minified_links.json
  def index
    @minified_links = MinifiedLink.all
  end

  # GET /minified_links/1
  # GET /minified_links/1.json
  def show
  end

  def goto_link
    minified_link_id = HashingService.instance.decode(params[:id])[0]
    @minified_link = MinifiedLink.find(minified_link_id)
    redirect_to @minified_link.original_url
  end
  # GET /minified_links/new
  def new
    @minified_link = MinifiedLink.new
  end

  # POST /minified_links
  # POST /minified_links.json
  def create
    @minified_link = MinifiedLink.new(minified_link_params)


    respond_to do |format|
      if @minified_link.save
        format.html { redirect_to @minified_link, notice: 'Minified link was successfully created.' }
        format.json { render :show, status: :created, location: @minified_link }
      else
        format.html { render :new }
        format.json { render json: @minified_link.errors, status: :unprocessable_entity }
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
