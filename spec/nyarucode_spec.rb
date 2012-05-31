# coding: utf-8

require File.join(File.dirname(__FILE__), 'spec_helper')

require 'tempfile'

describe Integer do
  it "should be converted to another base correctly" do
    # binary
    0.base_of(2).should == [0]
    1.base_of(2).should == [1]
    2.base_of(2).should == [0, 1]
    3.base_of(2).should == [1, 1]
    4.base_of(2).should == [0, 0, 1]
    5.base_of(2).should == [1, 0, 1]
    
    # duodecimal (used in the program)
    0.base_of(12).should == [0]
    1.base_of(12).should == [1]
    12.base_of(12).should == [0, 1]
    23.base_of(12).should == [11, 1]
    24.base_of(12).should == [0, 2]
    145.base_of(12).should == [1, 0, 1]
  end
end

describe Pebbles::Nyarucode do
  it "should generate appropriate Ruby codes for integers" do
    # Since it uses duodecimal internally, numbers 0 to 12 should be tested
    (0..12).each do |x|
      eval(Pebbles::Nyarucode.num(x)).should == x
    end
    
    # Minus numbers and larger numbers than 12 should also be tested
    [-14, -2, 14, 145, 10000].each do |x|
      eval(Pebbles::Nyarucode.num(x)).should == x
    end
  end
  
  it "should generate appropriate Ruby codes for strings" do
    ['', ' ', 'うー！にゃー！'].each do |x|
      eval(Pebbles::Nyarucode.str(x)).should == x
    end
  end
  
  it "should generate appropriate Ruby codes for any source codes" do
    src = "def nyaruko_test_factorial(i); i <= 1 ? 1 : i * nyaruko_test_factorial(i - 1); end; nyaruko_test_factorial(5)"
    eval(Pebbles::Nyarucode.convert(src)).should == eval(src)
  end
  
  it "should be run in a command line and generate a new code" do
    original_code = Tempfile.open('nyaruko-orig')
    original_code.print <<FILE
#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

puts "ニャル子さん"

def factorial(arg)
  if arg <= 1
    1
  else
    arg * factorial(arg - 1)
  end
end

puts factorial(5)
FILE
    original_code.close
    
    resulted_code = Tempfile.open('nyaruko-result')
    resulted_code.print `#{BINPATH}/nyarucode #{original_code.path}`
    resulted_code.close
    
    `ruby #{resulted_code.path}`.should == "ニャル子さん\n120\n"
  end
end

