# searrch
Allow you to receive a query string using the syntax similar to gmail's filters
and parse it without going crazy.

The following search string is supported:

```
user_id: 123 user_name: omg user_id: 124 free text here
```

The user can also put the value between quotes and escape spaces.

Usage:

```ruby

search = Searrrch.new query
search.each_value('user_id', :integer) do |val|
  # this block will be called twice with val being set to '123' and '124'
end

# this return all values from user_id in an array
search.to_array('user_id') 

# this returns the remaining text
search.freetext
```

This is particular useful for appending search criteria to your rails query ;)

You can see all the available methods by reading the tiny source code. :D

Each method supports a 2nd optional parameter indicating the expected format of the field. Valid options are:

* :string (default)
* :integer
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
