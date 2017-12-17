# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


admin_user = User.where(admin: true)
admin_user.each do |user|
  Ability.new(user)
end
