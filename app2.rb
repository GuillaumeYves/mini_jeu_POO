require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Demande le prénom à l'utilisateur
puts "Bienvenue dans l'arène ! Quel est ton nom ?"
print "> "
user_name = gets.chomp

# Crée un HumanPlayer avec le prénom de l'utilisateur
user = HumanPlayer.new(user_name)
puts "\n"

# Crée les deux combattants "Josiane" et "José"
player1 = Player.new("Josiane")
player2 = Player.new("José")

# Array contenant les deux player
enemy = [player1, player2]

puts "Notre champion #{user_name} se livrera à un combat jusqu'à la mort !"
puts "\n"

puts "Passons au combat!"
puts "\n"

# Boucle jusqu'à ce que le joueur principal ou les deux joueurs bots soient tués
while user.life_points > 0 && (enemy.any? { |enemy| enemy.life_points > 0 })

# Affiche le menu d'action
  puts "- Quelle action veux-tu effectuer ?"
puts "\n"
  puts "a - Découvrir une arme"
  puts "s - Se soigner"
  puts "Choisir un ennemi à attaquer :"
  enemy.each_with_index do |enemy, index|
    puts "#{index + 1} - Il reste #{enemy.life_points} points de vie a : #{enemy.name}." if enemy.life_points > 0
  end 

# Laissez l'utilisateur choisir une action
  print "> "
  choice = gets.chomp

  # En fonction du choix de l'utilisateur effectuer l'action correspondante
  case choice
  when "a"
    user.search_weapon
  when "s"
    user.search_health_pack
  else
    if choice.to_i.between?(1, enemy.length)
      target = enemy[choice.to_i - 1]
      user.attacks(target) if target.life_points > 0
    else
      puts "Choisissez une des actions proposées."
    end
  end 

# Les joueurs bots attaquent le joueur principal
  enemy.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(user)
    end
  end
end

# Affiche le résultat du combat
if user.life_points <= 0
  puts "Tu as été tué !"
else
  puts "Tu as survécu au combat et ressort victorieux."
end




binding.pry