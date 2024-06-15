class CreateUserForm < BaseForm
  attr_writer :user

  nested_attributes :first_name, :last_name, :email, :password, to: :user

  accessible_attr :first_name, :last_name, :email, :password

  validates_presence_of :first_name, :last_name, :email, :password

  def user
    @user ||= User.new
  end

  def _submit
    user.save!
  end
  alias save submit

  private

  def initialize(args = {})
    super args_key_first args, :user
  end
end
