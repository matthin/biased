# Biased
[![Build Status](https://travis-ci.org/matthin/biased.png?branch=master)]
(https://travis-ci.org/matthin/biased)
[![Gem Version](https://badge.fury.io/rb/biased.png)]
(http://badge.fury.io/rb/biased)
[![Coverage Status](https://coveralls.io/repos/matthin/biased/badge.svg)]
(https://coveralls.io/r/matthin/biased)
[![Inch Status](https://inch-ci.org/github/matthin/biased.svg?branch=master)]
(https://inch-ci.org/github/matthin/biased/branch/master)

# Usage
To run from the command line, use: `biased example.com`

# Code Example
```ruby
require "biased"

puts Biased::Client.new("huffingtonpost.com").has_bias
```
# Contributors
Requirements:

* Ruby v2.0+
* Bundler (`gem install bundler`)

To setup all the required gems, just run `bundle install`.
You may need to also run `rbenv rehash` if you're using
[rbenv](https://github.com/sstephenson/rbenv).

To run tests, use: `rake spec`

