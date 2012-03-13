module UsersSupport
  def create_user!(params = {})
    User.create!({email:"randy@example.com", name:"Randy", uid:"1234"}.merge(params))
  end

  def create_editor!(params = {})
    create_user!(params.merge(editor:true))
  end

  def create_admin!(params = {})
    create_user!(params.merge(admin:true, editor:true))
  end

  def sign_in(user)
    session[:user_id] = user.id
  end
end
