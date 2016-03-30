require 'celluloid'
require 'awesome_print'

class Ping 
  include Celluloid

  def initialize
  end

  def start(ping_count, server)
    begin
      result = `ping -q -c #{ping_count} #{server}`
      hash = { 
        name: result.split("\n").first.split(':').first.gsub('PING ', ''),
        loss_rate: result.split("\n")[-2].split(",").last.split('%').first.strip.to_f,
        avg: result.split('=').last.split('/')[1].to_f
      }
      return hash
    rescue
      return { name: server, loss_rate: 100, avg: 9999 }
    end
  end
end

ping_count = ARGV[0] != nil ? ARGV[0].to_i : 4
futures = []
results = []
ap "Parallel Ping using #{Celluloid.cores} cores, waiting for results..."
File.read('server_list.txt').split.each { |server| futures << Ping.new.future(:start, ping_count, server) }
futures.each { |future| results << future.value }

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
