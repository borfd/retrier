require 'retrier'

class MyCustomTestException < RuntimeError; end
class MyCustomTestExceptionB < RuntimeError; end

describe Retrier do

  let(:max_tries) { 4 }

  it "runs only once if there is no exception" do
    dbl = double
    dbl.should_receive(:test_this).exactly(1).times

    Retrier.new do
      dbl.test_this
    end
  end

  it "retries the given number of times" do
    tries = 0
    dbl = double
    dbl.should_receive(:test_this).exactly(max_tries).times

    Retrier.new(max_tries: max_tries) do |attempts|
      tries += 1
      dbl.test_this
      fail StandardError unless tries == max_tries
    end

  end

  it "doesn't catch an exception which isn't passed" do
    expect {
      Retrier.new(rescue: MyCustomTestException) do
        fail MyCustomTestExceptionB
      end
    }.to raise_error(MyCustomTestExceptionB)
  end

  context "with registered exception handlers" do
    let(:dbl) { double }
    let(:handlers) do
      {
        MyCustomTestException: -> (ex) {
          dbl.my_custom_exception_raised
        },
        MyCustomTestExceptionB: -> (ex) {
          dbl.this_should_not_happen
        },
        StandardError: -> (ex) {
          dbl.this_should_not_happen
        }
      }
    end

    it "rescues exception and calls appropriate handler" do
      dbl.should_receive(:my_custom_exception_raised)
      dbl.should_not_receive(:this_should_not_happen)

      Retrier.new(handlers: handlers) do
        raise MyCustomTestException
      end
    end

  end
end
