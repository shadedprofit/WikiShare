require 'faker'

10.times do
  user = User.new(
    name:     Faker::Internet.user_name,
    email:    Faker::Internet.email,
    password: 'helloworld'
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis
50.times do
  Wiki.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

1.times do
  # Create an admin user
  admin = User.new(
    name:     'admin',
    email:    'admin@example.com',
    password: 'helloworld',
    role:     'admin'
  )
  admin.skip_confirmation!
  admin.save!

  # Create a premium user
  premium = User.new(
    name:     'premium',
    email:    'premium@example.com',
    password: 'helloworld',
    role:     'premium'
  )
  premium.skip_confirmation!
  premium.save!

  # Create a member
  member = User.new(
    name:     'member',
    email:    'member@example.com',
    password: 'helloworld'
  )
  member.skip_confirmation!
  member.save!

end

puts "Seed finished"
puts "#{Wiki.count} wikis created."
puts "#{User.count} users created."
