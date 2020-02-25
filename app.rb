require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "c54805539b0bda883ac19578b12383dc"

get "/" do
  # show a view that asks for the location
  view "ask"
end

get "/news" do
    @location = params["location"]
  results = Geocoder.search(params["location"])
    lat_lng = results.first.coordinates
    @lat = lat_lng[0]
    @lng = lat_lng[1]
    @forecast = ForecastIO.forecast(@lat,@lng).to_hash
    @current_temperature = @forecast["currently"]["temperature"]
    @current_conditions = @forecast["currently"]["summary"]
    @daily_forecast = @forecast["daily"]["data"]
  view "news"
end