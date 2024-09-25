class MessagesController < ApplicationController
  # before_action :set_message, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # GET /messages
  def index
    @messages = current_user.received_messages.includes(:sender, :replies).order(created_at: :desc)
    render json: @messages
  end

  def inbox
    @messages = current_user.received_messages.includes(:sender, :replies).order(created_at: :desc)
    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    # @message = current_user.messages.new(message_params)
    @message = current_user.messages.new(message_params.merge(sender_id: current_user.id))


    if @message.save
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end



  def send_message
    user = User.find(params[:id])

        # @message = current_user.messages.new(message_params)
        @message = User.messages.new(message_params.merge(sender_id: user.id, user_id: user.id))


        if @message.save
            render json: {
              status: {
                code: 200,
                message: "message sent successfully"
              },
            }, status: :ok
          else
            render json: {
              status: {
                code: 404,
                message: "message failed"
              }
            }, status: :not_found
        end



  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit( :recipient_id, :content)
    end
end
