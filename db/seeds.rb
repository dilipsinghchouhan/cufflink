# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ first_name: 'Chicago' }, { first_name: 'Copenhagen' }])
#   Mayor.create(first_name: 'Emanuel', city: cities.first)

User.create(first_name: 'Michael', last_name: 'Bluth', email: 'michael@bluthcompany.com', password: 'password')
User.create(first_name: 'George', last_name: 'Bluth (Senior)', email: 'george@bluthcompany.com', password: 'password')
User.create(first_name: 'Lucille', last_name: 'Bluth', email: 'lucille@bluthcompany.com', password: 'password')
User.create(first_name: 'George Oscar (GOB)', last_name: 'Bluth', email: 'gob@bluthcompany.com', password: 'password')
User.create(first_name: 'Buster', last_name: 'Bluth', email: 'buster@bluthcompany.com', password: 'password')
User.create(first_name: 'Lindsay', last_name: 'Funke', email: 'lindsay@bluthcompany.com', password: 'password')
User.create(first_name: 'George Michael', last_name: 'Bluth', email: 'george_michael@bluthcompany.com', password: 'password')
User.create(first_name: 'Tobias', last_name: 'Funke', email: 'tobias@analrapist.com', password: 'password')
User.create(first_name: 'Maeby', last_name: 'Funke', email: 'maeby.funke@gmail.com', password: 'password')
User.create(first_name: 'Lucille', last_name: 'Austero', email: 'lucille@standpoor.com', password: 'password')
User.create(first_name: 'Stan', last_name: 'Sitwell', email: 'stan@sitwellenterprises.com', password: 'password')
User.create(first_name: 'Sally', last_name: 'Sitwell', email: 'sally@sitwellenterprises.com', password: 'password')

# Education.create(owner_id: 1, school: "University of Phoenix")
# Link.create(owner_id: 1, title: "Bluth Company Website", url: "http://thebluthcompany.tumblr.com/",
#   type: "Company Website")
# PhoneNumber.create(owner_id: 1, number: "800-867-5309", type: "Office")
# Position.create(owner_id: 1, title: "President", company: "The Bluth Company",
#   industry: "Real Estate", city: "Orange County", state: "CA", start_date: "01 Jan 1990",
#   current_position: true)