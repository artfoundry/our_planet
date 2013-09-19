require 'spec_helper'

describe Post do
  let(:member) { Member.create(first_name: "Zee", last_name: "Spencer") }
  let(:post) { Post.create(post_attributes) }
  describe "validations" do
    context "without a member" do
      let(:post_attributes) { { title: "With Our Powers Combined", text: "We are... CAPTAIN PLANET" } }

      it "is invalid" do
        expect(post.errors).to have_key(:member_id)
      end
    end
    context "without a title" do
      let(:post_attributes) { { member_id: member.id, text: "We are... CAPTAIN PLANET" } }

      it "is invalid" do
        expect(post.errors).to have_key(:title)
      end
    end
    context "without a text" do
      let(:post_attributes) { { member_id: member.id, title: "Just a title.." } }

      it "must have a description" do
        expect(post.errors).to have_key(:text)
      end
    end
  end
end
