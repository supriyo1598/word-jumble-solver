require 'Set'

def solve_jumble(word)
  permutations = permutations(word)
  dictionary = load_dictionary('dictionary.txt')
  words = filter_english_words(permutations, dictionary)
  print_words(words)
end

def permutations(word)
  length = word.length
  return [word] if length <= 1

  subwords = Set.new
  length.times do |i|
    char = word[i]
    rest_of_chars = word[0...i] + word[i + 1...length]
    new_perms = permutations(rest_of_chars)
  
    new_perms.each do |perm| 
      subwords.merge([perm, char + perm]) 
    end
  end
  subwords
end

def load_dictionary(dictionary)
  dictionary = Set.new(File.readlines(dictionary).map(&:chomp))
end

def filter_english_words(permutations, dictionary)
  english_words = []
  permutations.each do |perm|
    english_words << perm if dictionary.include?(perm)
  end
  english_words
end

def print_words(words)
  words.each { |word| puts word }
end

solve_jumble(ARGV[0])

