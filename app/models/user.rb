class User < ActiveRecord::Base
  # validates :full_name, presence: true
  # validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  # validates :display_name, length: { maximum: 32, minimum: 2 }, presence: false
  has_secure_password
  has_many :orders
  has_many :order_items, through: :orders
  has_many :items, through: :order_items
  enum role: %w(default admin)

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, 
                                  uid: auth.uid)
    user.provider = auth.provider
    user.uid = auth.uid
    user.full_name = auth.info.name
    user.password = auth.credentials.token
    user.save
    user

  end
end
