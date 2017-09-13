class User < ApplicationRecord

  # validates :username, uniqueness: true
  # validates :bf1_username, uniqueness: true

  has_secure_password
  has_many :weapon_cards
  has_many :characters
  has_many :vehicle_cards
  has_many :class_cards


  def self.create_user(user_params, platform, cleaned_hash)

    name = user_params[:name]
    password = user_params[:password]
    username = user_params[:username]
    bf1_username = user_params[:bf1_username]
    platform = platform

    accuracy_ratio = cleaned_hash[:"result.accuracyRatio"]
    kills = cleaned_hash[:"result.basicStats.kills"]
    deaths = cleaned_hash[:"result.basicStats.deaths"]
    spm = cleaned_hash[:"result.basicStats.spm"]
    kpm = cleaned_hash[:"result.basicStats.kpm"]
    skill = cleaned_hash[:"result.basicStats.skill"]
    wins = cleaned_hash[:"result.basicStats.wins"]
    losses = cleaned_hash[:"result.basicStats.losses"]
    time_played = cleaned_hash[:"result.basicStats.timePlayed"]
    award_score = cleaned_hash[:"result.awardScore"]
    avenged_deaths = cleaned_hash[:"result.avengerKills"]
    flags_captured = cleaned_hash[:"result.flagsCaptured"]
    flags_defended = cleaned_hash[:"result.flagsDefended"]
    head_shots = cleaned_hash[:"result.headShots"]
    dogtags_taken = cleaned_hash[:"result.dogtagsTaken"]
    best_class = cleaned_hash[:"result.favoriteClass"]
    highest_kill_streak = cleaned_hash[:"result.highestKillStreak"]
    kdr = cleaned_hash[:"result.kdr"]
    revives = cleaned_hash[:"result.revives"]
    longest_headshot = cleaned_hash[:"result.longestHeadShot"]
    heals = cleaned_hash[:"result.heals"]
    savior_kills = cleaned_hash[:"result.saviorKills"]
    squad_score = cleaned_hash[:"result.squadScore"]
    games_played = cleaned_hash[:"result.roundsPlayed"]
    rank = cleaned_hash[:"result.basicStats.rank"]
    repairs = cleaned_hash[:"result.repairs"]
    kill_assists = cleaned_hash[:"result.killAssists"]
    suppression_assists = cleaned_hash[:"result.suppressionAssist"]



    user = User.create(name: name, username: username, password: password, bf1_username: bf1_username, platform: platform, rank: rank, kills: kills, deaths: deaths, spm: spm, kpm: kpm, skill: skill, wins: wins, losses: losses, award_score: award_score, avenged_deaths: avenged_deaths, accuracy_ratio: accuracy_ratio, flags_captured: flags_captured, flags_defended: flags_defended, head_shots: head_shots, dogtags_taken: dogtags_taken, best_class: best_class, highest_kill_streak: highest_kill_streak, kdr: kdr, revives: revives, longest_headshot: longest_headshot, heals: heals, savior_kills: savior_kills, squad_score: squad_score, games_played: games_played, repairs: repairs, kill_assists: kill_assists, suppression_assists: suppression_assists)

    if user
      WeaponCard.create_user_cards(user)
      VehicleCard.create_vehicle_cards(user)
      ClassCard.create_class_cards(user)
    end
    user
  end


  def self.characters_info(user)

    characters_hash = {characters: []}
    i = 0

    user.characters.each do |character|
      temp_hash = {
        "info" => [character],
        "weapons" => [],
        "vehicle_card" => [],
        "class_card" => []
      }
      character.weapon_cards.each do |weapon|
        i+=1
        temp_hash["weapons"].push({"card#{i}" => {"data" => weapon, "info" => WeaponCardType.find(weapon.weapon_card_type.id)}})
      end
      temp_hash["vehicle_card"].push({"data" => character.vehicle_card, "info" => VehicleCardType.find(character.vehicle_card.vehicle_card_type_id)})
      temp_hash["class_card"].push({"data" => character.class_card, "info" => ClassType.find(character.class_card.class_type_id)})
      characters_hash[:"characters"].push(temp_hash)
      i = 0
    end
    characters_hash
  end


  def self.get_all_usernames
     sql = 'SELECT bf1_username, id FROM Users'
     @connection = ActiveRecord::Base.connection
     result = @connection.exec_query(sql)
     result.rows.map {|el| {username: el[0], id: el[1]}}
  end







end
