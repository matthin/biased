# Biased
[![Build Status](https://travis-ci.org/matthin/biased.png?branch=master)]
(https://travis-ci.org/matthin/biased)
[![Gem Version](https://badge.fury.io/rb/biased.png)]
(http://badge.fury.io/rb/biased)

# Usage
To run from the command line, use: `biased example.com`

# Code Example
```
require "biased"

puts Biased::Client.new("huffingtonpost.com").parent
```
# Developers
To run tests, use: `rake spec`

