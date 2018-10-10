require 'httparty'
require 'json'

class Postcodesio
  include HTTParty
  attr_accessor :single_postcode_results, :multiple_postcode_results

  base_uri "http://api.postcodes.io"

  def get_single_postcode_results postcode
    @single_postcode_results = JSON.parse self.class.get("/postcodes/#{postcode}").body
  end

  def get_multiple_postcode_results postcodes
    @multiple_postcode_results = JSON.parse self.class.post("/postcodes", :body => {"postcodes": postcodes}).body
  end

  def get_multiple_results_only response
    return response["result"].map {|r| r["result"]}
  end

end
