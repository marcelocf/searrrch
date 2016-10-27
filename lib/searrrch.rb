# frozen_string_literal: true
# This defines a really simple API for interfacing with search operations.
#
# This is indeed simple... I wanted it to be simple... so I made it simple. So.. SIMPLE!
class Searrrch
  OPERATOR_EXPRESSION = /(\w+):[\ 　]?([\w\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}ー,]+|(["'])(\\?.)*?\3)/
  #                      1             2                                                 3
  # About this regexp:
  #   1. looks for word character (english word basically, plus _ and numbers - might catch others)
  #      the : must be right after.. or else fails.... and after : might have one space (en or ja)
  #   2. then look for word characters.. supporting Japanese, Korean, Chinese and latin alphabet plus numbers and such
  #      also support ',' for you cool kids that expect something like a "list of ids"
  #   3. and also accept any char if quoted - in which case the same quotation should be quoted as well

  VERSION = '0.0.5'

  # iterates over the entire string identifying each of the elements
  # this code only checks for:
  #   1. simple spaces
  #   2. japanese spaces
  #   3. : char
  #
  # All other chars are treated as normal char.
  #
  # Both key and value must have only the other regular chars.
  #
  # Everything after the last option will be considered free text search
  def initialize(query, explode_comma=false)
    query = query.to_s
    @operators = {}

    offset = 0
    while m = OPERATOR_EXPRESSION.match(query, offset)
      key = m[1].downcase.to_sym
      value = m[2]
      value = value[1, value.length - 2] if ["'", '"'].include?(value[0])
      offset = m.end(2)
      @operators[key] ||= []

      if explode_comma
        value.split(',').each{ |v| @operators[key] << v }
      else
        @operators[key] << value
      end
    end
    @freetext = query[offset, query.length].strip
  end

  # yield the value of the given operator to each of the contained elements.
  def each_value(key, expects = :string)
    return if @operators[key.to_sym].nil?
    @operators[key.to_sym].each do |value|
      yield(convert(value, expects))
    end
  end

  # yield the block if there is data in the given block
  def to_array(key, expects = :string)
    res = []
    each_value(key, expects) { |v| res << v }
    res
  end

  # Same as to_array, but yield the value of the array to a block if a value is
  # found
  def as_array(key, expects = :string)
    arr =to_array(key, expects)
    yield arr if arr.length > 0
  end

  def freetext(expects = :string)
    convert(@freetext, expects)
  end

  protected

  def convert(value, expects)
    value = value.gsub(/\\(.)/, '\1')
    case expects
    when :string
      return value
    when :integer
      return value.to_i
    end

    if expects.is_a?(Hash)
      return expects[value] if expects.has_key?(value)
      return expects[value.to_sym] if expects.has_key?(value.to_sym)
    else
      return expects.find(value) if defined? expects.find
    end
  end
end
