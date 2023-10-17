require 'bundler'
require 'pry'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# Demande le prénom à l'utilisateur
puts "Bienvenue dans l'arène ! Quel est ton nom ?"
print "> "
user_name = gets.chomp

# Démarre un jeu avec le nom de l'utilisateur
my_game = Game.new(user_name)
puts "\n"

puts "Notre champion #{user_name} se livrera à un combat jusqu'à la mort!"
puts "\n"

puts "Tu démarres ce combat avec 100 points de vie. Tâche de ne pas mourrir trop vite!"
puts "\n"

puts "Passons au combat!"
puts "\n"

# Boucle tant que le jeu est en cours
while my_game.is_still_ongoing?
  my_game.new_players_in_sight
  my_game.show_players
  my_game.menu
  print "> "
  choice = gets.chomp
  my_game.menu_choice(choice)
  my_game.enemies_attack
  my_game.new_players_in_sight
end

# Affiche le résultat du combat
my_game.end

binding.pry