# Non-Divisible Subset
# https://www.hackerrank.com/challenges/non-divisible-subset
#
# Given a set, S, of n distinct integers, print the size of a maximal
# subset, S', of S where the sum of any 2 numbers in S' are not evenly
# divisible by k.
#
# (Visit the URL above for full problem specification.)


def solve(a, k)
  # This solution is based on the property:
  #   (x + y) % k == (x % k + y % k) % k

  # We reduce our array of n numbers to an array of k counts.
  counts = a.reduce([0] * k){|c, x| c[x % k] += 1; c }

  # Next we observe that each number in the interval 1..(k-1) can be
  # paired with only one other number in that interval to produce a sum
  # divisible by k (with an exception, see further below).  Namely, for
  # any q in 1..(k-1), we must choose between q and (k - q) in our
  # maximal subset.  Thus we choose the one that corresponds to the most
  # elements from the original array of numbers.
  answer = (1 ... (k + 1) / 2).reduce(0) do |ans, q|
    ans + [counts[q], counts[k - q]].max
  end

  # Note that counts[0] is excluded from the answer above.  Only one x
  # for which (x % k) == 0 may be present in our maximal subset.
  # Otherwise we would have a pair for which (x1 + x2) % k == 0.
  answer += 1 if counts[0] > 0

  # Also note that when k is even, counts[k / 2] is carefully excluded
  # from the answer above.  This is because, like the previous
  # exception, only one x for which (x % k) == (k / 2) may be present in
  # our maximal subset.  Otherwise we would have a pair for which
  # (x1 + x2) % k == (k / 2 + k / 2) % k == (k % k) == 0.
  answer += 1 if k.even? && counts[k / 2] > 0

  answer
end


def main()
  n, k = gets.strip.split(' ').map(&:to_i)
  a = gets.strip.split(' ').map(&:to_i)
  puts solve(a, k)
end


main()
