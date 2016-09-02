# Counter Game
# https://www.hackerrank.com/challenges/counter-game
#
# Louise and Richard play a game.  They have a counter set to N. Louise
# gets the first turn and the turns alternate thereafter.  In the game,
# they perform the following operations:
#
#   * If N is not a power of 2, reduce the counter by the largest power
#     of 2 less than N.
#   * If N is a power of 2, reduce the counter by half of N.
#   * The resultant value is the new N which is again used for
#     subsequent operations.
#
# The game ends when the counter reduces to 1, i.e., N == 1, and the
# last person to make a valid move wins.
#
# Given N, your task is to find the winner of the game.
#
# (Visit the URL above for full problem specification.)


def solve(n)
  # Simulating the counter is relatively straightforward and results in
  # an O(log2(N)) solution.  However, if our computer hardware supports
  # a special instruction to count the number of high bits in an
  # integer, we can craft an O(1) solution.  (Typically, this
  # instruction is called "popcount" for "population count".)  To do
  # this, we must realize what the game's rules imply on a binary level.
  # The first rule, which says "reduce the counter by the largest power
  # of 2 less than N", actually means zero-out the most significant high
  # bit of N.  The second rule, which says "reduce the counter by half
  # of N", actually means bitwise right shift N.  Thus the number of
  # turns in the game is equal to the number of ones we can zero-out
  # (excluding the final one when N=1), plus the number of non-ones
  # (zeroes) we can shift off the right side of N until N=1.  Because
  # the game starts with Louise, if there are an odd number of turns,
  # Louise wins; otherwise, Richard wins.
  ones = popcount(n)
  trailing_zeros = popcount((n & -n) - 1)
  turns = ones - 1 + trailing_zeros
  turns.odd? ? 'Louise' : 'Richard'
end


def popcount(x)
  # very inefficient, but this is only a placeholder for a hardware op
  x.to_s(2).count('1')
end


def main
  t = gets.strip.to_i
  t.times do
    n = gets.strip.to_i
    puts solve(n)
  end
end


main()
