#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# Rubyのソースコードを与えると、同じ働きをする
# 「（」・ω・）」うー！（／・ω・）／にゃー！」だらけの
# コードを出力するプログラム
#
# Ruby1.9系列限定、文字コードは1種類に統一する必要あり
#
# 元ネタ（JavaScript版）：
# http://sanya.sweetduet.info/unyaencode/
# http://gigazine.net/news/20120528-unyaencode/

class Pebbles
  class Nyarucode
    VERSION = '0.1.1'
  end
end

# n進法

class Integer
  def base_of(b)
    if self < 0
      return((-self).base_of(b).map{ |x| -x })
    elsif self == 0
      return [0]
    end
    
    result = []
    x = self
    while x > 0
      result << (x % b)
      x /= b
    end
    
    result
  end
end

class Pebbles::Nyarucode
  # 結果が「1つの整数」となる場合限定で、うー！にゃー！化された
  # Rubyコードを出力する。

  def self.num_base(i)
    case i
    when 0
      '/・ω・）/=~(%/・ω・）/)'
    when 1
      '/・ω・）/=~%(/・ω・）/うー！にゃー！)'
    when 2
      '/・ω・）/=~\'(/・ω・）/うー！にゃー！\''
    when 3
      '/・ω・）/=~\' (/・ω・）/うー！にゃー！\''
    when 4
      '/・ω・）/=~\'うー(/・ω・）/にゃー！\''
    when 5
      '/・ω・）/=~\'うー！(/・ω・）/にゃー！\''
    when 6
      '/・ω・）/=~\'うー！ (/・ω・）/にゃー！\''
    when 7
      '/・ω・）/=~\'にゃー！ (/・ω・）/\''
    when 8
      '/・ω・）/=~\'うー！にゃー(/・ω・）/\''
    when 9
      '/・ω・）/=~\'うー！にゃー！(/・ω・）/\''
    when 10
      '/・ω・）/=~\'(」・ω・)」 (/・ω・）/うー！にゃー！\''
    when 11
      '/・ω・）/=~\'（」・ω・)」うー(/・ω・）/にゃー！\''
    when 12
      '/・ω・）/=~\'(」・ω・)」うー！(/・ω・）/にゃー！\''
    else
      raise ArgumentError, "Unexpected error: only integers 1 to 12 are accepted (given: #{i.inspect})"
    end
  end

  def self.num(i)
    i = i.to_i
    if i < 0
      return "-(#{Pebbles::Nyarucode.num(-i)})"
    end
    if i == 0
      return Pebbles::Nyarucode.num_base(0)
    end
    
    nyaruko12 = Pebbles::Nyarucode.num_base(12)
    arr = i.base_of(12)
    init_print = true
    
    result_list = []
    
    # 12進法で1桁目
    digit = arr.shift
    result_list << "(#{Pebbles::Nyarucode.num_base(digit)})" if digit != 0
    
    # 12進法で2桁目
    unless arr.empty?
      digit = arr.shift
      result_list << "(#{Pebbles::Nyarucode.num_base(digit)})*\n(#{nyaruko12})" if digit != 0
    end
    
    # 12進法で3桁目以降
    arr.each_with_index do |digit, i|
      result_list << "(#{Pebbles::Nyarucode.num_base(digit)})*\n(#{nyaruko12})**\n(#{Pebbles::Nyarucode.num_base(i+2)})"
    end
    
    result_list.join("+\n")
  end
  
  # 結果が「1つの文字列」となる場合限定で、うー！にゃー！化された
  # Rubyコード。

  def self.str(orig_string)
    result = "''"
    orig_string.each_codepoint do |c|
      result << "<<\n#{Pebbles::Nyarucode.num(c)}"
    end
    result
  end

  # 任意のソースコードに対する、うー！にゃー！化された
  # Rubyコード。
  
  def self.convert(orig_source)
    # 以下のコードは、分かりやすく書くとこうなる
    # (->(arg1, arg2){ send arg1, arg2 }
    # )["eval", orig_source]
    # すなわち、"Kernel.eval(#{orig_source})" という意味になる。
    # ここで、orig_sourceは所望のソースコードを出力するための
    # Rubyコードである（Pebbles::Nyarucode.strメソッドで生成可能）。
    "(->(」・ω・）」うー！,（／・ω・）／にゃー！\n){send(」・ω・）」うー！,（／・ω・）／にゃー！)}\n)[#{Pebbles::Nyarucode.str("eval")},#{Pebbles::Nyarucode.str(orig_source)}]"
  end
end

