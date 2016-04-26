require 'celluloid/current'
require 'awesome_print'
require 'ruby-progressbar'

class Ping 
  include Celluloid

  def start(ping_count, server, progressbar)
    no_response = { name: server, loss_rate: 100, avg: 9999 }
    begin
      # The ping utility exits with one of the following values:
      # 0       At least one response was heard from the specified host.
      result = `ping -q -c #{ping_count} #{server}`
      if $?.exitstatus == 0
        response = {
          name: result.split("\n").first.split(':').first.gsub('PING ', ''),
          loss_rate: result.split("\n")[-2].split(",").last.split('%').first.strip.to_f,
          avg: result.split('=').last.split('/')[1].to_f
        }
        progressbar.increment
        return response
      else
        progressbar.increment
        return no_response
      end
    rescue
      progressbar.increment
      return no_response
    end
  end
end

PING_COUNT = ARGV[0] == nil ? 4 : ARGV[0].to_i
SERVER_LIST = File.read('server_list.txt').split
futures = []
results = []
progressbar = ProgressBar.create(total: SERVER_LIST.size, format: "%a %e %P% Processed: %c from %C", smooth: 0.6)

SERVER_LIST.each { |server| futures << Ping.new.future(:start, PING_COUNT, server, progressbar) }
futures.each { |future| results << future.value }

least_loss = results.sort_by { |hsh| [hsh[:loss_rate], hsh[:avg]] }
least_latency = results.sort_by { |hsh| [hsh[:avg], hsh[:loss_rate]] }

ap Time.now
if least_loss.first == least_latency.first
  if least_loss.first[:loss_rate] != 100
    ap "The One:"
    ap least_loss.first
  else
    ap "All servers are down or -- maybe check your network :("
  end
else
  ap "Least loss, then least latency:"
  ap least_loss.first
  ap "Least latency, then least loss:"
  ap least_latency.first
end
