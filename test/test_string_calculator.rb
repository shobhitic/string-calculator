require 'test/unit'

require 'string_calculator'

class TestStringCalculator < Test::Unit::TestCase

  def test_add_returns_zero_for_empty_string
    assert_equal 0, StringCalculator.add("")
  end

  def test_add_returns_the_number_itself_for_single_number
    assert_equal 1, StringCalculator.add("1")
    assert_equal 10, StringCalculator.add("10")
    assert_equal 55, StringCalculator.add("55")
  end

  def test_add_returns_sum_for_two_numbers
    assert_equal 9, StringCalculator.add("4,5")
    assert_equal 12, StringCalculator.add("10,2")
    assert_equal 12, StringCalculator.add("2,10")
    assert_equal 45, StringCalculator.add("29,16")
  end

  def test_add_returns_sum_for_more_than_two_numbers
    assert_equal 15, StringCalculator.add("4,5,6")
  end

  def test_add_returns_sum_for_new_line_as_delimitter
    assert_equal 15, StringCalculator.add("9\n6")
    assert_equal 85, StringCalculator.add("9\n6\n70")
  end

  def test_add_returns_sum_for_new_line_and_comma_both_as_delimitter
    assert_equal 20, StringCalculator.add("5,6\n9")
    assert_equal 50, StringCalculator.add("10\n20,20,0")
  end

  def test_add_returns_sum_for_custom_delimitter
    str_one = "//;\n3;4"
    str_two = "//$\n30$44"
    assert_equal 7, StringCalculator.add(str_one)
    assert_equal 74, StringCalculator.add(str_two)
  end

  def test_raise_error_for_negative_numbers
    error = assert_raise(StringCalculator::NegativeGivenError) { StringCalculator.add("1,-1,-3") }
    assert_equal "negatives not allowed: -1, -3", error.message

    error = assert_raise(StringCalculator::NegativeGivenError) { StringCalculator.add "//;\n-2;3;-5" }
    assert_equal "negatives not allowed: -2, -5", error.message
  end

  def test_add_ignores_numbers_greater_than_thousand
    assert_equal 30, StringCalculator.add("10,20,1001,2010")
    assert_equal 30, StringCalculator.add("//;\n10;20;1001;2010")
  end

  def test_add_returns_sum_for_long_custom_delimitter
    assert_equal 42, StringCalculator.add("//[***]\n10***20***12")
    assert_equal 42, StringCalculator.add("//[__]\n10__20__12")
  end

  def test_add_returns_sum_for_multiple_custom_delimitters
    assert_equal 42, StringCalculator.add("//[***][++]\n10++20***12")
    assert_equal 42, StringCalculator.add("//[**][__]\n10**20__12")
  end
end