class MessagesController < ApplicationController
  require 'uri'
  require 'net/http'

  def index
    @rooms = current_user.rooms.all
  end

  def api
    current_user.rooms.destroy_all
    url = URI("https://api.chatwork.com/v2/rooms")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["x-chatworktoken"] = current_user.user_token
    response = http.request(request)
    rooms_data = JSON.parse(response.body)
    rooms_data.each do |room_data|
      room = Room.create(
        user_id: current_user.id,
        cw_room_name: room_data["name"],
        cw_room_id: room_data["room_id"]
      )
    end
    redirect_to messages_path
  end
end
