#require 'celluloid'
require 'celluloid/current'
require 'awesome_print'
require 'benchmark'
#require 'pry'

class Ping 
  include Celluloid

  def start(ping_count, server)
    no_response = { name: server, loss_rate: 100, avg: 9999 }
    begin
      # The ping utility exits with one of the following values:

      # 0       At least one response was heard from the specified host.
      result = `ping -q -c #{ping_count} #{server}`
      return no_response if $?.exitstatus != 0

      response = {
        name: result.split("\n").first.split(':').first.gsub('PING ', ''),
        loss_rate: result.split("\n")[-2].split(",").last.split('%').first.strip.to_f,
        avg: result.split('=').last.split('/')[1].to_f
      }
      return response
    rescue
      return no_response
    end
  end
end

ping_count = ARGV[0] != nil ? ARGV[0].to_i : 4
futures = []
File.read('server_list.txt').split.each { |server| futures << Ping.new.future(:start, ping_count, server) }

results = []
Benchmark.bm do |b|
  b.report "Parallel Ping using #{Celluloid.cores} cores, waiting for results...\n" do
    futures.each do |future|
      results << future.value
    end
  end
end

least_loss = results.sort_by { |hsh| [hsh[:loss_rate], hsh[:avg]] }
least_latency = results.sort_by { |hsh| [hsh[:avg], hsh[:loss_rate]] }

if least_loss.first == least_latency.first
  ap "The One:"
  ap least_loss.first
else
  ap "Least loss, then least latency:"
  ap least_loss.first
  ap "Least latency, then least loss:"
  ap least_latency.first
end
