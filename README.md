# Blueprint Agreement

[![Build Status](https://travis-ci.org/charly-palencia/blueprint-agreement.svg?branch=master)](https://travis-ci.org/charly-palencia/blueprint-agreement)
[![Code Climate](https://codeclimate.com/github/charly-palencia/blueprint-agreement/badges/gpa.svg)](https://codeclimate.com/github/charly-palencia/blueprint-agreement)

A Minitest API Documentation Matcher based on ApiBluePrint schema.

Note: This Gem Is Currently on Development. 

## Description

- A ruby library for Validate API Blueprint Documentation
- Support MiniTest Assertion and Spec format
- Use drakov node library to serve Mock API server


## Getting Started

Add this line to your application's Gemfile:

    gem 'blueprint-agreement'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install agreement

*MiniTest*

```ruby
require 'blueprint_agreement'
```

## Usage

### Quick Start

Blueprint agreement works based on a markdown file with an valid API Blueprint format. Add your file into `/docs` folder in your project root folder (or set your custom documentation folder)

./docs/test.md

```
FORMAT: 1A

# The Simplest API
 
## API Blueprint
 
# GET /message
+ Request  200 (application/json)
+ Response 200 (application/json)
    
    + Body

            {
              'name': 'Hello World'
            }

```

Then, test your documentation:

``` ruby 

describe Test do
  it 'has a valid response' do
    get :index
    response.shall_agree_with('test.md')
  end
end
```
### Debug Mode

use a env variable calls `AGREEMENT_LOUD`

``` bash
  $ AGREEMENT_LOUD=true rake test
``` 

Output:

``` bash
...Drakov server output...
[DRAKOV] GET /message example

          Method: GET
          Path: http://localhost:8082/message

          Details

          Headers:

           
            Content-Type=application/json
            Authorization=Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.example

          Body:
          
            {"param_1": "hi"}
        

```
### Config File 

/config/initializer/blueprint_agreement.rb

``` ruby
BlueprintAgreement::Config.port = '8081' #Default port for Drakov Server
BlueprintAgreement::Config.server_path= './docs' #Default server path for Drakov Server
```


## Contributing

1. Fork it ( http://github.com/charly-palencia/agreement/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
