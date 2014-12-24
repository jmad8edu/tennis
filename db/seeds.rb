print "Creating SkillLevel\t\t\t(1/12)\r"
SkillLevel.create!(skill_level: "Beginner",
				   ntrp_rating: "1.5")
print "Creating SkillLevel\t\t\t(2/12)\r"
SkillLevel.create!(skill_level: "Beginner",
				   ntrp_rating: "2.0")
print "Creating SkillLevel\t\t\t(3/12)\r"
SkillLevel.create!(skill_level: "Beginner",
				   ntrp_rating: "2.5")
print "Creating SkillLevel\t\t\t(4/12)\r"
SkillLevel.create!(skill_level: "Intermediate",
				   ntrp_rating: "3.0")
print "Creating SkillLevel\t\t\t(5/12)\r"
SkillLevel.create!(skill_level: "Intermediate",
				   ntrp_rating: "3.5")
print "Creating SkillLevel\t\t\t(6/12)\r"
SkillLevel.create!(skill_level: "Intermediate",
				   ntrp_rating: "4.0")
print "Creating SkillLevel\t\t\t(7/12)\r"
SkillLevel.create!(skill_level: "Advanced",
				   ntrp_rating: "4.5")
print "Creating SkillLevel\t\t\t(8/12)\r"
SkillLevel.create!(skill_level: "Advanced",
				   ntrp_rating: "5.0")
print "Creating SkillLevel\t\t\t(9/12)\r"
SkillLevel.create!(skill_level: "Advanced",
				   ntrp_rating: "5.5")
print "Creating SkillLevel\t\t\t(10/12)\r"
SkillLevel.create!(skill_level: "Professional",
				   ntrp_rating: "6.0")
print "Creating SkillLevel\t\t\t(11/12)\r"
SkillLevel.create!(skill_level: "Professional",
				   ntrp_rating: "6.5")
print "Creating SkillLevel\t\t\t(12/12)\n"
SkillLevel.create!(skill_level: "Professional",
				   ntrp_rating: "7.0")

NotificationType.create!(description: "Invitation Received")
NotificationType.create!(description: "Invitation Accepted")
NotificationType.create!(description: "Invitation Declined")
NotificationType.create!(description: "Message Sent")
NotificationType.create!(description: "Tennis Match Details Updated")

password = "password"
print "Creating Players\t\t\t(1/15)\r"
User.create!(first_name:              "Justin",
             last_name:               "Madsen",
             email:                   "justinmadsen4@gmail.com",
             password:                "password",
             password_confirmation:   "password",
             right_left_handed:       "right",
             skill_level_id:          5,
             address_attributes:{
              address_1: "2261 S. Hillrise Circle",
              address_2: nil,
              city: "St. George",
              state: "Utah",
              postal_code: "84790",
              country: "USA"
            })
switch = false;
zip1 = "84790"
zip2 = "12345"
zip3 = "67890"
14.times do |n|
  print "Creating Players\t\t\t(#{n+2}/15)\r"
  first_name  = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = "example-#{n+1}@railstutorial.org"
  hand = false ? "right" : "left"
  switch = !switch
  skill_level_id = (n % 12) + 1
  User.create!(first_name:              first_name,
  			       last_name:               last_name,
               email:                   email,
               password:                password,
               password_confirmation:   password,
               right_left_handed:       hand,
               skill_level_id:          skill_level_id,
               address_attributes:{
                address_1: Faker::Address.street_address,
                address_2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: "Utah",
                postal_code: (n % 3) == 0 ? zip1 : (n % 3) == 1 ? zip2 : zip3,
                country: "USA"
              })
end
print "Creating Players\t\t\t(15/15)\n"


print "Creating Matches\t\t\t(1/6)\r"
m = Match.create!(inviter_id:       2,
                  invitee_id:       1,
                  date:             "12-25-2014",
                  time:             "1:30 PM",
                  address_attributes:{
                    address_1:      Faker::Address.street_address,
                    address_2:      Faker::Address.secondary_address,
                    city:           Faker::Address.city,
                    state:          "Utah",
                    postal_code:    zip1,
                    country:        "USA"
                  })

Message.create!(sender_id:       2,
                message:         "Come on man, just play!",
                messagable:      m)
Message.create!(sender_id:       1,
                message:         "Alright, I'll play, but I can't play that day.",
                messagable:      m)

print "Creating Matches\t\t\t(2/6)\r"
Match.create!(inviter_id:       3,
              invitee_id:       1,
              date:             "12-25-2014",
              time:             "1:30 PM",
              address_attributes:{
                address_1: Faker::Address.street_address,
                address_2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: "Utah",
                postal_code: zip2,
                country: "USA"
              })
print "Creating Matches\t\t\t(3/6)\r"
Match.create!(inviter_id:       4,
              invitee_id:       1,
              date:             "12-25-2014",
              time:             "1:30 PM",
              address_attributes:{
                address_1: Faker::Address.street_address,
                address_2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: "Utah",
                postal_code: zip3,
                country: "USA"
              })
print "Creating Matches\t\t\t(4/6)\r"
Match.create!(inviter_id:       5,
              invitee_id:       1,
              date:             "12-25-2014",
              time:             "1:30 PM",
              address_attributes:{
                address_1: Faker::Address.street_address,
                address_2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: "Utah",
                postal_code: zip1,
                country: "USA"
              })
print "Creating Matches\t\t\t(5/6)\r"
Match.create!(inviter_id:       6,
              invitee_id:       1,
              date:             "12-25-2014",
              time:             "1:30 PM",
              address_attributes:{
                address_1: Faker::Address.street_address,
                address_2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                state: "Utah",
                postal_code: zip2,
                country: "USA"
              })
print "Creating Matches\t\t\t(6/6)\n"
