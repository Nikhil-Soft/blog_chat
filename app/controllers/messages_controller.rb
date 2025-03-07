class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :set_room, only: %i[ new create ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = @room.messages.build
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
   @message = @room.messages.build(message_params)
    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room, notice: "Message sent!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_path, status: :see_other, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params.expect(:id))
    end

    def set_room
      @room = Room.find(params[:room_id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.expect(message: [ :room_id, :content ])
    end
end
