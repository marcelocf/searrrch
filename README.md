# searrrch

[![Build Status](https://travis-ci.org/marcelocf/searrrch.svg?branch=master)](https://travis-ci.org/marcelocf/searrrch)
[![Gem Version](https://badge.fury.io/rb/searrrch.svg)](https://badge.fury.io/rb/searrrch)
![](http://ruby-gem-downloads-badge.herokuapp.com/searrrch?metric=true&color=brightgreen)

Allow you to receive a query string using the syntax similar to gmail's filters
and parse it without going crazy.

The following search string is supported:

```
user_id: 123 user_name: omg user_id: 124 free text here
```

The user can also put the value between quotes, in which case nested escaped quotes are supported.

Usage:

```ruby
search = Searrrch.new 'user_id: 123 user_id: 124 status: new status: closed free text here'
search.each_value(:user_id, :integer) do |val|
  # this block will be called twice with val being set to '123' and '124'
end

# this return all values from user_id in an array
search.to_array(:user_id) 

# next, return [1,2]
search.to_array(:status, { new: 1, closed: 2 })

# or, if you preffer:
search.as_array(:user_id) do |user_ids|
  # this is called once and only if user_id is set
end

# this returns the remaining text
search.freetext


# as a final note, this also works:

search = Searrrch.new 'user_id: 123,124 free text here', true
search.each_value(:user_id, :integer) do |val|
  # the same as previous example; but now every value get cut on ','
end
```

This is particular useful for appending search criteria to your rails query ;)

You can see all the available methods by reading the tiny source code. :D

Each method supports a 2nd optional parameter indicating the expected format of the field. Valid options are:

* :string (default)
* :integer
* hash containing translation of the values - if not found return `nil`
* rails model (well, anything with `.find` method)

## Installing

```bash
gem install searrrch
```

## Contributing

Contributors are welcome! Do the standard pull request stuff.

This project is setup to support `rvm`, but any system with bundler should work:

```#bash
gem install bundler
bundler install
rake # this run tests
```
