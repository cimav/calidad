class Department < ApplicationRecord
  has_many :documents, dependent: :destroy
end
