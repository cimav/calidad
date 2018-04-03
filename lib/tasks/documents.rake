#coding:utf-8
desc "Manda un email recordando la actualización de documentos"
task :reminder => :environment do
  documents = Document.where(revision_date: Date.today-30)
  puts documents.size
end