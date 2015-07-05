# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.reate([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.reate(name: 'Emanuel', city: cities.first)
User.delete_all
Question.delete_all
Comment.delete_all
10.times do |n|
  User.create(email: "#{n+1}@#{n+1}.ru", password: '12345678', password_confirmation: '12345678')
  Question.create(title: "Вопрос #{n+1} пользователя", body: 'Текст вопроса', user_id: (n+1) )
end