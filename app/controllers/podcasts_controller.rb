class PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy]

  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.all
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
  end

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    new_params = podcast_params
    if new_params[:upload]
      audio_name = "#{new_params[:title].squish.tr(' ', '_')}"+File.extname(new_params[:upload].original_filename)
      save_audio(new_params[:upload], audio_name)
      new_params[:audio] = "#{audio_name}"
    end
    new_params.delete(:upload)
    @podcast = Podcast.new(new_params)

    if @podcast.save
      flash[:success] = "Podcast successfully created!"
      redirect_to podcasts_path
    else
      redirect_to new_podcast_path
    end
  end

  # PATCH/PUT /podcasts/1
  # PATCH/PUT /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def podcast_params
      params.require(:podcast).permit(:user_id, :show_id, :title, :audio, :description, :upload)
    end
end
