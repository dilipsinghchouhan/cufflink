#Michael
michael = User.create(
  first_name: 'Michael',
  last_name: 'Bluth',
  email: 'sarah.mogin+michael@gmail.com',
  password: 'password',
  tagline: "Bluth Company President",
  summary: "Passepartout was not the man to let an idea go begging, and directed his steps towards the docks.  But, as he approached them, his project, which at first had seemed so simple, began to grow more and more formidable to his mind.  What need would they have of a cook or servant on an American steamer, and what confidence would they put in him, dressed as he was?  What references could he give?\n\nAs he was reflecting in this wise, his eyes fell upon an immense placard which a sort of clown was carrying through the streets.  This placard, which was in English, read as follows:\n\nACROBATIC JAPANESE TROUPE,     HONOURABLE WILLIAM BATULCAR, PROPRIETOR,             LAST REPRESENTATIONS,  PRIOR TO THEIR DEPARTURE TO THE UNITED STATES,                   OF THE          LONG NOSES!   LONG NOSES!  UNDER THE DIRECT PATRONAGE OF THE GOD TINGOU!            GREAT ATTRACTION!\n\n'The United States!' said Passepartout; 'that's just what I want!'\n\nHe followed the clown, and soon found himself once more in the Japanese quarter.  A quarter of an hour later he stopped before a large cabin, adorned with several clusters of streamers, the exterior walls of which were designed to represent, in violent colours and without perspective, a company of jugglers.",
  city: "Orange County",
  state: "CA",
  industry: "Real Estate",
  pic: File.new("public/images/seeds/michael.jpg")
)

#The Bluth Company
the_bluth_company = Company.create(
  name: "The Bluth Company",
  industry: "Real Estate",
  address1: "101 S Oxford Street",
  address2: "Suite 2B",
  city: "Orange County",
  state: "CA",
  zip: "90210",
  summary: "The Bluth Company is a real estate development firm founded by George Bluth. Sometime during the late '80s or early '90s, the company was involved with Saddam Hussein in creating homes in Iraq; these homes went undiscovered by American authorities until about a decade later. In the series' first episode, George's wife Lucille Bluth was named CEO of the company shortly before he was arrested for fraud. The company is based in the Bluth Company offices.\n\nThe company was eventually purchased by Lucille Austero who renamed the company the Austero Bluth Company.",
  pic: File.new("public/images/seeds/bluth-company.jpg")
)

#The Banana Stand
the_banana_stand = Company.create(
  name: "The Banana Stand",
  industry: "Banana Stand",
  address1: "123 Pier Way",
  city: "Orange County",
  state: "CA",
  zip: "90210",
  summary: '"Bluth\'s OriginalFrozen Banana", a frozen banana stand was started by George in 1953 as part of the Bluth Company. It is located on the Oceanside Wharf boardwalk, on Balboa Island in Newport Beach. Throughout the series, the banana stand gets destroyed and rebuilt several times.',
  pic: File.new("public/images/seeds/banana-stand.png")
)

#Michael owns The Bluth Company
the_bluth_company.memberships.create(
  member_id: michael.id,
  status: 2
)

#Michael has The Bluth Company listed as his current position
michael_bc = michael.experiences.build(
  name: "The Bluth Company",
  city: "Orange County",
  state: "CA",
  start_date: "01 Jan 2003",
  current: true,
  string_1: "President",
  string_2: "Real Estate",
  body: "The Bluth Company is a family business specializing in the development of McMansions in and around Orange County, CA. Once we were accused of light treason with Saddam Hussein, but it turned out that my father, George Bluth (Senior), was just a CIA patsy."
)
michael_bc.position = true
michael_bc.save

#Michael has The Banana Stand listed as a previous position
michael_bs = michael.experiences.build(
  name: "The Banana Stand",
  city: "Orange County",
  state: "CA",
  start_date: "01 Jan 1970",
  end_date: "03 Feb 1976",
  string_1: "Manager",
  string_2: "Banana Stand",
  body: "I spent some of my best summers at The Banana Stand. There's always money at The Banana Stand. I can't believe I gave GOB animation rights. Let's burn it down."
)
michael_bs.position = true
michael_bs.save

#Michael used to go to Balboa High School
michael.experiences.create(
  name: "Balboa High School",
  city: "Orange County",
  state: "CA",
  start_date: "01 Sept 1978",
  end_date: "22 Feb 1982",
  string_2: "High School Diploma",
  body: "I starred in a production of \"The Trial of Captain Hook.\" Lyrics include: \"You're a crook Captain Hook just won't you throw the book...\""
)

#Michael current attends the University of Phoenix
michael.experiences.create(
  name: "University of Phoenix",
  city: "Orange County",
  state: "CA",
  start_date: "01 Sept 2012",
  current: true,
  string_1: "Maritime Law",
  string_2: "BA in Law",
  body: "No time for musicals here!"
)

#Michael's statuses
michael.statuses.create(
  body: "Wow, this site is cool!",
  link: "http://www.cufflinkapp.com"
)

michael.statuses.create(
  body: "I can't believe I let GOB cut the Ribbon!",
  pic: File.new("public/images/seeds/ribbon.jpg")
)

michael.statuses.create(
  body: "I have the worst of !@$%ing attorneys.",
  pic: File.new("public/images/seeds/shark.jpg")
)

michael.statuses.create(
  body: "This is why I sometimes pretend to be a maritime lawyer...",
  link: "https://www.youtube.com/watch?v=TdeSh3vLvYI"
)

michael.statuses.create(
  body: "Michael Bluth and family gather to discuss George Sr.'s upcoming trial. They've received a plea offer, but lawyer Barry Zuckerkorn hasn't read it yet. Lucille, speaking for George Sr., wants to accept the plea. Cindi Lightballoon, an undercover FBI agent, watched George Sr.'s \"Caged Wisdom\" series of self-help videos and fell in love with him. She tells George Sr. that she knows for a fact that he can beat the government's case against him. Michael takes the plea documents to a nearby bar to read.\n\n
Meanwhile, Lindsay receives a letter from Maeby's school saying that her daughter is failing. Lindsay and Tobias hire George Michael to tutor Maeby. Later, Maeby shows George Michael a recent (failed) test and pays him to fill in the correct answers.\n\n
Michael sits down to read the plea, but Gob suggests he have a one-night stand with a lawyer instead. As Michael reads the plea, a woman, Maggie Lizer, bumps into him. Michael introduces himself as \"Chareth Cutestory,\" maritime lawyer; he goes home with Maggie. The following morning, Maggie appears with coffee and he suddenly realizes that she is blind."
)

#The Bluth Company's statuses
the_bluth_company.statuses.create(
  body: "Have you been to our company website?",
  link: "http://thebluthcompany.tumblr.com"
)

the_bluth_company.statuses.create(
  body: "Another successful \"Bring Your Daughter to Work Day\" at the Bluth Company. Wait... is that a boy?",
  pic: File.new("public/images/seeds/daughter.png")
)

the_bluth_company.statuses.create(
  body: "Spotlight on Starla, our Employee of the Month!\n\nStartla is an Executive Assistant with a great relationship with her mother. She also used to model for a boat, which she promoted under the slogan \"Solid as a Rock\".\n\nWhen asked how she first heard about The Bluth Company, Starla said, \"A magician named Gob!\"",
  pic: File.new("public/images/seeds/starla.png")
)

the_bluth_company.statuses.create(
  body: "Free whistles!",
  pic: File.new("public/images/seeds/whistles.png")
)

the_bluth_company.statuses.create(
  body: "Please return all of the whistles."
)

#The Bluth Company's statuses on behalf of Michael
s1 = Status.new(
  body: "Hello everyone, this is Michael Bluth, the President of The Bluth Company. GOB is not the President; please do not do anything he says."
)
s1.company = the_bluth_company
s1.user = michael
s1.save

#Michael's contact info
michael.contacts.create(
  name: "Personal",
  contact_type: 0,
  value: "michael@gmail.com"
)

michael.contacts.create(
  name: "Personal",
  contact_type: 1,
  value: "867-5309"
)

michael.contacts.create(
  name: "Office",
  contact_type: 1,
  value: "1-800-867-5309"
)

michael.contacts.create(
  name: "Company Website",
  contact_type: 2,
  value: "http://thebluthcompany.tumblr.com"
)

michael.contacts.create(
  name: "Facebook",
  contact_type: 2,
  value: "https://www.facebook.com/ArrestedDevelopment"
)

#The Bluth company's contact info
the_bluth_company.contacts.create(
  name: "Company",
  contact_type: 0,
  value: "corporate@thebluthcompany.com"
)

the_bluth_company.contacts.create(
  name: "Sales",
  contact_type: 0,
  value: "sales@thebluthcompany.com"
)

the_bluth_company.contacts.create(
  name: "Office",
  contact_type: 1,
  value: "1-800-867-5309"
)

the_bluth_company.contacts.create(
  name: "Company Website",
  contact_type: 2,
  value: "http://thebluthcompany.tumblr.com"
)

the_bluth_company.contacts.create(
  name: "Facebook",
  contact_type: 2,
  value: "http://www.facebook.com/bluthcompanyblog"
)

#Stan
stan = User.create(first_name: 'Stan',
  last_name: 'Sitwell',
  email: 'sarah.mogin+stan@gmail.com',
  password: 'password',
  tagline: "Alopecia Can't Keep Me Down",
  summary: "Stan Sitwell (Ed Begley, Jr.) is a real estate tycoon who runs the company Sitwell Enterprises, which competes with the Bluth Company.\n\nHe has a disease that prevents him from growing hair on his body, alopecia universalis. Lucille incorrectly refers to him as an alpaca. Stan Sitwell begins dating Lucille Austero. His outlandish wigs and fake facial hair are a bit of an inside joke, since in real life Ed Begley Jr. is known for his mane of thick blonde hair. Because of his condition he can't actually drive the Corvette that Michael Bluth gave him in return of making a bid on his daughter Sally Sitwell at the Country Club auction because it is a convertible, which causes him to lose his wig and fake eyebrows. When Stan Sitwell fires Gob Bluth from his company, Gob gets revenge on Sitwell by stealing his fake dressy eyebrows. He runs his business in a very straight forward, professional manner in contrast to the lying and manipulation of the Bluths. He is also a generous philanthropist and contributes to numerous charities, contrary to the Bluths as well.",
  city: "Orange County", state: "CA", industry: "Real Estate",
  pic: File.new("public/images/seeds/stan.png")
)

#Sitwell Enterprises
sitwell_enterprises = Company.create(
  name: "Sitwell Enterprises",
  industry: "Real Estate",
  address1: "4910 Rock Ave",
  address2: "Suite 101",
  city: "Orange County",
  state: "CA",
  zip: "90210",
  summary: "Sitwell Enterprises is the real estate company in Newport Beach, rival to the Bluth Company which is run by Stan Sitwell. It also appears under the name Sitwell Housing Inc.",
  pic: File.new("public/images/seeds/sitwell.jpg")
)

#Stan owns Sitwell Enterprises
sitwell_enterprises.memberships.create(
  member_id: stan.id,
  status: 2
)

#Stan has Sitwell Enterprises listed as his current position
stan_se = stan.experiences.build(
  name: "Sitwell Enterprises",
  city: "Orange County",
  state: "CA",
  start_date: "01 Jan 1999",
  current: true,
  string_1: "President",
  string_2: "Real Estate",
  body: "My top priority is the company softball league."
)
stan_se.position = true
stan_se.save

#Stan used to work at The Gap
stan_gap = stan.experiences.build(
  name: "The GAP",
  city: "Beverly Hills",
  state: "CA",
  start_date: "01 Jan 1970",
  end_date: "01 Jan 1980",
  string_1: "Cashier",
  string_2: "Other",
  body: "Employee of the Month for June 1977"
)
stan_gap.position = true
stan_gap.save

#Stan used to go to Balboa High School
michael.experiences.create(
  name: "Balboa High School",
  city: "Orange County",
  state: "CA",
  start_date: "01 Sept 1978",
  end_date: "22 Feb 1982",
  string_2: "High School Diploma",
  body: "Editor in Chief of the Yearbook"
)

#Stan's statuses
stan.statuses.create(
  body: "Do I look surprised? I'm not.",
  pic: File.new("public/images/seeds/surprised.png")
)

stan.statuses.create(
  pic: File.new("public/images/seeds/hitter.png")
)

stan.statuses.create(
  link: "http://www.cufflinkapp.com"
)

stan.statuses.create(
body: "Do I look better as a blonde? Sorry for all the selfies.",
pic: File.new("public/images/seeds/surprised.png")
)

stan.statuses.create(
  body: "But though thus contrasting within, the contrast was only in shades and shadows without; those two seemed one; it was only the sex, as it were, that distinguished them.\n\nAloft, like a royal czar and king, the sun seemed giving this gentle air to this bold and rolling sea; even as bride to groom. And at the girdling line of the horizon, a soft and tremulous motion&mdash;most seen here at the Equator&mdash;denoted the fond, throbbing trust, the loving alarms, with which the poor bride gave her bosom away.\n\nTied up and twisted; gnarled and knotted with wrinkles; haggardly firm and unyielding; his eyes glowing like coals, that still glow in the ashes of ruin; untottering Ahab stood forth in the clearness of the morn; lifting his splintered helmet of a brow to the fair girl's forehead of heaven.\n\nOh, immortal infancy, and innocency of the azure! Invisible winged creatures that frolic all round us! Sweet childhood of air and sky! how oblivious were ye of old Ahab's close-coiled woe! But so have I seen little Miriam and Martha, laughing-eyed elves, heedlessly gambol around their old sire; sporting with the circle of singed locks which grew on the marge of that burnt-out crater of his brain.\n\nSlowly crossing the deck from the scuttle, Ahab leaned over the side and watched how his shadow in the water sank and sank to his gaze, the more and the more that he strove to pierce the profundity. But the lovely aromas in that enchanted air did at last seem to dispel, for a moment, the cankerous thing in his soul. That glad, happy air, that winsome sky, did at last stroke and caress him; the step-mother world, so long cruel&mdash;forbidding&mdash;now threw affectionate arms round his stubborn neck, and did seem to joyously sob over him, as if over one, that however wilful and erring, she could yet find it in her heart to save and to bless. From beneath his slouched hat Ahab dropped a tear into the sea; nor did all the Pacific contain such wealth as that one wee drop.\n\nStarbuck saw the old man; saw him, how he heavily leaned over the side; and he seemed to hear in his own true heart the measureless sobbing that stole out of the centre of the serenity around. Careful not to touch him, or be noticed by him, he yet drew near to him, and stood there."
)

#Sitwell Enterprises' statuses
sitwell_enterprises.statuses.create(
  body: "Have you been to our company website?",
  link: "http://www.sitwellenterprises.com"
)

sitwell_enterprises.statuses.create(
  body: "Gearing up for the company softball game",
  pic: File.new("public/images/seeds/softball.png")
)

sitwell_enterprises.statuses.create(
  body: "Spotlight on GOB, our Employee of the Month!\n\nGOB comes to Sitwell Enterprises mainly due to his personal vendetta against The Bluth Company.",
  pic: File.new("public/images/seeds/gobsit.png")
)

sitwell_enterprises.statuses.create(
  body: "Singles Island?",
  pic: File.new("public/images/seeds/singles.png")
)

sitwell_enterprises.statuses.create(
  body: "'In that case,' said the Dodo solemnly, rising to its feet, 'I move  that the meeting adjourn, for the immediate adoption of more energetic  remedies&mdash;'\n\n'Speak English!' said the Eaglet. 'I don't know the meaning of half  those long words, and, what's more, I don't believe you do either!' And  the Eaglet bent down its head to hide a smile: some of the other birds  tittered audibly.\n\n'What I was going to say,' said the Dodo in an offended tone, 'was, that  the best thing to get us dry would be a Caucus-race.'\n\n'What IS a Caucus-race?' said Alice; not that she wanted much to know,  but the Dodo had paused as if it thought that SOMEBODY ought to speak,  and no one else seemed inclined to say anything."
)

#Sitwell Enterprises's status on behalf of stan
s2 = Status.new(
  body: "Great GOB in the company softball game, everybody! Win or lose, you're the best!"
)
s2.company = sitwell_enterprises
s2.user = stan
s2.save

#stan's contact info
stan.contacts.create(
  name: "Personal",
  contact_type: 0,
  value: "stan@gmail.com"
)

stan.contacts.create(
  name: "Personal",
  contact_type: 1,
  value: "867-5309"
)

stan.contacts.create(
  name: "Office",
  contact_type: 1,
  value: "1-800-867-5309"
)

stan.contacts.create(
  name: "Company Website",
  contact_type: 2,
  value: "http://sitwellenterprises.com"
)

stan.contacts.create(
  name: "Facebook",
  contact_type: 2,
  value: "https://www.facebook.com/StanSitwell"
)

#The Bluth company's contact info
sitwell_enterprises.contacts.create(
  name: "Company",
  contact_type: 0,
  value: "corporate@sitwellenterprises.com"
)

sitwell_enterprises.contacts.create(
  name: "Sales",
  contact_type: 0,
  value: "sales@sitwellenterprises.com"
)

sitwell_enterprises.contacts.create(
  name: "Office",
  contact_type: 1,
  value: "1-800-867-5309"
)

sitwell_enterprises.contacts.create(
  name: "Company Website",
  contact_type: 2,
  value: "http://sitwellenterprises.com"
)

sitwell_enterprises.contacts.create(
  name: "Facebook",
  contact_type: 2,
  value: "http://www.facebook.com/sitwellenterprises"
)
