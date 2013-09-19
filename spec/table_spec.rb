require_relative '../app/controllers'
require_relative '../app/models/friendship'
require_relative '../app/models/member'
require 'sinatra/activerecord'
require 'sinatra'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

set :database, "sqlite3:///db/members.db"

Member.destroy_all
Friendship.destroy_all

member = Member.create(first_name: "Bruno")
member2 = Member.create(first_name: "Kiera")
member3 = Member.create(first_name: "Nishant")
member4 = Member.create(first_name: "Jon")
friendship = Friendship.create(member_id: member.id, friend_id: member2.id, accepted?: true)
friendship2 = Friendship.create(member_id: member.id, friend_id: member3.id, accepted?: false)


describe 'member' do 
  
  it "should have a name" do
    member.first_name.should == "Bruno"
  end

end

describe 'friends' do 
  
  it "should be in a friendship table" do
    member.id.should == friendship.member_id
  end

  it "should have two friendships" do
    expect Friendship.all.count == 2
  end

  it "member 2 should be friends with member 1" do
    n = Friendship.where('member_id = ?', member.id).take
    n.friend_id == member2.id && n.accepted? == true
  end

end

describe 'friend request page' do
  it 'should show unfriended friends' do
    get "/user/#{member.id}/othermembers"
    expect(last_response.body).to include("#{member4.first_name}")
  end

  it 'should not show yourself' do 
    get "/user/#{member.id}/othermembers"
    expect(last_response.body).to_not include("#{member.first_name}")
  end

  it 'should not show current friends' do
    get "/user/#{member.id}/othermembers"
    expect(last_response.body).to_not include("#{member2.first_name}")
  end

end

describe 'request a friend' do

  it 'should add to friendship table' do
    post "/user/#{member.id}/othermembers"
    expect Friendship.where(:member_id => member.id, :friend_id => member3.id).take != nil
  end

  it 'should be initially pending' do
    post "/user/#{member.id}/othermembers"
    post "/user/#{member.id}/othermembers"
    expect Friendship.where(:member_id => member.id, :friend_id => member3.id, :accepted? => 0).take != nil
  end
end

describe 'friends page' do 
  it "should show friendships you haven't accepted yet" do
    get "/user/#{member.id}/friends"
    expect(last_response.body).to include("#{member3.first_name}")
  end
  
  it "should show confirmed friendships" do
    get "/user/#{member.id}/friends"
    expect(last_response.body).to include("#{member2.first_name}")
  end


  it "should accept pending friendships" do
    post "/user/#{member.id}/friends"
    expect Friendship.where(:member_id => member.id, :friend_id => member3.id, :accepted? => true).take != nil
  end
end



