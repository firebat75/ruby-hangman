require "./hangman"

puts "Welcome to Hangman, make a selection"
puts "[1] Start a new game"
puts "[2] Load from a save file"
print "choose by entering the option's number: "
input = gets.chomp

while input != "1" && input != "2"
    puts "invalid selection"
    print "choose by entering the option's number: "
    input = gets.chomp
end
    
if input == "2"
    puts "Which file would you like to load"
    opt = 1
    saves = Dir.entries("saves")[3..-1]
    for item in saves
        print "[#{opt}] "
        opt += 1
        puts item[0..-6]
    end

    print "choose by entering the option's number: "
    input = gets.chomp

    while input.to_i < 1 || input.to_i > saves.length || (input =~ /[0-9]/) != 0 
        print "invalid selection, try again: "
        input = gets.chomp
    end


    puts saves
    puts saves[input.to_i - 1]

    opened = open_save("saves/#{saves[input.to_i - 1]}")

    play_game(opened)
end

if input == "1"
    word = get_word
    game = Hangman.new(word, word[0..-1])

    play_game(game)
end