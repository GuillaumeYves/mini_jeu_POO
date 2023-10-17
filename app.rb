require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Introduction
puts "Bienvenue dans l'arène!"
puts "\n"

# Crée les deux combattants "Josiane" et "José"
player1 = Player.new("Josiane")
player2 = Player.new("José")

# Présentation des joueurs et de leurs état
puts "À ma droite: #{player1.name} !"
puts "À ma gauche: #{player2.name} !"
puts "\n"

puts "Voici l'état de chaque joueurs :"
puts "\n"
puts player1.show_state
puts player2.show_state

# Lancement du combat
puts "Passons au combat!"
puts "\n"

# Boucle jusqu'à ce qu'un des joueurs soit tué
while player1.life_points > 0 && player2.life_points > 0
  player1.attacks(player2)
  break if player2.life_points <= 0

  player2.attacks(player1)
  break if player1.life_points <= 0
end

# Victoire d'un joueur
if player1.life_points <= 0
  puts "#{player2.name} a gagné !"
elsif player2.life_points <= 0
  puts "#{player1.name} a gagné !"
end



binding.pry