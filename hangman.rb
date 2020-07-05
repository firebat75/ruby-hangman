require 'json'

class Hangman
    def initialize (lives = 10, guesses = [], right_guesses = [], wrong_guesses = [], progress = [], round = 0, word, original)
        '''
        New game just needs the word and original arguments
        '''
        @lives = lives
        @guesses = guesses
        @right_guesses = right_guesses
        @wrong_guesses = wrong_guesses
        if progress == []
            @progress = ["_"] * word.length
        else
            @progress = progress
        end
        @round = round
        @word = word
        @original = original
    end

    attr_accessor :lives, :guesses, :right_guesses, :wrong_guesses, :progress, :round, :word, :original

    def state
        puts "##########" + "#" * @round.to_s.length
        puts "# Round #{@round} #"
        puts "##########" + "#" * @round.to_s.length
        puts "Lives Left       : ([#{"❤" * @lives}] #{@lives})"
        puts "Progress         : #{@progress.join}"
        puts "Correct guesses  : #{@right_guesses}"
        puts "Incorrect guesses: #{@wrong_guesses}"
    end

    def play_round(guess)
        @round += 1
        @guesses << guess
        if @word.include? guess
            @right_guesses << guess
            while @word.include? guess
                @progress[@word.index(guess)] = guess
                @word[@word.index(guess)] = "."
            end
            return true
        else
            @wrong_guesses << guess
            @lives -= 1
            return false
        end
        
    end

    def check_win()
        return @word == "." * @word.length
    end

    def check_lose()
        return @lives < 1
    end

    def save_as(name)
        Dir.mkdir("saves") unless Dir.exists?("saves")
        filename = "saves/#{name}.json"

        state = {
            "lives" => @lives,
            "guesses" => @guesses,
            "right_guesses" => @right_guesses,
            "wrong_guesses" => @wrong_guesses,
            "progress" => @progress,
            "round" => @round,
            "word" => @word,
            "original" => @original
        }

        File.open(filename, "w") do |f|
            f.write(state.to_json)
        end
    end
end

def open_save(file_path)
    file = File.read(file_path)

    save = JSON.parse(file)

    return Hangman.new(save["lives"], save["guesses"], save["right_guesses"], save["wrong_guesses"], save["progress"], save["round"], save["word"], save["original"])
end


def get_word
    words = File.readlines "5desk.txt"
    x = 0
    while words[x].length < 7 || words[x].length > 14
        x = rand(0..words.length)
    end
    return words[x][0..-3].upcase
end

def play_game(hangman)
    while !hangman.check_win && !hangman.check_lose

        puts hangman.state

        print "Make a selection\n[1] Save Game\n[2] Make a guess\nchoose by entering the option's number: "
        sv = gets.chomp

        while sv != "1" && sv != "2"
            puts "invalid selection"
            print "Make a selection\n[1] Save Game\n[2] Make a guess\nchoose by entering the option's number: "
            sv = gets.chomp
        end

        if sv == "1"
            print "Enter save name: "
            nm = gets.chomp
            hangman.save_as(nm)
            puts "Successfully saved as #{nm}"
        end

        print "Guess a letter: "
        guess = gets.chomp.upcase

        while hangman.guesses.include? guess
            print "You already guessed #{guess}, try again: "
            guess = gets.chomp.upcase
        end

        while !(guess.length == 1 && guess =~ /[A-Z]/)
            print "Invalid input, try again: "
            guess = gets.chomp.upcase
        end

        g = hangman.play_round(guess)

        if g
            puts "Correct! the word contains #{guess}"
        else
            puts "Incorrect! the word does not contain #{guess}"

    end

    end

    puts "The word was #{hangman.original}"

    if hangman.check_win
        puts "YOU WIN!"
    elsif hangman.check_lose
        puts "YOU LOSE!"
    end
    
end