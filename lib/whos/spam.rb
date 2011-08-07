module Whos
  class Spam
    def initialize
      @lines = []
      here = File.expand_path(File.dirname(__FILE__))      
      spam_dir = "#{here}/../../spam"
      Dir.glob("#{spam_dir}/*").each do |file|
        puts "reading spam: #{file}"
        read file
      end
      puts
    end
    
    def read file
      File.read(file).each_line do |line|
        @lines << line.strip
      end
    end
    
    def include? s
      @lines.include? s
    end
  end
end