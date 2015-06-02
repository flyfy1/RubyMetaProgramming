module M
  def self.append_features(base)
    puts 'appending features'
  end
end

class A
  include M
end

p A.ancestors
