require 'spec_helper'

describe 'Login process' do
  include FeatureSpec
  let(:member) { Member.create(:first_name => "Chuck", :last_name => "Norris", :email => "chuck@everywhere.com", :password => "noneed") }

  
  context "with valid credentials" do
    it "should redirect to the members home page" do
      post '/login', {
        :email => "chuck@everywhere.com",
        :password => "noneed"
      }
      get '/'

      expect(last_response.body).to match /Log me out/
    end
  end

  context "with invalid credentials" do
    it "stays on the log in page" do
      post '/login', {
          :email => "chuck@everywhere",
          :password => "noneed"
        }
        follow_redirect!
        expect(last_response.body).to match /Login page/
    end

    it "does not set the session[:member_id]" do
        post '/login', {
          :email => "chuck@everywhere",
          :password => "noneed"
        }
        expect(session[:member_id]).to eql nil
    end


    context "when login is incorrect" do
      it "takes you back to login page" do
        post '/login', {
          :email => "chuck@everywhere",
          :password => "123"
        }
        follow_redirect!

        expect(last_response.body).to match /invalid login/
      end
    end

    context "when password is invalid" do
      it "displays message notifying user that login is invalid" do
        post '/login', {
          :email => "chuck@everywhere.com",
          :password => "123"
        }
        follow_redirect!

        expect(last_response.body).to match /invalid login/
      end
    end
  end
end
