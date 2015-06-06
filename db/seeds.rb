# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.find_or_initialize_by(email: 'admin@hello.com')
user.first_name = 'Admin'
user.last_name = 'Person'
user.password = '12345678'
user.admin = 'true'
user.save!

user2 = User.find_or_initialize_by(email: 'lytstephen@gmail.com')
user2.first_name = 'Stephen'
user2.last_name = 'Leung'
user2.password = '12345678'
user2.admin = 'true'
user2.save!

user3 = User.find_or_initialize_by(email: 'buyer@hello.com')
user3.first_name = 'Buyer'
user3.last_name = 'Person'
user3.password = '12345678'
user3.admin = 'false'
user3.save!

user4 = User.find_or_initialize_by(email: 'seller@hello.com')
user4.first_name = 'Seller'
user4.last_name = 'Person'
user4.password = '12345678'
user4.admin = 'false'
user4.save!

category = Category.find_or_initialize_by(name: 'Valentines Day')
category.save!
category2 = Category.find_or_initialize_by(name: 'Fathers Day')
category2.save!
category3 = Category.find_or_initialize_by(name: 'Birthday')
category3.save!
category4 = Category.find_or_initialize_by(name: 'Anniversaries')
category4.save!
category5 = Category.find_or_initialize_by(name: 'Mothers Day')
category5.save!

course = Course.find_or_initialize_by(title: 'Valentine Hand Made Chocolate')
course.description = 'Make delicious chocolate for your special someone!'
course.video_link = 'https://www.youtube.com/embed/Xj0Q7Bt5x3s'
course.video_cost = 50
course.materials = "Chocolate 50g\nWhite Chocloate 20g\nCocoa Powder 10g\nSugar 30g"
course.material_cost = 150
course.user_id = user4.id
course.category = category
course.save!

course2 = Course.find_or_initialize_by(title: 'Origami Roses' )
course2.description = 'Roses that does not wither, but look just as good!'
course2.video_link = 'https://www.youtube.com/embed/dkae0ftYKjk'
course2.materials = "origami paper white x 10\norigami paper red x 10\nRibbon (colour of your choice) 3ft"
course2.video_cost = 100
course2.material_cost = 200
course2.user_id = user4.id
course2.category = category4
course2.save!

course3 = Course.find_or_initialize_by(title: 'Fathers Day Hand Made Tie' )
course3.description = 'This is a tie that your dad is going to want to wear to work everyday!'
course3.video_link = 'https://www.youtube.com/embed/dkae0ftYKjk'
course3.materials = "Leather 3sq meter\nNeddles\nHello World"
course3.video_cost = 100
course3.material_cost = 300
course3.user_id = user4.id
course3.category = category2
course3.save!

















