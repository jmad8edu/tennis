# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
SkillLevel.create!(skill_level: "Beginner",
				   ntrp_rating: "1.5")
SkillLevel.create!(skill_level: "Beginner",
				   ntrp_rating: "2.0")
SkillLevel.create!(skill_level: "Beginner",
				   ntrp_rating: "2.5")
SkillLevel.create!(skill_level: "Intermediate",
				   ntrp_rating: "3.0")
SkillLevel.create!(skill_level: "Intermediate",
				   ntrp_rating: "3.5")
SkillLevel.create!(skill_level: "Intermediate",
				   ntrp_rating: "4.0")
SkillLevel.create!(skill_level: "Advanced",
				   ntrp_rating: "4.5")
SkillLevel.create!(skill_level: "Advanced",
				   ntrp_rating: "5.0")
SkillLevel.create!(skill_level: "Advanced",
				   ntrp_rating: "5.5")
SkillLevel.create!(skill_level: "Professional",
				   ntrp_rating: "6.0")
SkillLevel.create!(skill_level: "Professional",
				   ntrp_rating: "6.5")
SkillLevel.create!(skill_level: "Professional",
				   ntrp_rating: "7.0")
password = "password"
User.create!(first_name:              "Justin",
             last_name:               "Madsen",
             email:                   "justinmadsen4@gmail.com",
             password:                password,
             password_confirmation:   password,
             right_left_handed:       "right",
             skill_level_id:          5)
switch = false;
99.times do |n|
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
