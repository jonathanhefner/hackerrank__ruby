# https://www.hackerrank.com/challenges/bfsshortreach

def solve(n, e, s)
  # This solution is actually a straightforward breadth-first graph
  # traversal, but many of the other solutions I examined after
  # submitting were lengthy and did extra work, given the problem's
  # contraints.

  # We convert our edge list into an adjacency list.  Note that we also
  # convert from the problem's 1-based indexing to 0-based indexing.
  adjacent = n.times.map{|i| [] }
  e.each do |u, v|
    adjacent[u - 1] << v - 1
    adjacent[v - 1] << u - 1
  end

  # Prepare for the traversal.  Our `distance` list stores the shortest
  # distance from each node to the starting point.
  distance = [-1] * n
  distance[s - 1] = 0
  queue = Queue.new
  queue.enq(s - 1)
  queued = [false] * n
  queued[s - 1] = true

  # Perform the traversal.  For each queued node, we set the distance
  # of any unqueued adjacent nodes, and add them to the queue.  Because
  # each node is equidistant, and we start at the starting point, and
  # nodes are never queued twice, we can be sure the distance we set is
  # the minimum distance to the starting point.
  until queue.empty?
    u = queue.deq()
    adjacent[u].each do |v|
      unless queued[v]
        distance[v] = distance[u] + 6
        queue.enq(v)
        queued[v] = true
      end
    end
  end

  # Finally, we remove our starting node from the distance list.  (This
  # step is specific to this problem's requirements.)
  distance.delete_at(s - 1)
  distance
end

def main
  q = gets.strip.to_i
  q.times do
    n, m = gets.strip.split(' ').map(&:to_i)
    e = m.times.map{|i| gets.strip.split(' ').map(&:to_i) }
    s = gets.strip.to_i

    puts solve(n, e, s).join(' ')
  end
end


main()
