require_relative 'models/friendship'
require_relative 'models/member'
require 'sinatra/activerecord'
require 'sinatra'
require 'shoulda-matchers'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

set :database, "sqlite3:///db/members.db"

member = Member.create(first_name: "Bruno")
member2 = Member.create(first_name: "Kiera")
friendship = Friendship.create(member_id: 1, friend_id: 2)

p member.id
p member2.id

describe 'member' do 
  
  it "should have a name" do
    member.first_name.should == "Bruno"
  end

end

describe 'friends' do 
  
  it "should be in a friendship table" do
    member.id.should == friendship.member_id
  end

  it "member 2 should be friends with member 1" do
    Friendship.where('member_id = ?', 1).friend_id == member2.id
  end

end

describe 'request a friend' do
  it 'should have a page to see possible friends'
  true
end

# descrbe Member do
#   it { should have_many(:friendships) }
# end

