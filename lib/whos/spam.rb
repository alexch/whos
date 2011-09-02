module Whos
  class Spam
    def initialize
      @lines = []
      here = File.expand_path(File.dirname(__FILE__))      
      spam_dir = "#{here}/../../spam"
      Dir.glob("#{spam_dir}/*").each do |file|
        read file
      end
    end
    
    def << s
      @lines << s.strip
    end
    
    def read file
      File.read(file).each_line do |line|
        self << line
      end
    end
    
    def include? s
      s.strip!
      s == "" or @lines.include? s
    end
    
    def filter s
      s.each_line.reject do |line|
        include? line
      end.join("\n")
    end
  end
end