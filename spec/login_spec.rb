require 'spec_helper'

describe 'Login process' do
  let(:member) { Member.create(:first_name => "Chuck", :last_name => "Norris", :email => "chuck@everywhere.com", :password => "noneed") }

  
    context "with valid credentials" do
      it "should set the session[:member_id] to the members id"
      it "should redirect to the members home page"
    end

    context "with invalid credentials" do
      it "stays on the log in page"
      it "does not set the session[:member_id]"
      context "when the email isn't even an email address" do
        it "displays message notifying email format is invalid"
      end
      context "when the member provides an email that doesn't exist" do
        it "displays message notifying user that login is invalid"
      end
      context "when password is invalid" do
        it "displays message notifying user that login is invalid"
      end
    end
end
