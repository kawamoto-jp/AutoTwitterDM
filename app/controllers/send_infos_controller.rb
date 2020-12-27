class SendInfosController < ApplicationController
  # before_action :set_twitter_client
  # before_action :basic_auth

  def index
    @users = SendInfo.all
    dates = []
    to  = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @items = SendInfo.where(created_at: from...to)
    @items.order(:created_at).pluck(:created_at).each do |created_at|
      dates << created_at.strftime("%m/%d")
    end
    @data = dates.group_by(&:itself).map{ |key, value| [key, value.count] }.to_h
    # binding.pry
  end

  def new
    # binding.pry
    gon.user_num = SendInfo.count
    if SendInfo.ids.length > 0
      a = SendInfo.all.order(created_at: :desc).limit(1).pluck(:id)
      @value = SendInfo.find_by(id: a).text
    end
    @user = SendInfo.new
  end

  def create
    # binding.pry
    @user = SendInfo.new(send_info_params)
    @names = @user.name.split
    user_arys = []
    @names.length.times do
      user_arys << @params
    end

    i = 0
    user_arys.zip(@names) do |user_hash, naming|
      user_hash["name"] = @names[i]
      SendInfo.new(user_hash).save
      i += 1
    end
    @users = SendInfo.all
  end

  private

  def self.chart_date
    order(result_date: :asc).pluck('result_date', 'id').to_h
  end

  def send_info_params
    @params = params.require(:send_info).permit(:name, :text, :atena)
  end


  # def set_twitter_client
  #   @client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  #     config.consumer_secret     = ENV["CONSUMER_SECRET"]
  #     config.access_token        = ENV["ACCESS_TOKEN"]
  #     config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  #   end
  # end

  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"] 
  #   end
  # end

  # @user = SendInfo.new(send_info_params)
#   @names = @user.name.split
#   user_arys = []
#   @names.length.times do
#     user_arys << @params
#   end

#   @users_who_can_not_send = []
#   i = 0
#   user_arys.zip(@names) do |user_hash, naming|
#     if i % 100 == 0 && i != 0
#       # sleep(1800)
#     end
#     user_hash["name"] = @names[i]
#     begin
#       if @params["text"] != ""
#         @client.create_direct_message(@client.user(naming).id, "#{@client.user(naming).name}#{@params["atena"]}\n\n#{@params["text"]}")
#         SendInfo.new(user_hash).save
#       end
#       # sleep(29)
#     rescue
#       @users_who_can_not_send << naming
#       # sleep(29)
#     end
#     i += 1
#   end
# end

# <div class="container">
#   <% if @names.length == 0 %>
#     <p>アカウント名の記載がありません。<br>もう一度やり直してください。</p>
#   <% elsif @users_who_can_not_send.length == 0 %>
#     <p>正常に送信されました。<br>お疲れ様でした。</p>
#   <% elsif @users_who_can_not_send.length != 0 %>
#     <% @users_who_can_not_send.each do |name| %>
#     <h3><%= name %></h3>
#     <% end %>
#     <p>には送信できませんでした。<br>お疲れ様でした。</p>
#   <% end %>
# </div>

end
