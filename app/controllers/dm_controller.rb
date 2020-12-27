class DmController < ApplicationController
  before_action :set_twitter_client

  def new
    @user_num = SendInfo.count
    @user = SendInfo.first
    begin
      @client.create_direct_message(@client.user(@user.name).id, "#{@client.user(@user.name).name}#{@user.atena}\n\n#{@user.text}")
    rescue
    end
    if @user_num > 1
      @user.destroy
    elsif @user_num == 1
      @user.destroy
      redirect_to root_path
    end
  end

  private

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
  end
end