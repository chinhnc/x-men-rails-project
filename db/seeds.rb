# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create! name: "test", email: "test@gmail.com", password: "123456",
  is_admin: true

10.times do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@gmail.com"
  password = "123456"
  User.create! name: name, email: email, password: password
end

Category.create! name: "Action"
Category.create! name: "Kids"
Category.create! name: "Music"
Category.create! name: "Romance"
Category.create! name: "Shoujo"
Category.create! name: "Adventure"
Category.create! name: "Drama"
Category.create! name: "Hentai"
Category.create! name: "Magic"
Category.create! name: "Sports"
Category.create! name: "Ecchi"
Category.create! name: "Historical"
Category.create! name: "School"
Category.create! name: "Shounen"
Category.create! name: "Comedy"
Category.create! name: "Fantasy"
Category.create! name: "Mecha"
Category.create! name: "Sci-Fi"
Category.create! name: "Supernatural"
Category.create! name: "Slice of Life"

50.times do |n|
  title = Faker::Book.title
  description = Faker::Hipster.paragraph
  episode = Faker::Number.between(1, 30)
  status = Faker::Number.between(0, 1)
  publish_year = Faker::Number.between(2000, 2016)
  category_id = Faker::Number.between(1, 20)
  image = File.open(File.join(Rails.root, "/app/assets/images/sao.jpg"))
  Anime.create! title: title, category_id: category_id, description: description,
    episode: episode, status: status, publish_year: publish_year, image: image
end
