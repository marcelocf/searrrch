# search_operators
Implements a simple parser for search strings using **key:value**.


The following search string is supported:

```
user_id: 123 user_name: omg user_id: 124 free text here
```


Usage:

```ruby

search = SearchOperators.new query
search.operator('user_id', :integer) do |val|
  # this block will be called twice with val being set to '123' and '124'
end

search.as_array('user_id') do |arr|
  # this block will be called once, with an array of strings ['123', '124']
end


search.freetext do |txt|
  # this block is called with the remaining text
end
```

This is particular useful for appending search criteria to your rails query ;)

You can see all the available methods by reading the tiny source code. :D

Each method supports a 2nd optional parameter indicating the expected format of the field. Valid options are:

* :string (default)
* :integer
* rails model (well, anything with `.find` method)

## Installing

```bash
gem install search_operators
```

## Contributing

Contributors are welcome! Do the standard pull request stuff.

This project is setup to support `rvm`, but any system with bundler should work:

```#bash
gem install bundler
bundler install
rake # this run tests
```
