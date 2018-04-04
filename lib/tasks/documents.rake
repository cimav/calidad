#coding:utf-8
desc "Manda un email recordando la actualización de documentos"
task :reminder => :environment do
  today = Date.today
  ######################### Documentos que expiran en 1 mes
  documents = Document.where(revision_date: today - 2.year + 1.month)
  documents.each do |document|
    if document.document_owners.size > 0
      document.document_owners.each do |document_owner|
        DocumentsMailer.one_month_reminder(document_owner).deliver_later
        puts "(Aviso de 1 mes) Se notificará a #{document_owner.owner_email} sobre el documento [#{document.name} | #{document.code}-#{document.revision}]"
      end
    end
  end

  ######################### Documentos que expiran en 2 semanas
  documents = Document.where(revision_date: today - 2.year + 2.weeks)
  documents.each do |document|
    if document.document_owners.size > 0
      document.document_owners.each do |document_owner|
        DocumentsMailer.two_weeks_reminder(document_owner).deliver_later
        puts "(Aviso de 2 semanas) Se notificará a #{document_owner.owner_email} sobre el documento [#{document.name} | #{document.code}-#{document.revision}]"
      end
    end
  end


  ######################### Documentos que expiran en 1 semana
  documents = Document.where(revision_date: today - 2.year + 3.weeks)
  documents.each do |document|
    if document.document_owners.size > 0
      document.document_owners.each do |document_owner|
        DocumentsMailer.one_week_reminder(document_owner).deliver_later
        puts "(Aviso de 1 semana) Se notificará a #{document_owner.owner_email} sobre el documento [#{document.name} | #{document.code}-#{document.revision}]"
      end
    end
  end

  ######################### Documentos que ya expiraron
  documents = Document.where('revision_date < ?', today - 2.year)
  documents.each do |document|
    if document.document_owners.size > 0
      document.document_owners.each do |document_owner|
        DocumentsMailer.expire_reminder(document_owner).deliver_later
        puts "(Aviso de expirado) Se notificará a #{document_owner.owner_email} sobre el documento [#{document.name} | #{document.code}-#{document.revision}]"
      end
    end
  end
end

