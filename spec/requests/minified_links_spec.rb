require 'rails_helper'

RSpec.describe "MinifiedLinks", type: :request do
  describe "GET /" do
    it "opens home page" do
      get minified_links_path
      expect(response).to have_http_status(200)

      expect(response.body).to include("Little URL")
    end
  end
end
