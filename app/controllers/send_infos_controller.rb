class SendInfosController < ApplicationController
  before_action :set_twitter_client

  def new
    if SendInfo.ids.length > 0
      a = SendInfo.all.order(created_at: :desc).limit(1).pluck(:id)
      @value = SendInfo.find_by(id: a).text
    end
    @user = SendInfo.new
  end

  def create
    # DBに保存
    @user = SendInfo.new(send_info_params)
    names = @user.name.split
    user_arys = []
    names.length.times do
      user_arys << @params
    end
    i = 0
    user_arys.each do |user_hash|
      user_hash["name"] = names[i]
      SendInfo.new(user_hash).save
      i += 1
    end

    # DM送信
    names.each do |name|
      @client.user(name)
      user_id = @client.user(name).id
      @client.create_direct_message(user_id, @params["text"])
      # sleep(3)
    end

    redirect_to root_path
  end

  private

  def send_info_params
    @params = params.require(:send_info).permit(:name, :text)
  end

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "5hBP2lIi2m9g13BTyiqBLBMUX"
      config.consumer_secret     = "W1vCLHfH4vM0iKg1VH9nj813nYYqXW9ayyanQbgYNqVO2kiumG"
      config.access_token        = "1326499357-6kUEnc2VQETtABFyK2YGPTk3iF1OM4iUWeOEw75"
      config.access_token_secret = "MBvuE37XCQn22WG9ZB9zzbw3MUCapWTsIWAFZ5oKsrzWB"
    end
  end
end
