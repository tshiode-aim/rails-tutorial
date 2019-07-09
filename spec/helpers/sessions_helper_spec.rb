require 'rails_helper'
require 'spec_helper'

describe SessionsHelper, type: :helper do
  let(:user) { create(:user) }

  subject { current_user }

  context 'when remembe user' do
    before { remember(user) }

    context 'with session is nil (= not login)' do
      it 'should returns right user' do
        is_expected.to eq user
      end
    end

    context 'with remember digest is wrong' do
      before 'set wrong digest ' do
        user.update(remember_digest: User.digest(User.new_token))
      end

      it { is_expected.to be_nil }
    end
  end
end