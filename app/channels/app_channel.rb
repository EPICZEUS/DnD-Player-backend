class AppChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{channel_name}_main"
  end

  def unsubscribed
  end
end
