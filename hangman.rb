#=begin
class Hangman
    def self.load
        #New game or Saved Game
        puts "Lets start a new game!"
        game = Hangman.new
        game.start
    end
    
    def initialize
        #track the important instance variables
        @used_guesses ||= 0
        @lives = 6
        @word = pick_word(load_dictionary).downcase
        @past_guesses = []
        @word_guessed = Array.new(@word.length-1, "_") #-1 bcuz \n counts as a character for every word in the dictionary
    end
    
    def start
        loop do
            #play out the turns
            self.turn
            
            break if @lives == 0
        end
    end
    
    def load_dictionary
        puts "no dictionary found" unless File.exist? "dictionary.txt"
        File.readlines "dictionary.txt"
    end
    
    def pick_word(dictionary)
        #pick a random word/line from the dictionary
        dictionary[rand(dictionary.length)]
    end
    
    def turn
        #run turn
        guess = ""
        loop do
            puts "Enter your guess(remember only a single letter at a time):"
            guess = gets.chomp.downcase
            guess.gsub!(/[^a-zA-Z]/, '')
            break if guess.length == 1
        end
        
        #array of the word
        
        word_array = @word.split("")
        word_array.delete("\n")
        
        #check guess
        if @past_guesses.include? guess
            puts "You already made this guess"
            
            puts "Word: " + @word_guessed.join()
            puts "Lives: #{@lives}"
        elsif word_array.include? guess #success
            if guess == "a" || guess == "e" || guess == "i" || guess == "o" || guess == "u"
                puts "Yes there is an '#{guess}'"
            else
                puts "Yes there is a '#{guess}'"
            end
            index = []
            #make index an array
            word_array.each_with_index do |value,ind|
                if value == guess
                    index << ind
                end
            end
            
            index.each do |i|
                @word_guessed[i] = guess
            end
            
            puts "Word: " + @word_guessed.join()
            puts "Lives: #{@lives}"
        else #failure
            if guess == "a" || guess == "e" || guess == "i" || guess == "o" || guess == "u"
                puts "Sorry but the word doesn't have an '#{guess}'"
            else
                puts "Sorry but the word doesn't have a '#{guess}'"
            end
            
            @lives -= 1
            
            puts "Word: " + @word_guessed.join()
            puts "Lives: #{@lives}"
        end
        
        @past_guesses << guess
        
        if @word_guessed.join() == word_array.join() #you win
            puts "Winner Winner Chicken Dinner!"
            exit
        end
        
        if @lives == 0
            puts "Your out of lives! The word was '#{@word}'"
            
            
        end
        
        puts "Your guesses so far #{@past_guesses.join(",")}"
        
        #puts @word
        #display
        
        #check for a winner
    end
    
end

Hangman.load()
#=end

=begin
abc = File.readlines "dictionary.txt"
test = Hangman.new
puts test.pick_word(abc)
=end