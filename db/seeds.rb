# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'test@test.com', password: '123456789')

5.times do |item|
  Category.create(
    id: item,
    name: Faker::Name.first_name, 
    description: Faker::Lorem.sentence(word_count: 5), 
    keywords: Faker::Lorem.sentence(word_count: 3)
  )
end

100.times do
  Product.create(
    id: Faker::Number.number(digits: 10),
    name: Faker::Space.planet,
    price: rand(999),
    description: Faker::Lorem.sentence(word_count: 50),
    preview: Faker::Lorem.sentence(word_count: 10),
    keywords: Faker::Lorem.sentence(word_count: 3),
    unique: false,
    category_id: rand(5)
  )
end

10.times do
  Portfolio.create(
    id: Faker::Number.number(digits: 10),
    name: Faker::Space.planet,
    description: Faker::Lorem.sentence(word_count: 5)
  )
end
