# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

User.create!(
  first_name: 'Stephen',
  last_name: 'Leung',
  email: 'lytstephen@gmail.com',
  password: '12345678',
  admin: true
  )

User.create!(
  first_name: 'Hello',
  last_name: 'World',
  email: 'helloworld@hello.com',
  password: 'helloworld',
  admin: true
  )