puts "HANGMAN"

words = File.readlines "5desk.txt"

words.map! { |word|
    word = word.upcase
    word[0..-4]
}

x = 0
while words[x].length < 5 || words[x].length > 12
    x = rand(0..words.length)
end

puts words[x]

lives = 10
incorrect = []
correct = "_"*words[x].length
while lives > 0
    puts "Lives Left: [#{"*"*lives}]"
    puts "Correct Guesses: #{correct}"
    puts "Incorrect guesses: #{incorrect}"
    print "Guess a letter: "
    guess = gets.chomp

    if words[x].include? guess
        


end
