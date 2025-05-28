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
i = 0
5.times do
  users << User.create!(
    email: "test#{i}@gmail.com",
    password: "123456"
  )
  i += 1
end

puts "Creating maps..."
maps = []
users.each do |user|
  maps << Map.create!(
    name: Faker::Address.community,
    description: Faker::Lorem.sentence,
    permission: "public_access",
    user_id: user.id
  )
end

puts "Creating Tokyo places..."
places = []
10.times do
  places << Place.create!(
    title: Faker::Restaurant.name,
    address: "日本, 〒153-0063 東京都目黒区 目黒#{rand(1..3)}丁目#{rand(1..7)}番#{rand(1..3)}号"
  )
end

puts "Creating pins in Tokyo..."
20.times do
  user = users.sample
  Pin.create!(
    label: Faker::Lorem.word,
    place: places.sample,
    map: user.maps[0],
    user: user
  )
end

puts "✅ Seeding complete!"
