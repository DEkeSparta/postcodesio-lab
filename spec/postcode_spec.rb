require 'spec_helper'

describe Postcodesio do

  context 'requesting information on a single postcode works correctly' do

    before(:all) do
      @postcodesio = Postcodesio.new
      @response = @postcodesio.get_single_postcode_results('CV47ES') #input a postcode
      @result = @response["result"]
    end

    it "should respond with a status message of 200" do
      expect(@response["status"]).to eq 200
    end

    it "should have a result hash" do
      expect(@response).to have_key("result")
      expect(@response["result"]).to be_a Hash
    end

    it "should return a postcode between 5-7 in length" do
      expect(@result).to have_key("postcode")
      expect(@result["postcode"].length).to be_between 5,7
    end

    it "should return an quality key integer between 1-9" do
      expect(@result["quality"]).to be_between 1,9
    end

    it "should return an ordnance survey eastings value as integer" do
      expect(@result["eastings"]).to be_a Integer
    end

    it "should return an ordnance survey northings value as integer" do
      expect(@result["northings"]).to be_a Integer
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      expect(@result["country"]).to eq("England").or eq("Scotland").or eq("Wales").or eq("Northern Ireland")
    end

    it "should return a string value for NHS authority " do
      expect(@result["nhs_ha"]).to be_a String
    end

    it "should return a longitude float value" do
      expect(@result["longitude"]).to be_a Float
    end

    it "should return a latitude float value" do
      expect(@result["latitude"]).to be_a Float
    end

    it "should return a parliamentary constituency string" do
      expect(@result["parliamentary_constituency"]).to be_a String
    end

    it "should return a european_electoral_region string" do
      expect(@result["european_electoral_region"]).to be_a String
    end

    it "should return a primary_care_trust string" do
      expect(@result["primary_care_trust"]).to be_a String
    end

    it "should return a region string" do
      expect(@result["region"]).to be_a String
    end

    it "should return a parish string" do
      expect(@result["parish"]).to be_a String
    end

    it "should return a lsoa string" do
      expect(@result["lsoa"]).to be_a String
    end

    it "should return a msoa string" do
      expect(@result["msoa"]).to be_a String
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      expect(@result["admin_district"]).to be_a String
    end

    it "should return a incode string of three characters" do
      expect(@result["incode"].length).to eq 3
    end

  end

  context "multiple postcodes validation" do

    before(:all) do
      @postcodesio = Postcodesio.new
      @response = @postcodesio.get_multiple_postcode_results(["CV47ES","CV49BT", "BT294GZ"]) #Add in array of postcodes
      @results = @postcodesio.get_multiple_results_only(@response)
    end

    it "should respond with a status message of 200" do
      expect(@response["status"]).to eq 200
    end

    it "should return the first query as the first postcode in the response" do
      expect(@response["result"].first["query"].delete(" ")).to eq @results.first["postcode"].delete(" ")
    end

    it "should return the second query as the first postcode in the response" do
      expect(@response["result"][1]["query"].delete(" ")).to eq @results[1]["postcode"].delete(" ")
    end

    it "should have a results hash" do
      @results.each do |result|
        expect(result).to be_a Hash
      end
    end

    it "should return a postcode between 5-7 in length" do
      @results.each do |result|
        expect(result["postcode"].delete(" ").length).to be_between 5,7
      end
    end

    it "should return an quality key integer between 1-9" do
      @results.each do |result|
        expect(result["quality"]).to be_between 1,9
      end
    end

    it "should return an ordnance survey northings value as integer" do
      @results.each do |result|
        expect(result["northings"]).to be_a Integer
      end
    end

    it "should return an ordnance survey eastings value as integer" do
      @results.each do |result|
        expect(result["eastings"]).to be_a Integer
      end
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      @results.each do |result|
        expect(result["country"]).to eq("England").or eq("Scotland").or eq("Wales").or eq("Northern Ireland")
      end
    end

    it "should return a string value for NHS authority " do
      @results.each do |result|
        expect(result["nhs_ha"]).to be_a String
      end
    end

    it "should return a longitude float value" do
      @results.each do |result|
        expect(result["longitude"]).to be_a Float
      end
    end

    it "should return a latitude float value" do
      @results.each do |result|
        expect(result["latitude"]).to be_a Float
      end
    end

    it "should return a parliamentary constituency string" do
      @results.each do |result|
        expect(result["parliamentary_constituency"]).to be_a String
      end
    end

    it "should return a european_electoral_region string" do
      @results.each do |result|
        expect(result["european_electoral_region"]).to be_a String
      end
    end

    it "should return a primary_care_trust string" do
      @results.each do |result|
        expect(result["primary_care_trust"]).to be_a String
      end
    end

    it "should return a region string" do
      @results.each do |result|
        expect(result["region"]).to be_a(String).or eq(nil)
      end
    end

    it "should return a parish string" do
      @results.each do |result|
        expect(result["parish"]).to be_a(String).or eq(nil)
      end
    end

    it "should return a lsoa string" do
      @results.each do |result|
        expect(result["lsoa"]).to be_a String
      end
    end

    it "should return a msoa string" do
      @results.each do |result|
        expect(result["msoa"]).to be_a(String).or eq(nil)
      end
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      @results.each do |result|
        expect(result["admin_district"]).to be_a String
      end
    end

    it "should return a incode string of three characters" do
      @results.each do |result|
        expect(result["incode"]).to be_a String
        expect(result["incode"].length).to eq 3
      end
    end

  end

end
