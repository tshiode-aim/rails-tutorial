require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember(@user)
  end

  test 'current_user returns right user when session is nil' do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'current_user returns nil when remember digest is wrong' do
    # rubocop:disable Rails/SkipsModelValidations
    ## パスワードの入力を回避するため、意図的にバリデーションをスキップする
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    # rubocop:enable Rails/SkipsModelValidations
    assert_nil current_user
  end
end
