class TipsController < ApplicationController

  def create
    resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      req.params['v'] = '20160201'
      req.params['venueId'] = params[:venue_id]
      req.params['text'] = params[:tip]
      req.params['oath_token'] = session[:token]
    end

    redirect_to tips_path
  end

  def index
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['v'] = '20160201'
      req.params['oauth_token'] = session[:token]
    end
    @results = JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

end
