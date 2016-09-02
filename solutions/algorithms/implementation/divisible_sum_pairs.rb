# Divisible Sum Pairs
# https://www.hackerrank.com/challenges/divisible-sum-pairs
#
# You are given an array of n integers, a[0] ... a[n - 1], and a
# positive integer, k.  Find and print the number of (i, j) pairs where
# i < j and a[i] + a[j] is evenly divisible by k.
#
# (Visit the URL above for full problem specification.)


def solve(a, k)
  # This problem is very similar to "Non-Divisible Subset" (see
  # non_divisible_subset.rb), but the input constraints in the full
  # problem specification are much smaller, making a brute-force
  # solution feasible in this case.  However, we still use the smart and
  # efficient approach, similar to non_divisible_subset.rb.

  # This solution is based on the property:
  #   (x + y) % k == (x % k + y % k) % k

  # We reduce our array of n numbers to an array of k counts.
  counts = a.reduce([0] * k){|c, x| c[x % k] += 1; c }

  # Next we observe that each number in the interval 1..(k-1) can be
  # paired with only one other number in that interval to produce a sum
  # divisible by k (with an exception, see further below).  Namely, for
  # any q in 1..(k-1), we can only pair it with (k - q).
  answer = (1 ... (k + 1) / 2).reduce(0) do |ans, q|
    ans + (counts[q] * counts[k - q])
  end

  # Note that counts[0] is excluded from the answer above.  Numbers
  # for which (x % k) == 0 can only be paired with themselves to produce
  # a pair for which (x1 + x2) % k == 0.
  answer += choose2(counts[0])

  # Also note that when k is even, counts[k / 2] is carefully excluded
  # from the answer above.  This is because, like the previous
  # exception, numbers for which (x % k) == (k / 2) can only be paired
  # with themselves.
  answer += choose2(counts[k / 2]) if k.even?

  answer
end


def choose2(n)
  # n! / (k! * (n - k)!)
  n * (n - 1) / 2
end


def main()
  n, k = gets.strip.split(' ').map(&:to_i)
  a = gets.strip.split(' ').map(&:to_i)
  puts solve(a, k)
end


main()
