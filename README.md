# SmartFixtures

You can define a Test Dataset in a free-form.
Defined data set is useable at any time in your unit test files.

Currently, This tool only supports RSpec.

## What's this?

```
$ vim spec/smart_fixtures/product_master.rb

# in spec/smart_fixtures/product_master.rb
# defining dataset using FactoryGirl

SmartFixtures.define_dataset :product_master do
  100.times do |i|
    FactoryGirl.create(:product, name: "DummyProduct#{i}", availability: false)
  end

  let(:available_product) do
    FactoryGirl.create(:product, name: 'ValidProduct', availability: true)
  end
end
```

```
$ vim spec/search/product.rb

# in spec/model/product.rb

describe Product do
  # load product_master dataset
  smart_fixtures :product_master

  # loadable multiple fixtures like ...
  # smart_fixtures :product_master, :other_dataset1, :other_dataset2 ...

  describe 'Your test case' do
    it do
      expect(Product.count).to be > 100

      # fetch available_product variable in product_master dataset
      product = SmartFixtures.data(:product_master, :available_product)
      expect(product.name).to eq("ValidProduct")
    end
  end
end
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smart_fixtures'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smart_fixtures

## Contributing

1. Fork it ( https://github.com/[my-github-username]/smart_fixtures/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
