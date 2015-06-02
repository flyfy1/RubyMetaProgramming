module Overrider
  def self.included(clz)
    clz.extend ClassMethods
  end

  module ClassMethods
    [[:method_added,:instance_method],[:singleton_method_added,:singleton_method]].each do |mname,method_getter|
      variable_name = ":@_methods_for_#{mname}"

      eval(<<METHOD_BODY,binding,__FILE__,__LINE__)
        def #{mname}(method_name)
          m = #{method_getter}(method_name)
          return if m.arity < 0

          instance_variable_set(#{variable_name},Hash.new {|h,k| h[k] = {}}) unless instance_variable_defined?(#{variable_name})
          methods = instance_variable_get(#{variable_name})[method_name]
          methods[m.arity] = m

          define_method method_name do |*args,&blk|
            methods.each do |arity,m|
              if args.length == arity
                return m.bind(self)[*args,&blk]
              end
            end

            raise ArgumentError
          end
        end
METHOD_BODY
    end

=begin
    def method_added(method_name)
      m = instance_method(method_name)
      return if m.arity < 0

      instance_variable_set(:@_methods,Hash.new {|h,k| h[k] = {}}) unless instance_variable_defined?(:@_methods)
      methods = instance_variable_get(:@_methods)[method_name]
      methods[m.arity] = m

      define_method method_name do |*args,&blk|
        methods.each do |arity,m|
          if args.length == arity
            return m.bind(self)[*args,&blk]
          end
        end

        raise ArgumentError
      end
    end
=end
  end
end

class A
  include Overrider

  def m1(a,b)
    puts "A#m1(#{a},#{b})"
  end

  def m1(a,b,c)
    puts "A#m1(#{a},#{b},#{c})"
  end

  class << self 
    def m2(a,b)
      puts "A#m2(#{a},#{b})"
    end

    def m2(a,b,c)
      puts "A#m2(#{a},#{b},#{c})"
    end
  end
end

A.new.m1(1,2,3)
A.new.m1(1,2)
A.new.m1(1,2,4)

# A.m2(2,3)
