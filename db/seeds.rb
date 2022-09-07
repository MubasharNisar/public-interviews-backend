# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Account.create(email: 'steve@gmail.com', first_name: 'Steve', last_name: 'Jobs',phone_number: '+923456556676', status: 1, balance_cents: 200)
Account.create(email: 'mustafa@gmail.com', first_name: 'Mustafa', last_name: 'Khan',phone_number: '+923456656676', status: 1, balance_cents: 100)
Account.create(email: 'notverified@gmail.com', first_name: 'Not', last_name: 'Verified',phone_number: '+923454856676', status: -1, balance_cents: 0)
