require "./lib/graphite"

# last started parkingsessions
SCHEDULER.every '10s', :first_in => 0 do
    # Create an instance of our helper class
    q = Graphite.new "http://graphite.formhub.org/"
    
    stat_name = "summarize(stats_counts.response.201,\"1day\",\"sum\",false)"
    
    # get points for the last half hour
    points = q.points stat_name, "-7days"
    
    # send to dashboard, so the number the meter and the graph widget can understand it
    send_event 'submissions_per_day', { points: points }
end
