# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


client = Client.create(name: "IBM", business_type: "Tech", email: "ibm@email.com")

standard_user = User.create(full_name: "Standard User", email: "stand_user@email.com",loyalty_tier: "standard", currency: "USD", date_of_birth:(Time.now-18.years)) 
gold_user = User.create(full_name: "Gold User", email: "gold_user@email.com",loyalty_tier: "gold", currency: "USD", date_of_birth:(Time.now-18.years))
platinum_user = User.create(full_name: "Platinum User", email: "platinum_user@email.com",loyalty_tier: "platinum", currency: "USD", date_of_birth:(Time.now-18.years))

standerd_point = PointsLog.create(points_earned: 0, user_id: standard_user.id, valid_until: (Time.now+3.years), issued_by: client.id)
gold_point = PointsLog.create(points_earned: 1000, user_id: gold_user.id, valid_until: (Time.now+3.years), issued_by: client.id)
platinum_point = PointsLog.create(points_earned: 5000, user_id: platinum_user.id, valid_until: (Time.now+3.years), issued_by: client.id)





