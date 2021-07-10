# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "Owner", email: "owner@gmail.com", role: "owner", password: "owner")
User.create(name: "Walk-in customer", email: "walkin@gmail.com", role: "customer", password: "walkin")
