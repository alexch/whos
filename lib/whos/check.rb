require 'peach'

module Whos
  class Check
    attr_reader :responses
    
    def initialize
      @spam = Whos::Spam.new
      @responses = {}
    end
    
    def available? domain
      response = `whois #{domain}`

      if response =~ /^(No match for|Not found)/i
        true
      else
        responses[domain] = @spam.filter(response)
        false
      end
    end
    
    def tlds
      %w{com net org biz info us}
    end

    def many names
      domains = names.map do |domain|
        if domain =~ /\./
          print "Checking... "
          domain
        else
          puts "Checking #{domain}.#{tlds.join(',')}..."
          tlds.map do |tld|
            "#{domain}.#{tld}"
          end
        end
      end.flatten

      domains.peach do |domain|
        if available? domain
          print "#{domain} AVAILABLE!\n"
        else
          print "#{domain} taken :-(\n"
          `open http://#{domain}` if $open
        end
      end

      if $verbose
        domains.each do |domain|
          if responses[domain]
            puts
            puts "== #{domain} =="
            puts responses[domain]
          end
        end
      end
    end
  end
end

