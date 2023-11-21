class RoomsController < ApplicationController
  require 'uri'
  require 'net/http'

  def index
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
    @rooms = current_user.rooms.all
  end

  def show
    @room = Room.find(params[:id])
    url = URI("https://api.chatwork.com/v2/rooms/#{@room.cw_room_id}/members")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["x-chatworktoken"] = current_user.user_token
    response = http.request(request)
    @members = JSON.parse(response.body)
  end
end
