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
    
    def read file
      File.read(file).each_line do |line|
        @lines << line.chomp.strip
      end
    end
    
    def include? s
      @lines.include? s.strip
    end
    
    def filter s
      s.each_line.reject do |line|
        line.chomp!
        include? line
      end.join("\n")
    end
  end
end