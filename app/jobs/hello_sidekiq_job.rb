class HelloSidekiqJob < ApplicationJob
  queue_as :default

  # def new
  #   @client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  #     config.consumer_secret     = ENV["CONSUMER_SECRET"]
  #     config.access_token        = ENV["ACCESS_TOKEN"]
  #     config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  #   end
  #   @user_num = SendInfo.count
  #   @user = SendInfo.first
  #   begin
  #     @client.create_direct_message(@client.user(@user.name).id, "#{@client.user(@user.name).name}#{@user.atena}\n\n#{@user.text}")
  #   rescue
  #   end
  #   @user.destroy
  # end

  def perform(args)
    puts args
  end
end