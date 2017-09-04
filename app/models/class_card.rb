class ClassCard  < ApplicationRecord
  belongs_to :user
  belongs_to :class_type


  def self.create_class_cards(user)
    response = Fetch.make_fetch("Stats/DetailedStats", user.platform, user.bf1_username)
    cleaned_hash = Fetch.flatten_hash(response)
    user_id = user.id

    cleaned_hash[:"result.kitStats"].each do |kit|
      classType_id = ClassType.find_by(name: kit["name"]).id
      kills = kit["kills"]
      score = kit["score"]
      time_played = kit["secondsAs"]

      ClassCard.create(user_id: user_id, class_type_id: classType_id, kills: kills, score: score, time_played: time_played)
    end
  end


end
