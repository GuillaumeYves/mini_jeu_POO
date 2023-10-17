require_relative 'player'

class Game
  attr_accessor :human_player, :enemies, :players_left, :enemies_in_sight

  def initialize(player_name)
    @human_player = HumanPlayer.new(player_name)
    @enemies = []
    4.times do |i|
      @enemies << Player.new("Joueur #{i + 1}")
    end
    @players_left = 10
    @enemies_in_sight = @enemies
  end

  def new_players_in_sight
    if @enemies_in_sight.length >= @players_left
      puts "Tous les adversaires sont déjà en vue."
      return
    end

    dice_roll = rand(1..6)

    case dice_roll
    when 1
      puts "Aucun nouvel adversaire en approche."
    when 2..4
      new_enemy = Player.new("Joueur #{rand(10000)}")
      @enemies_in_sight << new_enemy
      puts "Un nouvel adversaire arrive en vue : #{new_enemy.name}."
    when 5..6
      2.times do
        new_enemy = Player.new("Joueur #{rand(10000)}")
        @enemies_in_sight << new_enemy
      end
      puts "Deux nouveaux adversaires arrivent en vue."
    end
  end


  def kill_player(player)
    @enemies.delete(player)
  end

  def is_still_ongoing?
  remaining_enemies = @enemies.count { |enemy| enemy.life_points > 0 }
  return @human_player.life_points.positive? && remaining_enemies > 0
end

  def show_players
  @human_player.show_state
  remaining_enemies = @enemies.count { |enemy| enemy.life_points > 0 }
  puts "Ennemis restant: #{remaining_enemies}"
  puts "\n"
  end

  def menu
   puts "- Quelle action veux-tu effectuer ?"
   puts "\n"
   puts "=> (a) - Découvrir une arme"
   puts "=> (s) - Se soigner"
   puts "=> (0 à 10) Ou choisir un ennemi à attaquer :"
   puts "\n"
    @enemies.each_with_index do |enemy, index|
      if enemy.life_points > 0
        puts "#{index} - Il reste #{enemy.life_points} points de vie à : #{enemy.name}."
      end
    end
  end

  def menu_choice(choice)
  loop do
   case choice
    when "a"
      @human_player.search_weapon
    when "s"
      @human_player.search_health_pack
    when ""
      puts "Tu as choisis de ne rien faire."
      puts "\n"
    else
      index = choice.to_i
      if (0..10).include?(index) && @enemies[index] && @enemies[index].life_points > 0
        @human_player.attacks(@enemies[index])
       if @enemies[index].life_points <= 0
          kill_player(@enemies[index])
       end
      else
        puts "Pour attaquer, il te faut une cible valide! Choisis parmis les cibles ci_dessus."
        puts "\n"
        print ">"
      choice = gets.chomp
        next
       end
     end 
     break
   end 
  end

  def enemies_attack
    @enemies.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(@human_player)
      end
    end
  end

  def end
    if @human_player.life_points > 0
       puts "\n"
      puts "Tu as survécu au combat et ressort victorieux !"
    else
      puts "\n"
      puts "Tu as été tué !"
      puts "On se souviendra de tes actes de bravoure."
    end
  end
end