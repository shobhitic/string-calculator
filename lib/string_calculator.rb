=begin
This is the String kata performed in ruby. Run rake command to see the output. Documentation can be found in test folder.
Also see http://osherove.com/tdd-kata-1/ for more details.

Author: Shobhit Bakliwal	
=end

require 'string_calculator/negative_given_error'

class StringCalculator

  def self.add(str)
    return 0 if str == ""

    str = strip_meta_information(str)
    delimitter = /,|\n/

    negatives = []

    if str =~ delimitter
      sum = 0
      str.split(delimitter).each do |number|
        n = number.to_i
        negatives.push n if n < 0
        sum += n unless n > 1000
      end
      raise NegativeGivenError.new(negatives) unless negatives.empty?
      sum
    else
      str.to_i
    end
  end

  def self.strip_meta_information(str)
    if str[0..1] == "//"
      delimitters = find_delimitters(str)
      delimitters.each do |delimitter|
        str.gsub!(delimitter, ",")
      end
      str.gsub!(/\/\/.*?\n/, "")
    end
    str
  end

  def self.find_delimitters(str)
    delimitters = []
    if str[2] == "["
      while str[2] == "["
        index = str.index("]")
        delimitters << str[3...index]
        str.sub!(str[2..index], "")
      end
    else
    	delimitters << str[2]
    end
    delimitters
  end
end