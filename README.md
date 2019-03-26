![Travis](https://travis-ci.org/paktek123/elasticsearch-crystal.svg?branch=master)

# Elasticsearch-crystal

Elasticsearch Library for Crystal Lang. Heavily inspired by Ruby Elasticsearch Library and forked from [https://github.com/paktek123/elasticsearch-crystal](https://github.com/paktek123/elasticsearch-crystal) to make it work with Elasticsearch 6.x.

## Installation

```
dependencies:
  elasticsearch-crystal:
    github: amauryt/elasticsearch-crystal
    version: ~> 0.14
```

## Usage

```
require "elasticsearch-crystal/elasticsearch/api"

client = Elasticsearch::API::Client.new({:host => "localhost", :port => 9250})

# create an index
client.indices.create({:index => "test_index", :body => {"mappings" => {"type_1" => {} of String => String}}})
client.cat.indices

# To get back JSON

client.cat.indices({:format => "json"}).as(JSON::Any)
```

For more examples see the `spec` directory

## Roadmap

Right now this covers most of the Elasticsearch API, but still lacks certain features.
- Make the repo more 'Crystal' Lang style, it follows ruby conventions or no conventions at all right now.
- Code is a bit repetitive in places
- Same functionality as the Ruby Elasticsearch Library

## Issues and Bugs

Although there is a test suite of Elasticsearch there are bound to be many bugs. Please raise an issue with steps to reproduce and any stack traces. Contributions are welcome for fixes.

## Contribute

Contributions are welcome!

- Run a local Elasticsearch on port 9250: `docker run -d -p 9250:9200 elasticsearch:6.6.2`

- Run the all the specs `crystal spec`

- Run the specs you are interested in `crystal spec spec/integation/cat/`

- Fork the repo and work on your feature in a branch

- Make a PR
