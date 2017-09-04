

url = URI('https://battlefieldtracker.com/bf1/api/Stats/DetailedStats?platform=2&displayName=itsecgyo')
key = 'TRN-Api-Key'
token = '8a10249e-4472-4cfd-b802-6c2b1aa5c330'



# Fetch.make_fetch("Stats/DetailedStats", 2, "itsecgyo")

Fetch.create_weapon_type_card("Progression/GetWeapons", 2, "itsecgyo")
Fetch.create_vehicle_type_cards("Progression/GetVehicles", 2, "itsecgyo")
Fetch.create_class_card_types

# Fetch.get_player_data("eli", "Stats/DetailedStats", 2, "itsecgyo")
# Fetch.get_player_data("tanis", "Stats/DetailedStats", 2, "tanismike")
#
# Fetch.create_player_weapon_card("Progression/GetWeapons", 2, "itsecgyo")
# Fetch.create_player_weapon_card("Progression/GetWeapons", 2, "tanismike")
#
# Fetch.create_player_vehicle_cards("Progression/GetVehicles", 2, "itsecgyo")
# Fetch.create_player_vehicle_cards("Progression/GetVehicles", 2, "tanismike")
#
# Fetch.create_player_class_card("Stats/DetailedStats", 2, "itsecgyo")
# Fetch.create_player_class_card("Stats/DetailedStats", 2, "tanismike")


user = User.first

character = Character.create(user_id: user.id, name: "first character", avatar: "hi")

user.weapon_cards[0].update(character_id: character.id)
user.weapon_cards[1].update(character_id: character.id)
user.weapon_cards[2].update(character_id: character.id)

user.vehicle_cards[0].update(character_id: character.id)
user.class_cards[0].update(character_id: character.id)
