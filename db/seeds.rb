puts "Cleaning database..."

Review.destroy_all
Pin.destroy_all
Place.destroy_all
Membership.destroy_all
Map.destroy_all
User.destroy_all

puts "Creating users..."
user1 = User.create!(email: "test1@example.com", password: "123456")
user2 = User.create!(email: "test2@example.com", password: "123456")
user3 = User.create!(email: "test3@example.com", password: "123456")

puts "Creating maps..."
map1 = Map.create!(name: "Real British Grub", description: "The best of British in Japan", user: user1)
map2 = Map.create!(name: "My fav conbini", description: "obsessed with conbini", user: user2)
map3 = Map.create!(name: "foodie", description: "The best in Tokyo", user: user3)
map4 = Map.create!(name: "Vintage Heaven", description: "A collection of my favorite vintage stores", user: user2)
map5 = Map.create!(name: "Vintage Koenji", description: "Vintage stores in Koenji are the best!", user: user3)

puts "Creating places..."
Meguro_cantonese = Place.create!(
  title: "目黒菜館",
  address: "〒153-0064 東京都目黒区下目黒１丁目５−１６ 目黒サンライズマンション 102",
  category: "Restaurant",
  latitude: 35.63428281080284,
  longitude: 139.71169040854406,
  opening_hours: "11:00 - 22:00"
)
Shibuya_italian = Place.create!(
  title: "渋谷イタリアン",
  address: "〒150-0043 東京都渋谷区道玄坂２丁目２５−１２",
  category: "Restaurant",
  latitude: 35.658034,
  longitude: 139.701636,
  opening_hours: "11:00 - 23:00"
)
Shinjuku_japanese = Place.create!(
  title: "新宿和食",
  address: "〒160-0022 東京都新宿区新宿３丁目２６−１３",
  category: "Restaurant",
  latitude: 35.690921,
  longitude: 139.700258,
  opening_hours: "11:00 - 22:00"
)
British_pub = Place.create!(
  title: "Swan & Lion Modern British Pub",
  address: "〒153-0051 東京都目黒区上目黒2丁目16-14",
  category: "Pub",
  latitude: 35.642487033598854,
  longitude: 139.69797763923307,
  opening_hours: "12:00 - 23:00"
)
Irish_pub = Place.create!(
  title: "The Cluracan Irish Pub",
  address: "〒164-0001 東京都中野区中野3丁目37-2",
  category: "Pub",
  latitude: 35.70329999503891,
  longitude: 139.6507966238927,
  opening_hours: "12:00 - 23:00"
)
Old_arrow = Place.create!(
  title: "The Old Arrow",
  address: "〒167-0042 東京都杉並区西荻北3丁目14-2",
  category: "Pub",
  latitude: 35.70496436739531,
  longitude: 139.59791480854847,
  opening_hours: "12:00 - 23:00"
)
FamilyMart = Place.create!(
  title: "FamilyMart",
  address: "〒160-0022 東京都新宿区新宿３丁目３４−１１ ピースビル",
  category: "Restaurant",
  latitude: 35.69074777789126,
  longitude: 139.702814235006,
  opening_hours: "11:00 - 22:00"
)

vintage1 = Place.create!(
  title: "Atlantis Vintage Tokyo",
  address: "〒166-0003 東京都杉並区高円寺南４丁目-２５-３高南ビル1F",
  category: "Vintage Store",
  latitude: 35.70446145689981,
  longitude: 139.64891872858115,
  opening_hours: "11:00 - 22:00"
)
vintage2 = Place.create!(
  title: "BIG TIME 高円寺",
  address: "〒166-0003 東京都杉並区高円寺南４丁目２５−３ 1F 2F・3F",
  category: "Vintage Store",
  latitude: 35.7043307734428,
  longitude: 139.64903674577116,
  opening_hours: "11:00 - 22:00"
)
vintage3 = Place.create!(
  title: "アンスティッチ",
  address: "〒166-0003 東京都杉並区高円寺南３丁目４５−１３",
  category: "Vintage Store",
  latitude: 35.703555380524925,
  longitude: 139.64816771009936,
  opening_hours: "11:00 - 22:00"
)
vintage4 = Place.create!(
  title: "Trip 高円寺店",
  address: "〒166-0003 東京都杉並区高円寺南３丁目３７−１",
  category: "Vintage Store",
  latitude: 35.70266055919996,
  longitude: 139.64772373387387,
  opening_hours: "11:00 - 22:00"
)

vintage_tokyo1 = Place.create!(
  title: "NUIR VINTAGE",
  address: "〒150-0042 東京都渋谷区宇田川町３−５ Spark Shibuya, 5階",
  category: "Vintage Store",
  latitude: 35.668639241432075,
  longitude: 139.70044013320344,
  opening_hours: "11:00 - 22:00"
)
vintage_tokyo2 = Place.create!(
  title: "RAGTAG 渋谷店",
  address: "〒150-0042 東京都渋谷区宇田川町２８−６ 渋谷パルコ 3F",
  category: "Vintage Store",
  latitude: 35.661123,
  longitude: 139.698194,
  opening_hours: "11:00 - 22:00"
)
vintage_tokyo3 = Place.create!(
  title: "RAGTAG 原宿店",
  address: "〒150-0001 東京都渋谷区神宮前６丁目２８−９",
  category: "Vintage Store",
  latitude: 35.670164,
  longitude: 139.703056,
  opening_hours: "11:00 - 22:00"
)



puts "Creating pins"
# Pins for map1
pin1 = Pin.create!(
  label: "British Pub",
  place: British_pub,
  user: user1,
  map: map1
)
pin2 = Pin.create!(
  label: "Irish Pub",
  place: Irish_pub,
  user: user1,
  map: map1
)
pin3 = Pin.create!(
  label: "Traditional Pub",
  place: Old_arrow,
  user: user1,
  map: map1
)

# Pins for map2
pin1 = Pin.create!(
  label: "Convenience Store",
  place: FamilyMart,
  user: user2,
  map: map2
)


# Pins for map3
pin1 = Pin.create!(
  label: "Cantonese Cuisine",
  place: Meguro_cantonese,
  user: user3,
  map: map3
)
pin2 = Pin.create!(
  label: "Italian Cuisine",
  place: Shibuya_italian,
  user: user3,
  map: map3
)
pin3 = Pin.create!(
  label: "Japanese Cuisine",
  place: Shinjuku_japanese,
  user: user3,
  map: map3
)

# Pins for map4
pin1 = Pin.create!(
  label: "Vintage Store",
  place: vintage_tokyo1,
  user: user2,
  map: map4
)
pin2 = Pin.create!(
  label: "Vintage Store",
  place: vintage_tokyo2,
  user: user2,
  map: map4
)
pin3 = Pin.create!(
  label: "Vintage Store",
  place: vintage_tokyo3,
  user: user2,
  map: map4
)
# Pins for map5
pin1 = Pin.create!(
  label: "Vintage Store",
  place: vintage1,
  user: user3,
  map: map5
)
pin2 = Pin.create!(
  label: "Vintage Store",
  place: vintage2,
  user: user3,
  map: map5
)
pin3 = Pin.create!(
  label: "Vintage Store",
  place: vintage3,
  user: user3,
  map: map5
)
pin4 = Pin.create!(
  label: "Vintage Store",
  place: vintage4,
  user: user3,
  map: map5
)
# puts "Creating reviews..."
# Review.create!(content: "Delicious food and great service!", title: "Amazing Experience", recommended: 1, pin: pin1, user: user1)
# Review.create!(content: "The pasta was overcooked.", title: "Not Impressed", recommended: 0, pin: pin2, user: user2)
# Review.create!(content: "Authentic Japanese flavors!", title: "A Taste of Japan", recommended: 1, pin: pin3, user: user1)
puts "Creating memberships..."
Membership.create!(user: user1, map: map1)
Membership.create!(user: user1, map: map2)
Membership.create!(user: user1, map: map3)
Membership.create!(user: user2, map: map1)
Membership.create!(user: user2, map: map2)
Membership.create!(user: user2, map: map3)
Membership.create!(user: user2, map: map4)
Membership.create!(user: user3, map: map1)
Membership.create!(user: user3, map: map2)
Membership.create!(user: user3, map: map3)
Membership.create!(user: user3, map: map5)



puts "✅ Seeding complete!"
