module ActiveSupport
  module Concern
    def self.extended(base)
      base.instance_variable_set(:@_dependencies, [])
    end

    def append_features(base)
      if base.instance_variable_defined?(:@_dependencies)
        # puts "including a concern, base = #{base}, self = #{self}"
        base.instance_variable_get(:@_dependencies) << self
        # puts "@_dependencies = #{base.instance_variable_get(:@_dependencies)}"
        return false
      else
        return false if base < self
        @_dependencies.each {|dep| base.include(dep)}
        super
        base.extend const_get(:ClassMethods) if const_defined?(:ClassMethods)
      end
    end
  end
end

module SecondLevel
  extend ActiveSupport::Concern

  def sec_lvl_instance_method; '2nd level method'; end

  module ClassMethods
    def sec_lvl_class_method; '2nd level class method'; end
  end
end

module FirstLevel
  extend ActiveSupport::Concern

  def first_lvl_instance_method; '1st level instance method'; end

  module ClassMethods
    def first_lvl_class_method; '1st level class method'; end
  end

  include SecondLevel
end

class MyClass
  include FirstLevel
end

p MyClass.new.first_lvl_instance_method
p MyClass.first_lvl_class_method

p MyClass.new.sec_lvl_instance_method
p MyClass.sec_lvl_class_method
