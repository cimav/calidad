class Document < ApplicationRecord
  belongs_to :department
  has_many :document_owners, dependent: :destroy
  audited

  PROCEDURE = 1
  FORMAT = 2
  INSTRUCTION_SHEET = 3
  DATABASE = 4
  MANUAL = 5
  POLITICS = 6
  PLAN = 7


  DOCUMENT_TYPES ={
      PROCEDURE => 'Procedimiento',
      FORMAT => 'Formato',
      INSTRUCTION_SHEET => 'Hoja de instrucción',
      DATABASE => 'Base de datos',
      MANUAL => 'Manual',
      POLITICS => 'Política',
      PLAN => 'Plan',
  }

  def get_document_type
    DOCUMENT_TYPES[self.document_type]
  end
end
