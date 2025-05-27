require "faker"

puts "Cleaning database..."

Review.destroy_all
Pin.destroy_all
Place.destroy_all
Membership.destroy_all
Map.destroy_all
User.destroy_all

puts "Creating users..."
users = []
5.times do
  users << User.create!(
    email: Faker::Internet.email,
    password: "123456"
  )
end

puts "Creating maps..."
maps = []
users.each do |user|
  maps << Map.create!(
    name: Faker::Address.community,
    description: Faker::Lorem.sentence,
    permission: ["public_access", "private_access"].sample,
    user_id: user.id
  )
end

puts "Creating Tokyo places..."
places = []
10.times do
  places << Place.create!(
    title: Faker::Restaurant.name,
    category: ["Restaurant", "Park", "Museum", "Café", "Landmark"].sample,
    longitude: Faker::Number.decimal(l_digits: 2, r_digits: 6).to_f + 139.65,
    latitude: Faker::Number.decimal(l_digits: 2, r_digits: 6).to_f + 35.60,
    address: "Tokyo, #{Faker::Address.street_address}",
  )
end

puts "Creating pins in Tokyo..."
20.times do
  Pin.create!(
    label: Faker::Lorem.word,
    place: places.sample,
    map: maps.sample,
    user: users.sample
  )
end

puts "✅ Seeding complete!"
