pact_examples
=============

Simple [Pact](https://github.com/uglyog/pact) examples.

Run a consumer spec and generate a pact file under spec/pacts

    bundle exec rspec spec/time_consumer_spec.rb
  
Verify that the producer honours the newly generated pact

    bundle exec rake pact:verify
