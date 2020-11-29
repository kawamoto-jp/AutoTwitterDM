class SendInfosController < ApplicationController
  before_action :set_twitter_client

  def index
    dates = []
    @managemants = SendInfo.all
    SendInfo.order(:created_at).pluck(:created_at).each do |created_at|
      dates << created_at.strftime("%Y年%m月%d日")
    end
    @data = dates.group_by(&:itself).map{ |key, value| [key, value.count] }.to_h
  end


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

  def self.chart_date
    order(result_date: :asc).pluck('result_date', 'id').to_h
  end

  def send_info_params
    @params = params.require(:send_info).permit(:name, :text)
  end

  def set_twitter_client
    
  end
end
