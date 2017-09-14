class WeaponCard < ApplicationRecord

  # validates weapon_card_type_id: uniqueness: true

  belongs_to :user
  belongs_to :character, optional: true
  belongs_to :weapon_card_type


  def self.create_user_cards(user)

    response = Fetch.make_fetch("Progression/GetWeapons", user.platform, user.bf1_username)
    cleaned_hash = Fetch.flatten_hash(response)
    cleaned_hash = cleaned_hash["result"]
    user_id = user.id

    cleaned_hash.each do |weapon_hash|
      weapon_hash["weapons"].each do |weapon|
        weapon_id = WeaponCardType.find_by(guid: weapon["guid"]).id
        kills = weapon["stats"]["values"]["kills"]
        headshots = weapon["stats"]["values"]["headshots"]
        accuracy = weapon["stats"]["values"]["accuracy"]
        time_played = weapon["stats"]["values"]["seconds"]
        hits = weapon["stats"]["values"]["hits"]
        shots = weapon["stats"]["values"]["shots"]
        unlocked = weapon["progression"]["unlocked"]

        WeaponCard.create(user_id: user_id, weapon_card_type_id: weapon_id, kills: kills, headshots: headshots, accuracy: accuracy, time_played: time_played, hits: hits, shots: shots, unlocked: unlocked)
      end
    end
  end


  def self.update_weapon(user)

    response = Fetch.make_fetch("Progression/GetWeapons", user.platform, user.bf1_username)
    cleaned_hash = Fetch.flatten_hash(response)
    cleaned_hash = cleaned_hash["result"]
    user_id = user.id

    cleaned_hash.each do |weapon_hash|
      weapon_hash["weapons"].each do |weapon|
        weapon_id = WeaponCardType.find_by(guid: weapon["guid"]).id
        kills = weapon["stats"]["values"]["kills"]
        headshots = weapon["stats"]["values"]["headshots"]
        accuracy = weapon["stats"]["values"]["accuracy"]
        time_played = weapon["stats"]["values"]["seconds"]
        hits = weapon["stats"]["values"]["hits"]
        shots = weapon["stats"]["values"]["shots"]
        unlocked = weapon["progression"]["unlocked"]

        @foundWeapon = user.weapon_cards.find_by(weapon_card_type_id: weapon_id)

        @foundWeapon.update(kills: kills, headshots: headshots, accuracy: accuracy, time_played: time_played, hits: hits, shots: shots, unlocked: unlocked)
      end
    end
  end







end
