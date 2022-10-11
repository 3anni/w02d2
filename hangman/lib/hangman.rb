class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  # random_word = DICTIONARY.sample()

  def self.random_word
    DICTIONARY.sample
  end


  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses


  def initialize()
    @secret_word = Hangman.random_word #.split("")
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    matching_indices = []

    @secret_word.each_char.with_index do |letter, i|
      if letter == char
        matching_indices << i
      end
    end

    matching_indices
  end

  def fill_indices(char, arr)
    arr.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    if already_attempted?(char)
      puts "that has already been attempted"
      return false
    end

    attempted_chars << char

    indices = get_matching_indices(char)

    if indices.length == 0
      @remaining_incorrect_guesses -= 1
    else
      fill_indices(char, indices)
    end

    true
  end

  def ask_user_for_guess
    puts "Enter a char:"
    user_input = gets.chomp
    try_guess(user_input)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      return true
    else
      return false
    end
  end


end
