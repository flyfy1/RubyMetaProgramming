require 'rspec'

class AttributeException < Exception; end

module CheckedAttributes  
  def self.included(clz)
    clz.instance_eval do
      define_singleton_method :attr_checked do |attr,&blk|
        # Approach 1
        clz.class_eval do
          define_method attr do
            instance_variable_get('@'+attr.to_s)
          end

          define_method (attr.to_s+'=') do |v|
            raise AttributeException if v <= 10
            instance_variable_set('@'+attr.to_s, v)
          end
        end

        # Approach 2
      end
    end
  end
end

class Person
  include CheckedAttributes
  attr_checked(:age)
end

# Person.attr_checked(:nani)

RSpec.describe Person do
  me = Person.new

  it 'should allow age above 10' do
    me.age = 39
    expect(me.age).to eq 39
  end

  it 'should not allow age above 10' do
    expect{ me.age = 4}.to raise_error(AttributeException)
  end
end
me = Person.new
me.age = 12 # Exception
