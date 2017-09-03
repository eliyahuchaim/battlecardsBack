ten = 10

def countdown(num)
  puts "#{num} seconds left!"
  num -=1
  if num == 0
    exit
  else
    countdown(num)
  end
end




nested_hash = {list: {
    people: {
      person1: {
        name: "Mike"
      },
      person2: {
        name: "Bob"
      }
    },
    pets: {
      pet1: {
        type: "Dog",
        name: "chilly"
      }
    }
  }
}

def flatten_hash(hash)
  hash.each_with_object({}) do |(k,v), cleaned_hash|
    puts cleaned_hash
    if v.class == Hash
      flatten_hash(v).map do |hash_key, hash_value|
        puts ("#{hash_key}, #{hash_value}")
        cleaned_hash["#{k}.#{hash_key}".to_sym] = hash_value
      end
    else
      cleaned_hash[k] = v
    end
  end
end




def self.check_player_data(hash)
  byebug
  if json === "accuracyRatio" || json == "avengerKills"
      puts "true"
      return true
    else
      puts "false"
      return false
    end
end

def self.composure(data)

  master_hash = []
  current = data
  to_check = []

  while !current.empty? do
    if self.check_player_data(current)
        master_hash.push([current].values)
    end
      if to_check.class == Array
          byebug
          to_check = to_check[0]
            if !to_check[to_check.keys[0]].class == Hash && !to_check[to_check.keys[0]].class == Array
              current = {}
              current[to_check.keys[0]] = to_check[to_check.keys[0]]
              to_check.delete(to_check.keys[0])
            end
      else
        temp_arr = []
        to_check.each do |k,v|
             if to_check[k].class != Hash
                temp_arr.push(k,v)
              else
                temp_arr.push(v)
            end
        end
        byebug
        to_check = temp_arr
        current = {}
        current[to_check.keys[0]] = to_check[to_check.keys[0]]
        to_check.delete(to_check.keys[0])
      end
    end
  return master_hash
end


Fetch.main_player_data(url, key, token)
