# references: 
#   http://ruby-doc.org/core-2.2.0/BasicObject.html#method-i-singleton_method_added
#
# List of hooks
# - inherited
# - included
# - prepended
# - extended
# - extend_object
# - method_added

module Hooks
  class << self
    private
    def show_info(method, clz)
      puts "Hooks##{method} called for #{clz}"
    end

    public
    %i[inherited included prepended extended extend_object method_added singleton_method_added singleton_method_removed singleton_method_undefined].each do |method_name|
      define_method method_name do |*var|
        show_info(__method__, var)
      end
    end
  end
end

class B
  extend Hooks

  def self.m
    puts 'B#m'
  end

  def m
    puts 'B#m'
  end
end

class B
  def self.a
    puts 'B#m'
  end

  def a
    puts 'B#m'
  end
end

class A
end

a = A.new
a.extend Hooks


module Chatty
  def self.method_added(method_name)
    puts "Adding #{method_name.inspect}"
  end

  def self.singleton_method_added(method_name)
    puts "Adding Singleton method #{method_name.inspect}"
  end

  def self.some_class_method() end
  def some_instance_method() end
end
