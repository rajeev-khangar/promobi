# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.where(email: 'admin@mailinator.com').first_or_initialize
user.password = 'demouser'
user.role = User::Role::ADMIN
user.first_name = 'Rajeev'
user.last_name  = 'Khangar'
user.confirmed_at = Time.now
user.save!

20.times { User.create(email: Faker::Internet.email, password: 'demouser', 
  first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
  confirmed_at: Time.now ) }

10.times {Project.create(title: Faker::ProgrammingLanguage.name, 
  description: Faker::University.name )}

Project.find_each do |project|
  5.times { project.projects_users.where(user_id: User.order("RANDOM()").limit(1).first.id).first_or_create }

  10.times { project.tasks.create(title: Faker::Lorem.sentence(rand(2..10)).chomp('.'),
    description: Faker::Lorem.paragraphs(2..3),
    user_id: project.users.reload.order("RANDOM()").limit(1).first.id) }
end