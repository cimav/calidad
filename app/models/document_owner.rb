class DocumentOwner < ApplicationRecord
  belongs_to :document
  audited
end
