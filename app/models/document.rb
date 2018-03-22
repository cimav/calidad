class Document < ApplicationRecord
  belongs_to :department
  has_many :document_owners

  MASTER_LIST = 1
  PROCEDURE = 2
  QUALITY_POLITICS = 3


  DOCUMENT_TYPES ={
      MASTER_LIST => 'Listado maestro',
      PROCEDURE => 'Procedimiento',
      QUALITY_POLITICS => 'Política de calidad'
  }

  def get_document_type
    DOCUMENT_TYPES[self.document_type]
  end
end
