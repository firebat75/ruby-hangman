puts "hangman.rb loaded"

require 'json'

class Hangman
    def initialize (lives = 10, guesses = [], right_guesses = [], wrong_guesses = [], progress = [], round = 0, word)
        '''
        New game just needs the word argument
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
    end

    attr_accessor :lives, :guesses, :right_guesses, :wrong_guesses, :progress, :round, :word

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
        return word == "." * @word.length
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
            "word" => @word
        }

        File.open(filename, "w") do |f|
            f.write(state.to_json)
        end
    end

end

def open_save(file_path)
    file = File.read(file_path)

    save = JSON.parse(file)

    return Hangman.new(save["lives"], save["guesses"], save["right_guesses"], save["wrong_guesses"], save["progress"], save["round"], save["word"])
end


def get_word
    words = File.readlines "5desk.txt"
    x = 0
    while words[x].length < 7 || words[x].length > 14
        x = rand(0..words.length)
    end
    return words[x][0..-3].upcase
end