# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "faker"

begin
  User.create!(email: 'admin@example.com',
               password: 'password',
               password_confirmation: 'password',
               admin: true) if User.count.zero?
rescue => e
  puts "Error #{e.message}"
end

30.times do |_i|
  User.create!(email: Faker::Internet.unique.email,
               password: 'password',
               password_confirmation: 'password',
               admin: false)
end

pseudo_rng = Random.new

25.times do |i|
  article = Article.new
  article.title = Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7)
  article.body = Faker::Lorem.paragraph_by_chars(number: 1500)
  article.thumbnail.attach(io: URI.open('http://picsum.photos/640/480'), filename: "#{i}_thumbnail.jpg")
  article.banner.attach(io: URI.open('http://picsum.photos/1920/1080'), filename: "#{i}_banner.jpg")
  article.views = Faker::Number.between(from: 1, to: 5000)
  article.save
end

if Movie.count.zero?
  25.times do |i|
    movie = Movie.new
    movie.title = Faker::Lorem.sentence(word_count: 1, random_words_to_add: 2)
    movie.description = Faker::Lorem.paragraph_by_chars(number: 200)
    movie.release_date = Faker::Date.between(from: '1960-09-23', to: '2021-09-25')
    movie.duration = (Date.today.beginning_of_day + rand(0..2).hour + rand(1..60).minutes).to_datetime
    movie.thumbnail.attach(io: URI.open('http://picsum.photos/640/480'), filename: "#{i}_thumbnail.jpg")
    movie.banner.attach(io: URI.open('http://picsum.photos/1920/1080'), filename: "#{i}_banner.jpg")
    movie.views = Faker::Number.between(from: 1, to: 5000)
    movie.save
    (2 + pseudo_rng.rand(8)).times do |_j|
      review = Review.new
      review.body = Faker::Lorem.paragraph_by_chars(number: 1500)
      review.user = User.find(2 + pseudo_rng.rand(10))
      review.score = pseudo_rng.rand(5)
      if review.score
      else
        review.score = 0
      end
      review.movie = movie
      review.save
      (2 + pseudo_rng.rand(8)).times do |_l|
        comment = review.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500),
                                      user: User.find(2 + pseudo_rng.rand(30)))
        comment.save
        pseudo_rng.rand(5).times do |_k|
          nested_comment = comment.comments.build(body: Faker::Lorem.paragraph_by_chars(number: 500),
                                                  user: User.find(2 + pseudo_rng.rand(30)),
                                                  reply: true)
          nested_comment.save
        end
      end
      (2 + pseudo_rng.rand(20)).times do |_m|
        user = User.find(2 + pseudo_rng.rand(30))
        is_helpful = "helpful"
        while Helpful.where(user_id: user.id, review_id: review.id).any?
          user = User.find(2 + pseudo_rng.rand(30))
          if is_helpful == "helpful"
            is_helpful = "unhelpful"
          else
            is_helpful = "helpful"
          end
        end
        helpful = Helpful.new
        helpful.user_id = user.id
        helpful.review_id = review.id
        helpful.is_helpful = is_helpful
        helpful.save
      end
    end
  end
end

30.times do |_i|
  actor = Actor.new
  actor.firstname = Faker::Name.first_name
  actor.lastname = Faker::Name.last_name
  actor.bio = Faker::Lorem.paragraph_by_chars(number: 250)
  actor.date_of_birth = Faker::Date.between(from: '1960-09-23', to: '2011-09-10')
  (2 + pseudo_rng.rand(8)).times do |_j|
    movie = Movie.find(1 + pseudo_rng.rand(25))
    if movie.directed_by
      if Role.where(movie_id: movie.id, actor_id: actor.id).any?
      else
        movie.acted_in_by << actor
      end
    else
      movie.directed_by = actor
      movie.save
    end
  end
end

29.times do |i|
  user = User.find(i+2)
  (2 + pseudo_rng.rand(10)).times do |_j|
    movie = Movie.find(1 + pseudo_rng.rand(25))
    if FavoriteMovie.where(user_id: user.id, movie_id: movie.id).any?
    else
      user.favorites << movie
    end
  end
end