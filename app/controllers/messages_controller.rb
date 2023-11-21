class MessagesController < ApplicationController
  require 'uri'
  require 'net/http'

  def create
    body_params = {
      self_unread: 0,
      body: params[:body]
    }
    @room = Room.find(params[:room_id])
    url = URI("https://api.chatwork.com/v2/rooms/#{@room.cw_room_id}/messages")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/x-www-form-urlencoded'
    request["x-chatworktoken"] = current_user.user_token
    request.body = URI.encode_www_form(body_params)
    response = http.request(request)
    redirect_to rooms_path
  end
end
