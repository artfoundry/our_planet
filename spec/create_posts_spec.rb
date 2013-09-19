require 'spec_helper'
describe "Create Posts" do
  include FeatureSpec
  let(:member) { Member.create(first_name: "Zee", last_name: "Spencer") }
  let(:post_attributes) {
    {
      :title => "My post",
      :text => "With a cool description" 
    }
  }
  
  def send_request
    post '/posts', {
      post: post_attributes
    },
    {
      "rack.session" => {
        :member_id => member.id
      }
    }
  end

  describe "post '/posts'" do
    context "when we are logged in" do
      context "and we send a valid post" do
        it "saves the post to the database" do
          send_request
          expect(Post.last.title).to eq "My post"
        end
      end
      context "and we send an invalid post" do
        let(:post_attributes) {
          {
            title: "",
            text: ""  
          }
        }
        it "does not save the post to the database" do
          expect {
            send_request
          }.not_to change { Post.count }
        end
        it "informs the user what was wrong" do
          send_request
          expect(last_response.body).to match /Title must not be blank/
        end
      end
    end
    context "when we are not logged in" do
      it "redirects to the log in page"
    end
  end
end
