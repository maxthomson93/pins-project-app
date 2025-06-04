puts "Cleaning database..."

ActsAsVotable::Vote.destroy_all
Review.destroy_all
Pin.destroy_all
Place.destroy_all
Membership.destroy_all
Map.destroy_all
User.destroy_all

puts "Creating users..."
users = []
30.times do |i|
  users << User.create!(
    email: "test#{i+1}@example.com",
    password: "123456"
  )
end

puts "Creating maps..."
map1 = Map.create!(name: "Jay Chou Fangirls", description: "Places our boy has walked!", user: users[0], permission: 0)
map2 = Map.create!(name: "Tattoo Friendly", description: "Tattoo friendly spots in Tokyo!", user: users[1], permission: 0)
map3 = Map.create!(name: "Onsen Hunter", description: "The best onsen in Tokyo", user: users[2], permission: 0)
map4 = Map.create!(name: "Vegan Tokyo", description: "Animal friendly foods!", user: users[1], permission: 0)
map5 = Map.create!(name: "English Doctors", description: "English speaking doctors in Tokyo", user: users[2], permission: 0)
map_names = [
  "Cozy Bookstores",
  "Vegan Eats",
  "Craft Beer Tour",
  "Tokyo Dessert Map",
  "Budget Bites",
  "Luxury Dining"
]
maps = []
map_names.each_with_index do |name, i|
  maps << Map.create!(
    name: name,
    description: "Explore #{name} in Tokyo!",
    user: users.first,
    permission: 0
  )
end

# puts "Creating reviews..."
# Review.create!(content: "Delicious food and great service!", title: "Amazing Experience", recommended: 1, pin: pin1, user: user1)
# Review.create!(content: "The pasta was overcooked.", title: "Not Impressed", recommended: 0, pin: pin2, user: user2)
# Review.create!(content: "Authentic Japanese flavors!", title: "A Taste of Japan", recommended: 1, pin: pin3, user: user1)
puts "Creating memberships..."
Membership.create!(user: users[0], map: map1)
Membership.create!(user: users[0], map: map2)
Membership.create!(user: users[0], map: map3)
Membership.create!(user: users[1], map: map1)
Membership.create!(user: users[1], map: map2)
Membership.create!(user: users[1], map: map3)
Membership.create!(user: users[1], map: map4)
Membership.create!(user: users[2], map: map1)
Membership.create!(user: users[2], map: map2)
Membership.create!(user: users[2], map: map3)
Membership.create!(user: users[2], map: map5)

puts "✅ Seeding complete!"
