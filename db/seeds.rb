# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Creature.destroy_all

BASE_API = "http://dnd5eapi.co/api/monsters/"

COUNT = JSON.parse(RestClient.get(BASE_API))["count"]

COUNT.times do |i|
	data = JSON.parse(RestClient.get(BASE_API + (i + 1).to_s))

	params = ActionController::Parameters.new({
		name: data["name"],
		creature_type: data["type"],
		size: data["size"],
		str: data["strength"] || 0,
		dex: data["dexterity"] || 0,
		con: data["constitution"] || 0,
		int: data["intelligence"] || 0,
		wis: data["wisdom"] || 0,
		cha: data["charisma"] || 0,
		challenge_rating: data["challenge_rating"],
		speed: data["speed"],
		armor_class: data["armor_class"],
		hp: data["hit_points"],
		alignment: data["alignment"]
	}).permit!

	Creature.create(params)

	puts "#{i + 1}. Created #{params[:name]}"
end
