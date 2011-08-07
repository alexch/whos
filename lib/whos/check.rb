module Whos
  class Check
    def initialize
      @spam = Whos::Spam.new
    end

    def available? domain
      print "Checking #{domain}..."
      response = `whois #{domain}`

      if response =~ /^No match for/
        puts " AVAILABLE!"
        true
      else
        puts " exists :-("
        if $verbose
          puts @spam.filter(response)
        end
        false
      end
    end

    def many names
      domains = names.map do |domain|
        if domain =~ /\./
          domain
        else
          %w{com net org biz}.map do |tld|
            "#{domain}.#{tld}"
          end
        end
      end.flatten
        
      domains.each do |domain|
        available = available? domain
        `open http://#{host}` if !available and $open
      end
    end
  end
end


