module SignInSupport
  def sign_in(user)
    visit new_user_registration_path
    fill_in :user_nickname,              with: user.nickname
    fill_in :user_email,                 with: user.email
    fill_in :user_password,              with: user.password
    fill_in :user_password_confirmation, with: user.password_confirmation
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
  end
end