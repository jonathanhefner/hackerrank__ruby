# Maximizing XOR
# https://www.hackerrank.com/challenges/maximizing-xor
#
# Given two integers, L and R, find the maximal value of A xor B, where
# A and B satisfy the following condition: L <= A <= B <= R.
#
# (Visit the URL above for full problem specification.)


def solve(l, r)
  # Almost all of the solutions I examined after submitting used a brute
  # force comparison algorithm resulting in O(R^2) complexity.  Here is
  # my O(log2(R)) solution.

  # Maximizing A xor B is the same as choosing A and B such that they
  # have the fewest number of equal binary digits.  In the general case,
  # this is simple: choose B as the greatest power of 2 less than R
  # (i.e. the most significant bit of R), and choose A as B - 1 (i.e.
  # all bits to the right of R's most significant bit set to 1).
  # However, if L and R are too close together, this naive strategy
  # results in B < L.  To reconcile this, we instead determine the
  # longest common binary prefix (ending in 1) of L and R.  All bits of
  # this prefix are necessarily fixed in A and B, because A and B are
  # bound by L and R.  The remaining bits beyond this prefix are freely
  # choosable, as before.  Therefore the maximal value of A xor B is
  # the result of setting all free (non-prefix) bits to 1.
  f = 0
  f += 1 while (l >> f) != (r >> f)
  (1 << f) - 1
end


def main()
  l = gets.strip.to_i
  r = gets.strip.to_i
  puts solve(l, r)
end


main()
