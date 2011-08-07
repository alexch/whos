here = File.expand_path(File.dirname(__FILE__))      
require "#{here}/spec_helper"
require "whos/spam"
module Whos
  describe Spam do
    before do
      @spam = Spam.new
    end
    
    it "includes a known line" do
      assert { @spam.include? "Whois Server Version 2.0" }
    end
    
    it "rejects most of `whois foo.com`" do
      here = File.expand_path(File.dirname(__FILE__))            
      text = File.read("#{here}/foo.com.txt")
      nonspam = File.read("#{here}/foo.com.useful.txt")
      assert { @spam.filter(text) == nonspam }      
    end
  end
end
