class PlayerInfo
    def player_type()
        play = true
        while play == true
            puts "Please enter the player combination. 1 Being player 1 vs computer or 2 beig player 1 vs player 2."
            play_type = gets.to_i
            if play_type == 1
                puts "Player 1 vs Computer!"
                puts "Player1 has to guess the colour combination randomly choosen by te computer."
                puts "Player can use _ to help with the code breaking."
                play = false
                return play_type
                #random combination choice to return.
            elsif play_type == 2
                puts "Player 1 vs Player 2!"
                puts "Player1 has to guess the colour combination choosen by player 2."
                play = false
                return play_type
                #player 2 combination is chosen and returned.
            else
                puts "Invalid player combination was chosen."
                options_displayed()
                #Put the options up again
            end
        end
    end
    def options_displayed()
        puts "Player/s can enter 1 to play againsts the computer. The second option is a two player game by pressing 2."
    end
    def random_selection() # computer colour choices
        choices = []
        while choices.length < 4
            choice = rand(4)
            if choice == 0
                choice = "blue"
                choices.append(choice)
            elsif choice == 1
                choice = "red"
                choices.append(choice)
            elsif choice == 2
                choice = "green"
                choices.append(choice)
            elsif choice == 3
                choice = "yellow"
                choices.append(choice)
            end
        end
        return choices
    end
    def colour_defination() # colours chosen by player 1 or player 2
        choices = []
        while choices.length < 4
            choice = gets.downcase.chomp
            if choice == "blue"
                choices.append(choice)
            elsif choice == "red"
                choices.append(choice)
            elsif choice == "green"
                choices.append(choice)
            elsif choice == "yellow"
                choices.append(choice)
            elsif choice == "_"
                choices.append(choice)
            else
                puts "Invalid colour chosen. Valid colour choices are blue, red, green and yellow."
            end
        end
        return choices
    end
end

class GamePlay
    @@guesses = 16
    def initialize(player_1choice,player_2choice)
        @player_1choice = player_1choice
        @player_2choice = player_2choice
    end
    def matching_colours()
        count, match_no = 0, 0
        while count < 4
            if @player_1choice[count] == @player_2choice[count]
                match_no += 1
                count += 1
            else
                count += 1
            end
        end
        return match_no
    end
    def feedback()
        match_no = matching_colours()
        guess = @player_1choice
        puts "Player 1 got #{match_no} colours correct in their #{guess} guess. Player one has #{guesses_left()} guesses left!"
    end
    def guesses_left()
        @@guesses -= 1
        return @@guesses
    end
    def game_won()
        match = matching_colours()
        guess_to_win = 16 - @@guesses
        winner = false
        if match == 4
            winner = true
            puts "Player 1 won the game as he/she has guessed the colours correctly. It took the player #{guess_to_win} guesses to get the right combination."
        elsif @@guesses == 0
            winner = true
            puts "Player 2 won the game as player one was unable to guess the colours."
        end
        return winner
    end
end

class Game
    def plays()
        game_type = PlayerInfo.new().player_type()
        if game_type == 1
            puts "Player 1 colour guesses"
            player_1 = PlayerInfo.new().colour_defination()
            player_2 = PlayerInfo.new().random_selection()
        elsif game_type == 2
            puts "Player 2 colour chosen. These colours will be guessed by player 2."
            player_2 = PlayerInfo.new().colour_defination()
            puts "Player 1 colour guesses"
            player_1 = PlayerInfo.new().colour_defination()
        end
        return player_1, player_2
    end
    def game_conditions()
        playing = true
        plays_ = plays()
        p player_choice = GamePlay.new(plays_[0], plays_[1])
        while playing == true
            matching = player_choice.matching_colours()
            feed_back = player_choice.feedback()
            gamewon = player_choice.game_won()
            if gamewon == true or matching >= 4
                playing = false
            end
            if playing == true
                puts "Player 1 colour guesses"
                player_1 = PlayerInfo.new().colour_defination()
                player_choice = GamePlay.new(player_1, plays_[1])
            end
        end
    end
end

################# initiating the game ##########################
Game.new().game_conditions()
################ The end! ######################################