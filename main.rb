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
    if self.respond_to?(:keys)
      result = Hash.new
      for i in 0..self.keys.length - 1
        if yield(self[self.keys[i]]) then result[self.keys[i]] = self[self.keys[i]] end
      end
    else
      result = Array.new
      for i in 0..self.count - 1
        if yield(self[i]) then result.push(self[i]) end
      end
    end
    return result
  end

  def my_all
    result = true
    if self.respond_to?(:keys)
      result = Hash.new
      for i in 0..self.keys.length - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    else
      result = Array.new
      for i in 0..self.count - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    end
    return result
  end

  def my_any
    result = true
    if self.respond_to?(:keys)
      result = Hash.new
      for i in 0..self.keys.length - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    else
      result = Array.new
      for i in 0..self.count - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    end
    return result
  end

  def my_none
    result = true
    if self.respond_to?(:keys)
      result = Hash.new
      for i in 0..self.keys.length - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    else
      result = Array.new
      for i in 0..self.count - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    end
    return !result
  end

  def my_count
    if self.respond_to?(:keys)
      return self.keys.length
    else
      return self.count
    end
    return result
  end

  def my_map
    if self.respond_to?(:keys)
      for i in 0..self.keys.length - 1
        self[self.keys[i]] = yield(self[self.keys[i]])
      end
    else
      for i in 0..self.count - 1
        self[i] = yield(self[i])
      end
    end
  end

  def my_inject
    if self.respond_to?(:keys)
      result = self[self.keys[0]]
      for i in 1..self.keys.length - 1
        result = yield(result, self[self.keys[i]])
      end
    else
      result = self[0]
      for i in 1..self.count - 1
        result = yield(result, self[i])
      end
    end
    return result
  end
end

class Array
  include Enumerable
end

class Hash
  include Enumerable
end

[1, 2, 3, 4, 5].my_each do |value| p value end
asd = [1, 2, 3, 4, 5].my_select do |value| value > 2 end
p asd
p (5..10).inject { |sum, n| sum + n }
