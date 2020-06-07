puts "HANGMAN START"

words = File.readlines "5desk.txt"

words.map! { |word|
    word = word.upcase
    word[0..-3]
}

x = 0
while words[x].length < 5 || words[x].length > 12
    x = rand(0..words.length)
end

puts words[x]
word = words[x].upcase

lives = 10
guesses = []
correct_g = []
incorrect_g = []
correct = "_" * word.length
round = 1

while lives > 0 && word != "." * word.length
    puts "##########" + "#" * round.to_s.length
    puts "# Round #{round} #"
    puts "##########" + "#" * round.to_s.length
    puts "Lives Left: ([#{"❤"*lives}] #{lives})"
    puts "Progress: #{correct}"
    puts "Correct guesses  : #{correct_g}"
    puts "Incorrect guesses: #{incorrect_g}"
    print "Guess a letter: "
    guess = gets.chomp.upcase

    while guesses.include? guess
        print "You already guessed #{guess}, try again: "
        guess = gets.chomp.upcase
    end

    while guess.length > 1 || (guess =~ /[A-Z]/) != 0
        print "invalid input, try again: "
        guess = gets.chomp.upcase
    end
    puts "******************************"
    puts "you guessed '#{guess}'"
    guesses << guess

    if word.include? guess
        puts "'#{guess}'' is correct"
        correct_g << guess
        while word.include? guess
            correct[word.index(guess)] = guess
            word[word.index(guess)] = "."
        end
    else
        puts "'#{guess}'' is incorrect"
        incorrect_g << guess
        lives -= 1
    end

    puts "Progress: #{correct}"
    puts "Lives Left: ([#{"❤"*lives}] #{lives})"
    puts "******************************"
    round += 1

end

if word == "." * word.length
    puts "You guessed the word #{correct}"
    puts "YOU WIN"
else
    puts "The word was #{words[x].upcase}"
    puts "You had #{correct}"
    puts "YOU LOSE"
end

class Hangman
    def init(lives = 10, guesses = [], right_guesses = [], wrong_guesses = [], progress = [], round = 0, word = "")
        @lives = lives
        @guesses = guesses
        @right_guesses = right_guesses
        @wrong_guesses = wrong_guesses
        @progress = progress
        @round = round
        @word = word
    end

    def state
        puts "##########" + "#" * @round.to_s.length
        puts "# Round #{@round} #"
        puts "##########" + "#" * @round.to_s.length
        puts "Lives Left: ([#{"❤" * @lives}] #{@lives})"
        puts "Progress: #{@progress}"
        puts "Correct guesses  : #{@right_guesses}"
        puts "Incorrect guesses: #{@wrong_guesses}"
    end

    def play_round(guess)
        round += 1
        if @word.include? guess
            right_guesses << guess
            while @word.include? guess
                progress[@word.index(guess)] = guess
                @word[@word.index(guess)] = "."
            end
            return true
        else
            wrong_guesses << guess
            lives -= 1
            return false
        end
    end

end