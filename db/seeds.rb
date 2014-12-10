# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
NotificationType.create!(description: "Message Sent")

password = "password"
print "Creating Players\t\t\t(1/25)\r"
User.create!(first_name:              "Justin",
             last_name:               "Madsen",
             email:                   "justinmadsen4@gmail.com",
             password:                password,
             password_confirmation:   password,
             right_left_handed:       "right",
             skill_level_id:          5)
switch = false;
24.times do |n|
  print "Creating Players\t\t\t(#{n+2}/25)\r"
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
               skill_level_id:          skill_level_id)
end
print "Creating Players\t\t\t(25/25)\n"


print "Creating Matches\t\t\t(1/6)\r"
Match.create!(inviter_id:       2,
              invitee_id:       1,
              scheduled_date:   "2015-1-08 09:30:00.000000",
              location:         "Wherever")
print "Creating Matches\t\t\t(2/6)\r"
Match.create!(inviter_id:       3,
              invitee_id:       1,
              scheduled_date:   "2015-1-08 09:30:00.000000",
              location:         "Wherever")
print "Creating Matches\t\t\t(3/6)\r"
Match.create!(inviter_id:       4,
              invitee_id:       1,
              scheduled_date:   "2015-1-08 09:30:00.000000",
              location:         "Wherever")
print "Creating Matches\t\t\t(4/6)\r"
Match.create!(inviter_id:       5,
              invitee_id:       1,
              scheduled_date:   "2015-1-08 09:30:00.000000",
              location:         "Wherever")
print "Creating Matches\t\t\t(5/6)\r"
Match.create!(inviter_id:       6,
              invitee_id:       1,
              scheduled_date:   "2015-1-08 09:30:00.000000",
              location:         "Wherever")
print "Creating Matches\t\t\t(6/6)\n"
