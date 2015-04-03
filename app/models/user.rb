class User < ActiveRecord::Base
  validates :full_name, presence: true
  validates :email,
             format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  has_secure_password
  has_many :orders
  has_many :order_items, through: :orders
  has_many :items, through: :order_items
  enum role: %w(default admin)

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user.provider = auth.provider
    user.uid = auth.uid
    user.full_name = auth.info.name
    user.password = auth.credentials.token
    user.display_name = auth.info.nickname
    user.location = auth.info.location
    user.image = auth.info.image
    user.save
    user
  end
end
