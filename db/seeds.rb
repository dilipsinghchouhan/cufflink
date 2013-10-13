# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ first_name: 'Chicago' }, { first_name: 'Copenhagen' }])
#   Mayor.create(first_name: 'Emanuel', city: cities.first)

User.create(first_name: 'Michael', last_name: 'Bluth', email: 'michael@bluthcompany.com', password: 'password', tagline: "Bluth Company President",
summary: "The one son who had no choice but to keep them all together.\n\nMichael Bluth is a fictional character and the protagonist of the television sitcom Arrested Development, created by Mitchell Hurwitz. He is portrayed by Jason Bateman. His role in the story is to lead his family through their many crises, and he serves as the straight man on the show.",
city: "Orange County", state: "CA", industry: "Real Estate")

User.create(first_name: 'Stan', last_name: 'Sitwell', email: 'stan@sitwellenterprises.com', password: 'password', tagline: "Alopecia Can't Keep Me Down",
summary: "Stan Sitwell (Ed Begley, Jr.) is a real estate tycoon who runs the company Sitwell Enterprises, which competes with the Bluth Company.\n\nHe has a disease that prevents him from growing hair on his body, alopecia universalis. Lucille incorrectly refers to him as an alpaca. Stan Sitwell begins dating Lucille Austero. His outlandish wigs and fake facial hair are a bit of an inside joke, since in real life Ed Begley Jr. is known for his mane of thick blonde hair. Because of his condition he can't actually drive the Corvette that Michael Bluth gave him in return of making a bid on his daughter Sally Sitwell at the Country Club auction because it is a convertible, which causes him to lose his wig and fake eyebrows. When Stan Sitwell fires Gob Bluth from his company, Gob gets revenge on Sitwell by stealing his fake dressy eyebrows. He runs his business in a very straight forward, professional manner in contrast to the lying and manipulation of the Bluths. He is also a generous philanthropist and contributes to numerous charities, contrary to the Bluths as well.",
city: "Orange County", state: "CA", industry: "Real Estate")

Company.create(name: "The Bluth Company", industry: "Real Estate", address1: "101 S Oxford Street", address2: "Suite 2B", city: "Orange County", state: "CA",
zip: "90210", summary: "The Bluth Company is a real estate development firm founded by George Bluth. Sometime during the late '80s or early '90s, the company was involved with Saddam Hussein in creating homes in Iraq; these homes went undiscovered by American authorities until about a decade later. In the series' first episode, George's wife Lucille Bluth was named CEO of the company shortly before he was arrested for fraud. The company is based in the Bluth Company offices.\n\nThe company was eventually purchased by Lucille Austero who renamed the company the Austero Bluth Company.")

Company.create(name: "Sitwell Industries", industry: "Real Estate", address1: "4910 Rock Ave", address2: "Suite 101", city: "Orange County", state: "CA",
zip: "90210", summary: "Sitwell Enterprises is the real estate company in Newport Beach, rival to the Bluth Company which is run by Stan Sitwell. It also appears under the name Sitwell Housing Inc.")

Company.create(name: "The Banana Stand", industry: "Banana Stand", address1: "123 Pier Way", city: "Orange County", state: "CA",
zip: "90210", summary: '"Bluth\'s Original Frozen Banana", a frozen banana stand was started by George in 1953 as part of the Bluth Company. It is located on the Oceanside Wharf boardwalk, on Balboa Island in Newport Beach. Throughout the series, the banana stand gets destroyed and rebuilt several times.')

Membership.create(company_id: 1, member_id: 1, status: 2)
Membership.create(company_id: 2, member_id: 2, status: 2)

User.create(first_name: 'George', last_name: 'Bluth (Senior)', email: 'george@bluthcompany.com', password: 'password')

Membership.create(company_id: 1, member_id: 3, status: 1)

User.create(first_name: 'Lucille', last_name: 'Bluth', email: 'lucille@bluthcompany.com', password: 'password')

Membership.create(company_id: 1, member_id: 4, status: 1)

User.create(first_name: 'George Oscar (GOB)', last_name: 'Bluth', email: 'gob@bluthcompany.com', password: 'password')

Membership.create(company_id: 1, member_id: 5, status: 0)

User.create(first_name: 'Buster', last_name: 'Bluth', email: 'buster@bluthcompany.com', password: 'password')

Membership.create(company_id: 1, member_id: 6, status: 0)

User.create(first_name: 'Lindsay', last_name: 'Funke', email: 'lindsay@bluthcompany.com', password: 'password')

User.create(first_name: 'George Michael', last_name: 'Bluth', email: 'george_michael@bluthcompany.com', password: 'password')

Membership.create(company_id: 3, member_id: 8, status: 2)

User.create(first_name: 'Tobias', last_name: 'Funke', email: 'tobias@analrapist.com', password: 'password')

User.create(first_name: 'Maeby', last_name: 'Funke', email: 'maeby.funke@gmail.com', password: 'password')

Membership.create(company_id: 3, member_id: 10, status: 1)

User.create(first_name: 'Lucille', last_name: 'Austero', email: 'lucille@standpoor.com', password: 'password')

Membership.create(company_id: 4, member_id: 11, status: 2)

User.create(first_name: 'Sally', last_name: 'Sitwell', email: 'sally@sitwellenterprises.com', password: 'password')

Membership.create(company_id: 2, member_id: 12, status: 1)

Education.create(owner_id: 1, school: "University of Phoenix", city: "Phoenix", state: "CA", start_date: "01 Jan 2012", current_student: true, string_1: "Real Estate", string_2: "B.A. in Property Management", body: "Editor in Chief of The Phoenix (student newspaper)")

Education.create(owner_id: 2, school: "The GAP", city: "Orange County", state: "CA", start_date: "01 Jan 2012", current_student: true, string_1: "Cashier", string_2: "Other", body: "Employee of the Month for June 2012", position: true)
# Link.create(owner_id: 1, title: "Bluth Company Website", url: "http://thebluthcompany.tumblr.com/",
#   type: "Company Website")
# PhoneNumber.create(owner_id: 1, number: "800-867-5309", type: "Office")
# Position.create(owner_id: 1, title: "President", company: "The Bluth Company",
#   industry: "Real Estate", city: "Orange County", state: "CA", start_date: "01 Jan 1990",
#   current_position: true)