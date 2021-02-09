namespace :minite_post do
  desc "保存内容を一件ずつ送信"
  task :regularly_flag => :environment do
    #ログ
    logger = Logger.new 'log/run_regularly.log'

    #ここから処理を書いていく
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["CONSUMER_SECRET"]
      config.access_token        = ENV["ACCESS_TOKEN"]
      config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
    end
    @users = SendInfo.limit(4)
    @user_num = @users.count
    @users.each do |user|
      if @user_num != 0
        begin
          @client.create_direct_message(@client.user(user.name).id, "#{@client.user(user.name).name}#{user.atena}\n\n#{user.text}")
        rescue => error
          puts error
        end
        user.destroy
        sleep(20)
      end
    end

    #デバッグのため
    p "OK!!"
  end
end