# This defines a really simple API for interfacing with search operations.
#
# This is indeed simple... I wanted it to be simple... so I made it simple. So.. SIMPLE!
class SearchOperators

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
  def initialize(query)
    query = query.to_s
    @operators = {}

    offset = 0
    while m = OPERATOR_EXPRESSION.match(query, offset)
      key = m[1].downcase
      value = m[2]
      offset = m.end(2)
      @operators[key] ||= []
      @operators[key] << value
    end
    @freetext = query[offset, query.length]
  end

  # yield the value of the given operator to each of the contained elements.
  def keyword(key, expects=:string)
    return if @operator[key].nil?
    @operator[key].each do |value|
      yield(convert(value, expects)
    end
  end

  # yield the block if there is data in the given block
  def as_array(key, expects=:string)
    res=[]
    operator(key, expects) { res << & }
    yield(res) if res.count > 0
  end

  def freetext(expects=:string)
    yield(convert(@freetext, expects))
  end


  protected
    OPERATOR_EXPRESSION = /(\w+):[\ 　]?([\w\p{Han}\p{Katakana}\p{Hiragana}\p{Hangul}ー,]+|"(?:(?!").)+"|'(?(?!').).+')/
    #                      1             2                                                3             4  
    # About this regexp:
    #   1. looks for word character (english word basically, plus _ and numbers - might catch others)
    #      the : must be right after.. or else fails.... and after : might have one space (en or ja)
    #   2. then look for word characters.. supporting Japanese, Korean, Chinese and latin alphabet plus numbers and such
    #      also support ',' for you cool kids that expect something like a "list of ids"
    #   3. optionally the value might be between " or
    #   4. '


    def convert(value, expects)
      case expects
      when :string
        return value
      when :integer
        return value.to_i
      end
    end
end
