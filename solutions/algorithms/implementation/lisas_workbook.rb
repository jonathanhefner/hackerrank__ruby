# Lisa's Workbook
# https://www.hackerrank.com/challenges/lisa-workbook
#
# Lisa just got a new math workbook.  A workbook contains exercise
# problems, grouped into chapters.
#
#   * There are n chapters in Lisa's workbook, numbered from 1 to n.
#   * The i-th chapter has t[i] problems, numbered from 1 to t[i].
#   * Each page can hold up to k problems.  There are no empty pages or
#     unnecessary spaces, so only the last page of a chapter may contain
#     fewer than k problems.
#   * Each new chapter starts on a new page, so a page will never
#     contain problems from more than one chapter.
#   * The page number indexing starts at 1.
#
# Lisa believes a problem to be special if its index (within a chapter)
# is the same as the page number where it's located.  Given the details
# for Lisa's workbook, can you count its number of special problems?
#
# (Visit the URL above for full problem specification.)


def solve(k, t)
  # Of the few dozen solutions I examined after submitting, all used
  # nested loops, resulting in O(n*k) algorithms.  Here is my O(n)
  # solution.

  # Each chapter may have up to two special problems.  A chapter can't
  # have more than two because the numbering of problems in a chapter
  # increments at least as fast as the numbering of pages, and no blank
  # pages are allowed.  When a chapter does have two special problems,
  # they both occur on a page boundary, e.g. problem 9 occurs as the
  # last problem on page 9, and problem 10 occurs as the first problem
  # on page 10.

  return t.first if k == 1

  # We first compute the starting page of each chapter.
  start_pages = t.reduce([1]){|p, x| p << (p.last + (x + k - 1) / k) }

  # Next, for each chapter, we conceptualize the numbering of problems
  # and numbering of pages as two lines:
  #
  #     problem = x + 1
  #     page = (1 / k) * x + start_page
  #
  # The intersection of these two lines determines the special problem.
  # Remember that two (non-parallel) lines intersect at exactly one
  # point.  If that point is beyond the number of problems in a chapter,
  # there is no special problem in that chapter.  Also note that having
  # two special problems in one chapter is an artifact of truncation,
  # i.e. the last problem on a page actually corresponds to a fractional
  # page number which can't equal the integral problem number.  Thus the
  # above equations find the latter of two special problems in a
  # chapter, the one which is first on a page and thus has an integral
  # page number.
  t.zip(start_pages).map do |problems, start_page|
    # We solve the above equations for x, and add 1 (per the first
    # equation) to yield the special problem number.  Our terms are
    # arranged carefully to use integer arithmetic truncation to find
    # special problems in the middle of a page.
    s = (k * (start_page - 1) / (k - 1)) + 1

    # Count the special problem if it exists, and...
    (s <= problems ? 1 : 0) +
      # ...account for a second special problem at the end of a page
      ((s % k == 1 && s > 1 && s <= (problems + 1)) ? 1 : 0)
  end.reduce(&:+)
end


def main()
  n, k = gets.strip.split(' ').map(&:to_i)
  t = gets.strip.split(' ').map(&:to_i)
  puts solve(k, t)
end


main()
