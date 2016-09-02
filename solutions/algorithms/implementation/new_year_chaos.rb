# New Year Chaos
# https://www.hackerrank.com/challenges/new-year-chaos
#
# It's New Year's Day and everyone's in line for the Wonderland
# rollercoaster ride!
#
# There are n people queued up, and each person wears a sticker
# indicating their initial position in the queue (i.e.: 1, 2, ...,
# n - 1, n with the first number denoting the frontmost position).
#
# Any person in the queue can bribe the person directly in front of them
# to swap positions.  If two people swap positions, they still wear the
# same sticker denoting their original place in line.  One person can
# bribe at most two other persons.
#
# That is to say, if n = 8 and Person 5 bribes Person 4, the queue will
# look like this: 1, 2, 3, 5, 4, 6, 7, 8.
#
# Fascinated by this chaotic queue, you decide you must know the minimum
# number of bribes that took place to get the queue into its current
# state!
#
# (Visit the URL above for full problem specification.)


def solve(q)
  # The minimum number of bribes is equal to the number of swaps, or in
  # other words, the number of values out of order.  This can be counted
  # as, for each value, the number of values less than itself that occur
  # to the right of it.  Example: [1, 4, 2, 3] counts two out-of-order
  # values (relative to the value 4).  Another example: [1, 4, 3, 2]
  # counts three out-of-order values (two relative to the value 4, one
  # relative to the value 3).
  #
  # Implementing this as an O(n^2) algorithm is easy, but by using a
  # Fenwick Tree (also known as a Binary Indexed Tree) we can achieve
  # O(n*log(n)) complexity.  A Fenwick Tree is a clever data structure
  # that maintains a list of counters.  Its primary function sums a
  # range of those counters in O(log(n)) time, rather than O(n) time.
  f = Fenwick.new(q.length)

  # We iterate in reverse to approach from the right...
  q.reverse_each.reduce(0) do |bribes, x|
    # Each value gets its own counter, which will be either 0, or 1 if
    # the value has already been encountered (to the right).
    f.increment!(x)
    # Thus the number of out-of-order elements relative to value x is
    # the sum of lesser-value counters.
    b = f.sum_to(x - 1)
    break if b > 2
    bribes + b
  end || 'Too chaotic'
end


class Fenwick
  def initialize(max_countable)
    @f = [0] * (max_countable + 1)
  end

  def sum_to(i)
    sum = 0
    while i > 0
      sum += @f[i]
      i -= i & -i
    end
    sum
  end

  def increment!(i)
    while i < @f.length
      @f[i] += 1
      i += i & -i
    end
    self
  end
end


def main()
  t = gets.strip.to_i
  t.times do
    n = gets.strip.to_i
    q = gets.strip.split(' ').map(&:to_i)
    puts solve(q)
  end
end


main()
