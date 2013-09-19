require './config'
require_relative 'app/models/friendship'
require_relative 'app/models/member'
require 'sinatra/activerecord'
require 'sinatra'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

set :database, "sqlite3:///db/members.db"

member = Member.create(first_name: "Bruno")
member2 = Member.create(first_name: "Kiera")
member3 = Member.create(first_name: "Nishant")
friendship = Friendship.create(member_id: member.id, friend_id: member2.id)

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
    Friendship.where('member_id = ?', member.id).take.friend_id == member2.id
  end

end

describe 'friend request page' do
  it 'should show unfriended friends' do
    get "/"
    expect(last_response).to include member3.first_name
  end

  it 'should not show yourself' do 
  end

  it 'should not show current friends' do
  end

  it 'should show pending friendships' do
  end
end

describe 'request a friend' do

  it 'should add to friendship table' do
  end

  it 'should be initially pending' do
  end

  it 'should redirect you to sent request page' do
  end

end


