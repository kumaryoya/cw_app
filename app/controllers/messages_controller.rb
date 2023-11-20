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
      members_url = URI("https://api.chatwork.com/v2/rooms/#{room_data["room_id"]}/members")
      members_request = Net::HTTP::Get.new(members_url)
      members_request["accept"] = 'application/json'
      members_request["x-chatworktoken"] = current_user.user_token
      members_response = http.request(members_request)
      members_data = JSON.parse(members_response.body)
      members_data.each do |member_data|
        Member.create(
          room_id: room.id,
          cw_user_name: member_data["name"],
          cw_account_id: member_data["account_id"]
        )
      end
    end
    redirect_to messages_path
  end
end
