require 'Set'

def solve_jumble(word)
  permutations = permutations(word)
  dictionary = load_dictionary
  filter_english_words(permutations, dictionary)
end

def permutations(word)
  length = word.length
  return [word] if length <= 1

  subwords = []
  length.times do |i|
    char = word[i]
    rest_of_chars = word[0...i] + word[i + 1...length]
    new_perms = permutations(rest_of_chars)
  
    new_perms.each do |perm| 
      subwords += [perm, char + perm]
    end
  end
  subwords.uniq
end

def load_dictionary
  @dictionary = Set.new(File.readlines('dictionary.txt'))
  @dictionary.map! { |word| word.chomp }
end

def filter_english_words(permutations, dictionary)
  english_words = []
  permutations.each do |perm|
    english_words << perm if dictionary.include?(perm)
  end
  english_words
end

puts solve_jumble(ARGV[0])

