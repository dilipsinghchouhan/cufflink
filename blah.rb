stan = User.create(first_name: 'Stan',
  last_name: 'Sitwell',
  email: 'sarah.mogin+stan@gmail.com',
  password: 'password',
  tagline: "Alopecia Can't Keep Me Down",
  summary: "Stan Sitwell (Ed Begley, Jr.) is a real estate tycoon who runs the company Sitwell Enterprises, which competes with the Bluth Company.\n\nHe has a disease that prevents him from growing hair on his body, alopecia universalis. Lucille incorrectly refers to him as an alpaca. Stan Sitwell begins dating Lucille Austero. His outlandish wigs and fake facial hair are a bit of an inside joke, since in real life Ed Begley Jr. is known for his mane of thick blonde hair. Because of his condition he can't actually drive the Corvette that Michael Bluth gave him in return of making a bid on his daughter Sally Sitwell at the Country Club auction because it is a convertible, which causes him to lose his wig and fake eyebrows. When Stan Sitwell fires Gob Bluth from his company, Gob gets revenge on Sitwell by stealing his fake dressy eyebrows. He runs his business in a very straight forward, professional manner in contrast to the lying and manipulation of the Bluths. He is also a generous philanthropist and contributes to numerous charities, contrary to the Bluths as well.",
  city: "Orange County", state: "CA", industry: "Real Estate",
  pic: File.new("public/images/seeds/stan.png")
)


Company.create(name: "Sitwell Industries", industry: "Real Estate", address1: "4910 Rock Ave", address2: "Suite 101", city: "Orange County", state: "CA",
zip: "90210", summary: "Sitwell Enterprises is the real estate company in Newport Beach, rival to the Bluth Company which is run by Stan Sitwell. It also appears under the name Sitwell Housing Inc.")





#Stan owns Sitwell Enterprises
Membership.create(company_id: 3, member_id: 2, status: 2)

User.create(first_name: 'George', last_name: 'Bluth (Senior)', email: 'george@bluthcompany.com', password: 'password')

Membership.create(company_id: 2, member_id: 3, status: 1)

#lucille is user 4
User.create(first_name: 'Lucille', last_name: 'Bluth', email: 'lucille@bluthcompany.com', password: 'password')

Membership.create(company_id: 2, member_id: 4, status: 1)

User.create(first_name: 'George Oscar (GOB)', last_name: 'Bluth', email: 'gob@bluthcompany.com', password: 'password')

Membership.create(company_id: 2, member_id: 5, status: 0)

User.create(first_name: 'Buster', last_name: 'Bluth', email: 'buster@bluthcompany.com', password: 'password')

Membership.create(company_id: 2, member_id: 6, status: 0)

User.create(first_name: 'Lindsay', last_name: 'Funke', email: 'lindsay@bluthcompany.com', password: 'password')

User.create(first_name: 'George Michael', last_name: 'Bluth', email: 'george_michael@bluthcompany.com', password: 'password')

Membership.create(company_id: 4, member_id: 8, status: 2)

User.create(first_name: 'Tobias', last_name: 'Funke', email: 'tobias@analrapist.com', password: 'password')

User.create(first_name: 'Maeby', last_name: 'Funke', email: 'maeby.funke@gmail.com', password: 'password')

Membership.create(company_id: 4, member_id: 10, status: 1)

User.create(first_name: 'Lucille', last_name: 'Austero', email: 'lucille@standpoor.com', password: 'password')

Membership.create(company_id: 4, member_id: 11, status: 2)

User.create(first_name: 'Sally', last_name: 'Sitwell', email: 'sally@sitwellenterprises.com', password: 'password')

Membership.create(company_id: 2, member_id: 12, status: 1)

Experience.create(owner_id: 1, name: "University of Phoenix", city: "Phoenix", state: "CA", start_date: "01 Jan 2012", current: true, string_1: "Real Estate", string_2: "B.A. in Property Management", body: "Editor in Chief of The Phoenix (student newspaper)")

Experience.create(owner_id: 2, name: "The GAP", city: "Orange County", state: "CA", start_date: "01 Jan 2012", current: true, string_1: "Cashier", string_2: "Other", body: "Employee of the Month for June 2012", position: true)

Friendship.skip_callback(:create, :after, :send_connection_request_email)

  f = Friendship.new(friender_id: 4, friendee_id: 1, message: "Hi", connection_type: "Friend", status: 0)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 4, friendee_id: 2, message: "Hi", connection_type: "Friend", status: 1)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 4, friendee_id: 3, message: "Hi", connection_type: "Friend", status: 2)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 4, friendee_id: 5, message: "Hi", connection_type: "Friend", status: 0)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 4, friendee_id: 6, message: "Hi", connection_type: "Friend", status: 1)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 4, friendee_id: 7, message: "Hi", connection_type: "Friend", status: 2)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 8, friendee_id: 4, message: "Hi", connection_type: "Friend", status: 1)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 9, friendee_id: 4, message: "Hi", connection_type: "Friend", status: 0)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 10, friendee_id: 4, message: "Hi", connection_type: "Friend", status: 2)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 11, friendee_id: 4, message: "Hi", connection_type: "Friend", status: 1)
  f.save(:validate => false)

  f = Friendship.new(friender_id: 12, friendee_id: 4, message: "Hi", connection_type: "Friend", status: 0)
  f.save(:validate => false)

Friendship.set_callback(:create, :after, :send_connection_request_email)

Status.create(user_id: 11, body: "My vertigo is especially bad today!", link: "http://www.webmd.com/brain/tc/dizziness-lightheadedness-and-vertigo-topic-overview")
Status.create(user_id: 11, body: "Oh, Buster!")

Status.create(user_id: 8, company_id: 3, body: "Come on over for a GOB special!")
Status.create(user_id: 8, body: "I regret running for class president.")
Status.create(user_id: 8, body: "One of my favorite videos...", link: "http://www.youtube.com/watch?v=yQjt9_LDS28")

Status.create(user_id: 1, company_id: 1, body: "This is Michael posting on behalf of The Bluth Company")
Status.create(company_id: 1, body: "This is The Bluth Company")


# Link.create(owner_id: 1, title: "Bluth Company Website", url: "http://thebluthcompany.tumblr.com/",
#   type: "Company Website")
# PhoneNumber.create(owner_id: 1, number: "800-867-5309", type: "Office")
# Position.create(owner_id: 1, title: "President", company: "The Bluth Company",
#   industry: "Real Estate", city: "Orange County", state: "CA", start_date: "01 Jan 1990",
#   current_position: true)