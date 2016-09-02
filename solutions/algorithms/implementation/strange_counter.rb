# Strange Counter
# https://www.hackerrank.com/challenges/strange-code
#
# Bob has a strange counter. At the first second, t = 1, it displays the
# number 3.  At each subsequent second, the number displayed by the
# counter decrements by 1.
#
# The counter counts down in cycles.  In the second after the counter
# counts down to 1, the number becomes 2x the initial number for that
# countdown cycle and then continues counting down from the new initial
# number in a new cycle.
#
# Given a time, t, find and print the value displayed by the counter at
# time t.
#
# (Visit the URL above for full problem specification.)


def solve(t)
  # Of the few dozen solutions I examined after submitting, most used
  # loops to simulate the counter, resulting in O(n) algorithms.  Here
  # is my O(1) solution.

  # First we map t to a lower resolution, removing "multiple of 3" from
  # our concerns, and turning this into a basic logarithm problem.
  lowres_t = (t / 3.0).ceil

  # Next we calculate the current tick of the current cycle.
  cycles_done = Math.log2(lowres_t).floor
  cycle_size = 2 ** cycles_done
  ticks_done = cycle_size - 1
  cycle_tick = lowres_t - ticks_done

  # Finally we map that tick to a display value and adjust for the error
  # from using a lower resolution t.
  (cycle_size - cycle_tick + 1) * 3 - (t - 1) % 3
end


def main()
  t = gets.strip.to_i
  puts solve(t)
end


main()
