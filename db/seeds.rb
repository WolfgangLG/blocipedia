User.create!(
    username:     "WolfgangLG",
    first_name:   "Ludwig",
    last_name:    "Gerdes",
    email:        "gerdesludwig@gmail.com",
    password:     "password",
    role:         1,
    confirmed_at: Date.today
)

5.times do
  fn = Faker::Name.first_name
  ln = Faker::Name.last_name
  User.create!(
      username:     Faker::Internet.user_name("#{fn} #{ln}", %w(-)),
      first_name:   fn,
      last_name:    ln,
      email:        Faker::Internet.free_email,
      password:     Faker::Lorem.characters(10),
      role:         Random.rand(2),
      confirmed_at: Date.today
  )
end
users = User.all

5.times do
  Wiki.create!(
      title: Faker::Lorem.sentences(2),
      body:  Faker::Lorem.sentences(3),
      private: Faker::Boolean.boolean,
      user: users.sample
  )
end
