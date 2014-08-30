class StoriesController < ApplicationController
  respond_to :json
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /stories
  # GET /stories.json
  def index
    stories = if params[:user_id]
      Story.where(user_id: params[:user_id]).order("created_at DESC")
    else
      Story.order("created_at DESC")
    end

    respond_with stories, each_serializer: StoriesSerializer
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
    respond_with @story
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new()

    if @story.save
      render json: @story, status: :created
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    if @story.update(story_params)
      render json: @story, status: :created
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params.require(:story).permit(:title, :description, :body)
    end
end
