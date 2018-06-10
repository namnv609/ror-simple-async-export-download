# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..100).each do |idx|
  name = Faker::Name.unique.name
  email = Faker::Internet.email
  addr = Faker::Address.full_address
  phone = Faker::PhoneNumber.cell_phone

  puts "Create user #{idx}:\n\t- Name: #{name}\n\t- Email: #{email}\n\t- Address: #{addr}\n\t- Phone: #{phone}"

  User.create name: name, email: email, address: addr, phone: phone
end
