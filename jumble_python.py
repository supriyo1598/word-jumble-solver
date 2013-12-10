import sys

def solve_jumble(word):
    perms = permutations(word)
    dictionary = load_dictionary("dictionary.txt")
    words = filter_english_words(perms, dictionary)
    print_words(words)

def permutations(word):
    length = len(word)
    if length <= 1:
        return [word] 
    
    subwords = set()
    for i in range(length):
        char = word[i]
        rest_of_chars = word[0:i] + word[(i + 1):length]
        new_perms = permutations(rest_of_chars)

        for permutation in new_perms:
            subwords = subwords.union([permutation, char + permutation])    
    return subwords

def load_dictionary(dictionary_file):
    dictionary = set()
    with open(dictionary_file) as f:
        for line in f:
            dictionary.add(line.strip())    
    return dictionary
   
def filter_english_words(permutations, dictionary):
    english_words = []
    for perm in permutations:
        if perm in dictionary:
            english_words += [perm]  
    return english_words

def print_words(words):
    for word in words:
        print word 


solve_jumble(sys.argv[1])

