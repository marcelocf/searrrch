# search_operators
Implements a simple parser for search strings using **key:value** and **#hashtag** syntax.


The following search string is supported:

```
user_id: 123 user_name: omg user_id: 124 #hashtag free text here
```


Usage:

```ruby
SearchOperators.parse(query) do |search|

  search.keyword('user_id') do |val|
    # this block will be called twice with val being set to '123' and '124'
  end

  search.as_array('user_id') do |arr|
    # this block will be called once, with an array of strings ['123', '124']
  end


  search.hashtags do |hashtag|
    # for any word with hashtag this block will be called; hashtag can be anywhere,
    # even in the middle of the freetext block
  end

  search.free_text do |txt|
    # this block is called with the remaining text
  do
end
```

This is particular useful for appending search criteria to your rails query ;)
