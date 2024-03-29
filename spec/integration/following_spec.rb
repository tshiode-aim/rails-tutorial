require 'rails_helper'
require 'spec_helper'

describe 'following', type: :feature do
  before do
    user.follow(followed)
    follower.follow(user)
    create_list(:micropost, 10, user: user)
    create_list(:micropost, 8, user: followed)
    create_list(:micropost, 12, user: follower)
    log_in_as(user)
  end

  let(:user) { create(:user) }
  let(:followed) { create(:user) }
  let(:follower) { create(:user) }

  subject { page }

  context 'when visit following page' do
    before { visit following_user_path(user) }

    it 'should view following users' do
      user.following.each do |user|
        is_expected.to have_selector("a[href='#{user_path(user)}']")
      end
    end
  end

  context 'when visit followers page' do
    before { visit followers_user_path(user) }

    it 'should view follower users' do
      user.followers.each do |user|
        is_expected.to have_selector("a[href='#{user_path(user)}']")
      end
    end
  end

  context 'when visit home page' do
    before { visit root_path }

    it 'should view user feed' do
      user.feed.each do |micropost|
        is_expected.to have_text(CGI.escapeHTML(micropost.content))
      end
    end
  end
end
