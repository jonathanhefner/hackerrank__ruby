# https://www.hackerrank.com/challenges/bigger-is-greater

def solve(w)
  # Because we are interested in the lexicographically smallest of
  # possible answers, we want to increment (permute) the right-most
  # letter that would yield a lexicographically larger word.
  #
  # In other words, we want to find the right-most letter which can be
  # replaced by a larger letter from further right of it.  Such letter,
  # which we call the pivot, must therefore precede the longest possible
  # tail of letters arranged in descending order.  Note that the pivot
  # is smaller than the letter it precedes, otherwise the pivot would be
  # part of the ordered tail, but is not necessarily replaced by the
  # letter it precedes because there may be a better choice further to
  # the right.
  p = w.length - 2
  while p >= 0 && w[p] >= w[p + 1]
    p -= 1
  end

  return 'no answer' if p < 0

  # Before replacing the pivot, we sort the letters of the tail in
  # ascending order, including the pivot among them, because we want our
  # permuted word to be as lexicographically small as possible.
  head = w[0...p] # string
  tail = w[p..-1].chars.sort! # array of chars

  # Because the tail is sorted, the pivot's replacement is now easily
  # found at rindex(pivot) + 1.  We remove the replacement from the tail
  # and append it to the head.
  head << tail.delete_at(tail.rindex(w[p]) + 1)

  head + tail.join
end

def main()
  t = gets.strip.to_i
  t.times do
    w = gets.strip
    puts solve(w)
  end
end


main()
