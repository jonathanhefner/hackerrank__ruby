# Richie Rich
# https://www.hackerrank.com/challenges/richie-rich
#
# Sandy likes palindromes. A palindrome is a word, phrase, number, or
# other sequence of characters which reads the same backward as it does
# forward. For example, madam is a palindrome.
#
# On her birthday 7th, Sandy's uncle, Richie Rich, offered her an
# n-digit check which she refused because the number was not a
# palindrome. Richie then challenged Sandy to make the number
# palindromic by changing no more than digits. Sandy can only change 1
# digit at a time, and cannot add digits to (or remove digits from) the
# number.
#
# Given k and an n-digit number, help Sandy determine the largest
# possible number she can make by changing <=k digits.
#
# (Visit the URL above for full problem specification.)


def solve(s, k)
  # Most of the solutions I examined after submitting were lengthy and
  # had repeated conditionals, so here is my simplified solution, O(n)
  # complexity.

  d = s.chars.map(&:to_i)

  # Gathering this information up-front simplifies subsequent logic.
  diffs = (0 ... d.length / 2).count{|i| d[i] != d[-i - 1] }
  return '-1' if diffs > k
  spares = k - diffs

  (0 ... d.length / 2).each do |i|
    # Digits planned to be 9, or we can't afford any more upgrades...
    if d[i] == 9 || d[-i - 1] == 9 || spares == 0
      d[i] = d[-i - 1] = [d[i], d[-i - 1]].max
    # One digit planned to change, but we can afford to upgrade both...
    elsif d[i] != d[-i - 1]
      d[i] = d[-i - 1] = 9
      spares -= 1
    # No changes planned, but we can afford to upgrade both...
    elsif spares >= 2
      d[i] = d[-i - 1] = 9
      spares -= 2
    end
  end

  # Upgrade the middle digit of an odd-length number, if possible.
  d[d.length / 2] = 9 if d.length.odd? && spares > 0

  d.join
end


def main()
  n, k = gets.strip.split(' ').map(&:to_i)
  s = gets.strip
  puts solve(s, k)
end


main()
