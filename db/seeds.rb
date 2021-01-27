# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "faker"

begin
  User.create!(email: 'test@example.com',
               password: 'password',
               password_confirmation: 'password',
               admin: true) if User.count.zero?
rescue => e
  puts "Error #{e.message}"
end

if Movie.count.zero?
  25.times do |i|
    movie = Movie.new
    movie.title = Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7)
    movie.description = Faker::Lorem.paragraph_by_chars(number: 200)
    movie.release_date = Faker::Date.between(from: '1980-09-23', to: '2020-09-25')
    movie.thumbnail.attach(io: URI.open('http://picsum.photos/640/480'), filename: "#{i}_thumbnail.jpg")
    movie.banner.attach(io: URI.open('http://picsum.photos/1920/1080'), filename: "#{i}_banner.jpg")
    movie.views = Faker::Number.between(from: 1, to: 5000)
    movie.save
  end
end