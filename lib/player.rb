class Player
  attr_accessor :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 10
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie."
  end

  def gets_damage(damage)
    @life_points -= damage
  end

 def compute_damage
    rand(1..6)
 end

def attacks(player2)
    damage = compute_damage
    puts "#{@name} attaque #{player2.name}."
    player2.gets_damage(damage)
    puts "Il lui inflige #{damage} points de dommages."
    puts "\n"
    puts player2.show_state if player2.life_points > 0
    puts "\n"
    puts "Le joueur #{player2.name} a été tué !" if player2.life_points <= 0
  end

end


# Nouvelle Class
class HumanPlayer < Player
  attr_accessor :weapon_level

def initialize(name)
    super(name) # Classe Parent
    @life_points = 100 # Initialise les points de vie du joueur humain à 100
    @weapon_level = 1 # Initialise le niveau de l'arme à 1
end

def show_state
    "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}."
end

def compute_damage
  rand(1..6) * @weapon_level
end

# Recherche d'un arme
def search_weapon
  new_weapon_level = rand(1..6)
  puts "Tu as trouvé une arme de niveau #{new_weapon_level}."
  if new_weapon_level > @weapon_level
    puts "Elle est meilleure que ton arme actuelle : tu la prends."
    @weapon_level = new_weapon_level
  else
    puts "Elle n'est pas meilleure que ton arme actuelle : tu ne la prends pas."
  end
end

# Recherche de pack de points de vie
def search_health_pack

  dice = rand(1..6)

  if dice == 1
  puts  "Tu n'as rien trouvé."
  elsif dice >= 2 && dice <= 5
    @life_points = [@life_points + 50, 100].min
  puts "Tu as trouvé un pack de +50 points de vie !"
  else
    @life_points = [@life_points + 80, 100].min
  puts "Tu as trouvé un pack de +80 points de vie !"
  end
puts "\n"
puts "Tu as désormais #{@life_points} points de vie."
puts "\n"
end

end