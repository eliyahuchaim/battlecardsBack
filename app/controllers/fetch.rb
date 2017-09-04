require 'net/http'
require 'uri'
require 'json'
# require 'pry'

url = URI('https://battlefieldtracker.com/bf1/api/Stats/DetailedStats?platform=2&displayName=itsecgyo')

class Fetch < ApplicationController


  def self.make_fetch(path, platform, bf1_username)
    url = "https://battlefieldtracker.com/bf1/api/#{path}?platform=#{platform}&displayName=#{bf1_username}"

    key = 'TRN-Api-Key'
    token = '8a10249e-4472-4cfd-b802-6c2b1aa5c330'

    url = URI(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request[key] = token
    response = http.request(request)
    JSON.parse(response.body)

  end

    def self.flatten_hash(hash)
    hash.each_with_object({}) do |(k, v), h|
      if v.is_a? Hash
        flatten_hash(v).map do |h_k, h_v|
          h["#{k}.#{h_k}".to_sym] = h_v
        end
      else
        h[k] = v
      end
     end
   end


   def self.create_player_data(path, platform, bf1_username)
     response = self.make_fetch(path, platform, bf1_username)
     cleaned_hash = self.flatten_hash(response)
     cleaned_hash
   end



  # def self.get_player_data(name, path, platform, bf1_username)
  #   response = self.make_fetch(path, platform, bf1_username)
  #   cleaned_hash = self.flatten_hash(self.json)
  #
  #   accuracy_ratio = cleaned_hash[:"result.accuracyRatio"]
  #   kills = cleaned_hash[:"result.basicStats.kills"]
  #   deaths = cleaned_hash[:"result.basicStats.deaths"]
  #   spm = cleaned_hash[:"result.basicStats.spm"]
  #   kpm = cleaned_hash[:"result.basicStats.kpm"]
  #   skill = cleaned_hash[:"result.basicStats.skill"]
  #   wins = cleaned_hash[:"result.basicStats.wins"]
  #   losses = cleaned_hash[:"result.basicStats.losses"]
  #   time_played = cleaned_hash[:"result.basicStats.timePlayed"]
  #   award_score = cleaned_hash[:"result.awardScore"]
  #   avenged_deaths = cleaned_hash[:"result.avengerKills"]
  #   flags_captured = cleaned_hash[:"result.flagsCaptured"]
  #   flags_defended = cleaned_hash[:"result.flagsDefended"]
  #   head_shots = cleaned_hash[:"result.headShots"]
  #   dogtags_taken = cleaned_hash[:"result.dogtagsTaken"]
  #   best_class = cleaned_hash[:"result.favoriteClass"]
  #   highest_kill_streak = cleaned_hash[:"result.highestKillStreak"]
  #   kdr = cleaned_hash[:"result.kdr"]
  #   revives = cleaned_hash[:"result.revives"]
  #   longest_headshot = cleaned_hash[:"result.longestHeadShot"]
  #   heals = cleaned_hash[:"result.heals"]
  #   savior_kills = cleaned_hash[:"result.saviorKills"]
  #   squad_score = cleaned_hash[:"result.squadScore"]
  #   games_played = cleaned_hash[:"result.roundsPlayed"]
  #   rank = cleaned_hash[:"result.basicStats.rank"]
  #   repairs = cleaned_hash[:"result.repairs"]
  #   kill_assists = cleaned_hash[:"result.killAssists"]
  #   suppression_assists = cleaned_hash[:"result.suppressionAssist"]
  #
  #
  #
  #   user = User.create(name: name, username: "elisings", password: "foo", bf1_username: bf1_username, platform: 2, rank: rank, kills: kills, deaths: deaths, spm: spm, kpm: kpm, skill: skill, wins: wins, losses: losses, award_score: award_score, avenged_deaths: avenged_deaths, accuracy_ratio: accuracy_ratio, flags_captured: flags_captured, flags_defended: flags_defended, head_shots: head_shots, dogtags_taken: dogtags_taken, best_class: best_class, highest_kill_streak: highest_kill_streak, kdr: kdr, revives: revives, longest_headshot: longest_headshot, heals: heals, savior_kills: savior_kills, squad_score: squad_score, games_played: games_played, repairs: repairs, kill_assists: kill_assists, suppression_assists: suppression_assists)
  #
  # end


  def self.create_weapon_type_card(path, platform, bf1_username)

    weapons_data = self.make_fetch(path, platform, bf1_username)

    cleaned_hash = self.flatten_hash(weapons_data)
    cleaned_hash = cleaned_hash["result"]

    cleaned_hash.each do |weapon_hash|
      weapon_hash["weapons"].each do |weapon|

      guid = weapon["guid"]
      name = weapon["name"]
      description = weapon["description"]
      category = weapon["category"]
      ammo_cap = weapon["info"]["ammo"]
      ammo_type = weapon["info"]["ammoType"]
      rate_of_fire = weapon["info"]["rateOfFire"]
      range = weapon["info"]["range"]
      number_of_magazines = weapon["info"]["numberOfMagazines"]

      WeaponCardType.create(guid: guid, name: name, description: description, category: category, ammo_cap: ammo_cap, ammo_type: ammo_type, rate_of_fire: rate_of_fire, range: range, number_of_magazines: number_of_magazines)

      end
    end
  end

  # def self.create_player_weapon_card(path, platform, bf1_username)
  #
  #   user_id = User.find_by(bf1_username: bf1_username).id
  #
  #   url = "https://battlefieldtracker.com/bf1/api/Stats/#{path}?platform=#{platform}&displayName=#{bf1_username}"
  #
  #   response = self.make_fetch(path, platform, bf1_username)
  #   cleaned_hash = self.flatten_hash(response)
  #   cleaned_hash = cleaned_hash["result"]
  #
  #   cleaned_hash.each do |weapon_hash|
  #     weapon_hash["weapons"].each do |weapon|
  #       weapon_id = WeaponCardType.find_by(guid: weapon["guid"]).id
  #       kills = weapon["stats"]["values"]["kills"]
  #       headshots = weapon["stats"]["values"]["headshots"]
  #       accuracy = weapon["stats"]["values"]["accuracy"]
  #       time_played = weapon["stats"]["values"]["seconds"]
  #       hits = weapon["stats"]["values"]["hits"]
  #       shots = weapon["stats"]["values"]["shots"]
  #       unlocked = weapon["progression"]["unlocked"]
  #
  #       WeaponCard.create(user_id: user_id, weapon_card_type_id: weapon_id, kills: kills, headshots: headshots, accuracy: accuracy, time_played: time_played, hits: hits, shots: shots, unlocked: unlocked)
  #     end
  #   end
  # end

  def self.create_vehicle_type_cards(path, platform, bf1_username)

    response = self.make_fetch(path, platform, bf1_username)
    cleaned_hash = self.flatten_hash(response)

    cleaned_hash["result"].each do |main_scope|
      main_scope["vehicles"].each do |vehicle|
        name = vehicle["name"]
        description = vehicle["description"]

        VehicleCardType.create(name: name, description: description)
      end
    end
  end

  # def self.create_player_vehicle_cards(path, platform, bf1_username)
  #   response = self.make_fetch(path, platform, bf1_username)
  #   cleaned_hash = self.flatten_hash(response)
  #   user_id = User.find_by(bf1_username: bf1_username).id
  #
  #     cleaned_hash["result"].each do |main_scope|
  #       main_scope["vehicles"].each do |vehicle|
  #
  #         name = vehicle["name"]
  #         vehicle_id = VehicleCardType.find_by(name: name).id
  #         kills = vehicle["stats"]["values"]["kills"].round
  #         time_played = vehicle["stats"]["values"]["seconds"]
  #         amount_of_vehicles_destroyed = vehicle["stats"]["values"]["destroyed"]
  #
  #         VehicleCard.create(user_id: user_id, vehicle_card_type_id: vehicle_id, kills: kills, time_played: time_played, amount_of_vehicles_destroyed: amount_of_vehicles_destroyed)
  #     end
  #   end
  # end

  def self.create_class_card_types

    classesHash = { classes: {
      assaultClass: {
        name: "Assault",
        image: "http://cdn.mos.cms.futurecdn.net/KejvJjiqoMjmoJAuzLhvzh.jpg"

      },
      MedicClass: {
        name: "Medic",
        image: "http://eaassets-a.akamaihd.net/battlelog/prod/61d099d23fe104fe673091d470c96970/en_US/blog/en/files/2017/03/rendition2.jpg?v=1489423771.19"
      },
      ReconClass: {
        name: "Scout",
        image: "http://cdn.mos.cms.futurecdn.net/tFSVBByF54kCRfFw5Ghq5T-480-80.jpg"
      },
      SupportClass: {
        name: "Support",
        image: "https://media-www-battlefieldwebcore.spark.ea.com/content/battlefield-portal/en_US/games/battlefield-1/they-shall-not-pass/_jcr_content/par/section_2/columns/column/content/editorial_2/image/xsmall.img.jpg"
      },
      PilotClass: {
        name: "Pilot",
        image: "https://battlefieldforum.net/index.php?attachments/cnblyrowaaafpd6-jpg.1017/"
      },
      CavarlyClass: {
        name: "Cavalry",
        image: "http://i.playground.ru/i/26/93/52/00/blog/content/g02gedhb.jpg"
      },
      TankClass: {
        name: "Tanker",
        image: "https://ip2.i.lithium.com/789a935ecce413b866811e082678ce43bf0347a0/68747470733a2f2f6d656469612d7777772d626174746c656669656c64776562636f72652e737061726b2e65612e636f6d2f636f6e74656e742f626174746c656669656c642d706f7274616c2f656e5f55532f67616d65732f626174746c656669656c642d312f746865792d7368616c6c2d6e6f742d706173732f5f6a63725f636f6e74656e742f7061722f73656374696f6e5f322f636f6c756d6e732f636f6c756d6e2f636f6e74656e742f656469746f7269616c5f302f696d6167652f6c617267652e696d672e6a7067"
      }}
    }

      classesHash[:classes].each do |clas, details|
        ClassType.create(name: details[:"name"], image: details[:"image"])
      end

  end


  # def self.create_player_class_card(path, platform, bf1_username)
  #   response = self.make_fetch(path, platform, bf1_username)
  #   cleaned_hash = self.flatten_hash(response)
  #   user_id = User.find_by(bf1_username: bf1_username).id
  #
  #
  #     cleaned_hash[:"result.kitStats"].each do |kit|
  #       classType_id = ClassType.find_by(name: kit["name"]).id
  #       kills = kit["kills"]
  #       score = kit["score"]
  #       time_played = kit["secondsAs"]
  #
  #       ClassCard.create(user_id: user_id, class_type_id: classType_id, kills: kills, score: score, time_played: time_played)
  #     end
  # end



end # end of class
