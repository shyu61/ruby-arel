require 'benchmark'

def print_memory_usage
  memory_before = `ps -o rss= -p #{Process.pid}`.to_i
  yield
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i

  puts "Memory: #{((memory_after - memory_before) / 1024.0).round(2)} MB"
end

def print_time_spent
  time = Benchmark.realtime do
    yield
  end

  puts "Time: #{time.round(2)}"
end

num = 10_000

print_memory_usage do
  print_time_spent do
    jcs = []
    num.times do |i|
      jcs << JobCandidate.where(id: i)
    end
  end
end

print_memory_usage do
  print_time_spent do
    jcs = []
    num.times do |i|
      jcs << JobCandidate.find_by(id: i)
    end
  end
end

# ========================

Benchmark.bm 10 do |r|
  r.report "where" do
    num.times do |i|
      JobCandidate.where(id: i)
    end
  end

  r.report "find" do |i|
    num.times do |i|
      JobCandidate.find_by(id: i)
    end
  end
end
