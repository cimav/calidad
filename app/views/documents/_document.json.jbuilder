json.extract! document, :id, :name, :code, :revision, :revision_date, :document_type, :department_id, :created_at, :updated_at
json.url document_url(document, format: :json)
