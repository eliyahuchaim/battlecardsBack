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

end # end of class
