class User < ApplicationRecord
  before_create :set_hidden_params

  ACTIVE = 1
  DELETED = 99

  ADMIN = 1
  SUPER_USER = 1000

  def set_hidden_params
    self.status = ACTIVE
    self.user_type = ADMIN
  end

end
