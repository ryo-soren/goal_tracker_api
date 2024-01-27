# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Goal.destroy_all
User.destroy_all
Completion.destroy_all

PASSWORD = "123"

1.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}@#{last_name}.com",
    username: "#{first_name}_#{last_name}",
    password: PASSWORD
    )
end

users = User.all

20.times do
    # kind = ["one_time", "repeating"]
    frequency = ["daily", "weekly", "monthly"]
    deadline = Faker::Date.between(from: Date.today, to: "2023-12-31")
    time = Faker::Time.between(from: deadline.beginning_of_day, to: deadline.end_of_day)

    g = Goal.create(
        user: users.sample,
        title: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        frequency: frequency.sample,
        times: rand(2..10),
        deadline: DateTime.new(deadline.year, deadline.month, deadline.day, time.hour, time.min, time.sec) ,
        successful: rand(1..10),
        unsuccessful: rand(0..10)
    )

    if g.valid?
        rand(1...g.times).times do
            completion_date = Faker::Date.between(from: "2023-10-01", to: Date.today)
            completion_time = Faker::Time.between(from: completion_date.beginning_of_day, to: completion_date.end_of_day)
                
            Completion.create(
                goal: g,
                user: g.user,
                created_at: DateTime.new(completion_date.year, completion_date.month, completion_date.day, completion_time.hour, completion_time.min, completion_time.sec)
            )
        end
    end
    g.done = g.completions.count
    g.save!
end

goals = Goal.all
completions = Completion.all

puts users.count
puts goals.count
puts completions.count

