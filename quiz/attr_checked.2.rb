require 'rspec'

class Validation < Exception; end

module CheckedAttributes  
  def self.included(clz) 
    clz.extend ClassMethods
  end

  module ClassMethods
    def attr_checked(attr, &validation)
      define_method "#{attr}=" do |v|
        raise Validation unless validation.call(v)
        instance_variable_set("@#{attr}",v)
      end

      define_method attr do
        instance_variable_get("@#{attr}")
      end
    end
  end
end


class Person
  include CheckedAttributes
  attr_checked(:age) {|n| n > 10}
end

p = Person.new

RSpec.describe Person do
  me = Person.new

  it 'should allow age above 10' do
    me.age = 39
    expect(me.age).to eq 39
  end

  it 'should not allow age above 10' do
    expect{ me.age = 4}.to raise_error(Validation)
  end
end
me = Person.new
me.age = 12 # Exception
