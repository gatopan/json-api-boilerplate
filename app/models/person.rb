class Person < ActiveRecord::Base
  has_secure_password validations: false

  enum role: {
    :ADMIN => 0,
    :USER => 1,
    :GATOPAN => 2,
  }

  before_validation :generate_token,                                  on: :create

  validates :name,                                                presence: true
  validates :email,                presence: true, uniqueness: true, email: true
  validates :password,                                        confirmation: true
  validates :role,                                                presence: true
  validates :token,                                               presence: true


  def generate_token
    loop do
      self.token = SecureRandom.hex
      break unless self.class.exists?(token: token)
    end
  end

end
