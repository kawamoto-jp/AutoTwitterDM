class SendInfosController < ApplicationController
  before_action :basic_auth

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
  end

  def new
    gon.user_num = SendInfo.count
    if SendInfo.ids.length > 0
      a = SendInfo.all.order(created_at: :desc).limit(1).pluck(:id)
      @value = SendInfo.find_by(id: a).text
    end
    @user = SendInfo.new
  end

  def create
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

  def destroy_all
    SendInfo.destroy_all
    redirect_to root_path
  end

  private

  def self.chart_date
    order(result_date: :asc).pluck('result_date', 'id').to_h
  end

  def send_info_params
    @params = params.require(:send_info).permit(:name, :text, :atena)
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"] 
    end
  end

end
