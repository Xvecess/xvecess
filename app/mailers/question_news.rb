class QuestionNews < ApplicationMailer
  layout 'mailer'

  def  question_update_notification(question, user)
    @question = question
    mail(to: user.email, subject: 'Есть новые ответы')
  end
end
