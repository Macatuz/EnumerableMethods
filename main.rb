module Enumerable
  def my_each
    if self.respond_to?(:keys)
      for i in 0..self.keys.length - 1
        yield(self[self.keys[i]])
      end
    else
      for i in 0..self.count - 1
        yield(self[i], i)
      end
    end
  end

  def my_each_with_index
    if self.respond_to?(:keys)
      for i in 0..self.keys.length - 1
        yield(self.keys[i], self[self.keys[i]])
      end
    else
      for i in 0..self.count - 1
        yield(self[i], i)
      end
    end
  end

  def my_select
  end

  def my_all
  end

  def my_any
  end

  def my_none
  end

  def my_count
  end

  def my_map
  end

  def my_inject
  end
end

class Array
  include Enumerable
end

class Hash
  include Enumerable
end

x = Array.new
x[0] = "asd"
x[1] = "ee"
x[2] = "qwe"
x.my_each do |value|
  p "#{value} #{index}"
end
