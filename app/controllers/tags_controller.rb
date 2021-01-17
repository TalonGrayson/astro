class TagsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :soft_delete, :trigger_tag]
  protect_from_forgery

  before_action :set_tag, only: [:show, :edit, :update, :soft_delete, :trigger_tag]

  # GET /tags
  # GET /tags.json
  def index
    if user_signed_in?
      owner_id = current_user.id
    else
      owner_id = 0
    end
    @tags = Tag.active.where(user_id: owner_id).order(last_seen: :desc)
  end

  # GET /tags/1
  # GET /tags/1.json
  def show; end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit; end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: "#{@tag.name} was successfully created." }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    if user_owns_this_tag?
      respond_to do |format|
        if @tag.update(tag_params)
          format.html { redirect_to @tag, notice: "#{@tag.name} was successfully updated." }
          format.json { render :show, status: :ok, location: @tag }
        else
          format.html { render :edit }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to tag_path(@tag), notice: 'You can\'t edit this tag, it belongs to someone else.'
    end
  end

  def soft_delete
    if user_owns_this_tag?
      if @tag.update(deleted: true)
        redirect_to tags_path, notice: "#{@tag.name} was successfully deleted."
      else
        redirect_back fallback_location: :edit, notice: "#{@tag.name} could not be deleted!"
      end
    else
      redirect_to tag_path(@tag), notice: 'You can\'t delete this tag, it belongs to someone else.'
    end
  end

  def trigger_tag
    if user_owns_this_tag?
      data = {
        device:    'astroscan',
        device_id: @tag.user.devices.first.device_id,
        origin:    @tag.origin,
        type:      @tag.variety,
        name:      @tag.name,
        light_r:   @tag.light_rgb.split(',')[0].to_i,
        light_g:   @tag.light_rgb.split(',')[1].to_i,
        light_b:   @tag.light_rgb.split(',')[2].to_i
      }

      if ParticleService.new.publish_scan_info(data)
        redirect_back fallback_location: :show, notice: "#{@tag.name} was triggered!"
      else
        redirect_back fallback_location: :show, notice: "#{@tag.name} could not be triggered!"
      end
    else
      redirect_to tag_path(@tag), notice: 'You can\'t trigger this tag, it belongs to someone else.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    begin
      @tag = Tag.find(params[:id])
    rescue
      respond_to do |format|
        format.html { redirect_to tags_path, notice: "That tag does not exist" }
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:tag_hex, :origin, :variety, :name, :light_rgb,
                                :health, :defence, :attack, :speed, :last_seen, :deleted,
                                :tag_image)
  end

  def user_owns_this_tag?
    user_signed_in? && @tag.user == current_user
  end
end
