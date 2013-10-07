# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name: 'Michael Bluth', email: 'michael@bluthcompany.com', password: 'password')
User.create(name: 'George Bluth (Senior)', email: 'george@bluthcompany.com', password: 'password')
User.create(name: 'Lucille Bluth', email: 'lucille@bluthcompany.com', password: 'password')
User.create(name: 'George Oscar (GOB) Bluth', email: 'gob@bluthcompany.com', password: 'password')
User.create(name: 'Buster Bluth', email: 'buster@bluthcompany.com', password: 'password')
User.create(name: 'Lindsay Funke', email: 'lindsay@bluthcompany.com', password: 'password')
User.create(name: 'George Michael Bluth', email: 'george_michael@bluthcompany.com', password: 'password')
User.create(name: 'Tobias Funke', email: 'tobias@analrapist.com', password: 'password')
User.create(name: 'Maeby Funke', email: 'maeby.funke@gmail.com', password: 'password')
User.create(name: 'Lucille Austero', email: 'lucille@standpoor.com', password: 'password')
User.create(name: 'Stan Sitwell', email: 'stan@sitwellenterprises.com', password: 'password')
User.create(name: 'Sally Sitwell', email: 'sally@sitwellenterprises.com', password: 'password')

# Education.create(owner_id: 1, school: "University of Phoenix")
# Link.create(owner_id: 1, title: "Bluth Company Website", url: "http://thebluthcompany.tumblr.com/",
#   type: "Company Website")
# PhoneNumber.create(owner_id: 1, number: "800-867-5309", type: "Office")
# Position.create(owner_id: 1, title: "President", company: "The Bluth Company",
#   industry: "Real Estate", city: "Orange County", state: "CA", start_date: "01 Jan 1990",
#   current_position: true)