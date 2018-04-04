class DocumentsMailer < ApplicationMailer
  def one_month_reminder(document_owner)
    @document_owner = document_owner

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    mail(to: @document_owner.owner_email, :from => @from, subject: 'Su documento expirará en un mes')
  end

  def two_weeks_reminder(document_owner)
    @document_owner = document_owner

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    mail(to: @document_owner.owner_email, :from => @from, subject: 'Su documento expirará en dos semanas')
  end

  def one_week_reminder(document_owner)
    @document_owner = document_owner

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    mail(to: @document_owner.owner_email, :from => @from, subject: 'Su documento expirará en una semana')
  end

  def expire_reminder(document_owner)
    @document_owner = document_owner

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    mail(to: @document_owner.owner_email, :from => @from, subject: 'Su documento ha expirado')
  end
end