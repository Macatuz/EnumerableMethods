module Enumerable
  def my_each(&block)
    if self.respond_to?(:keys) && block_given?
      for i in 0..self.keys.length - 1
        if block.arity === 2
          yield(self.keys[i].to_sym, self[self.keys[i]])
        else
          yield([self.keys[i].to_sym, self[self.keys[i]]])
        end
      end
    elsif block_given?
      for i in 0..self.count - 1
        yield(self[i], i)
      end
    end
  end

  def my_each_with_index(&block)
    if self.respond_to?(:keys) && block_given?
      for i in 0..self.keys.length - 1
        if block.arity === 2
          yield([self.keys[i], self[self.keys[i]]], i)
        else
          yield([self.keys[i].to_sym, self[self.keys[i]]])
        end
      end
    elsif block_given?
      for i in 0..self.count - 1
        yield(self[i], i)
      end
    end
  end

  def my_select
    if self.respond_to?(:keys) && block_given?
      result = Hash.new
      for i in 0..self.keys.length - 1
        if yield(self.keys[i], self[self.keys[i]]) then result[self.keys[i]] = self[self.keys[i]] end
      end
    elsif block_given?
      result = Array.new
      for i in 0..self.count - 1
        if yield(self[i]) then result.push(self[i]) end
      end
    end
    return result
  end

  def my_all?
    result = true
    if self.respond_to?(:keys) && block_given?
      result = Hash.new
      for i in 0..self.keys.length - 1
        result = false if !yield(self.keys[i].to_sym, self[self.keys[i]])
        break if !yield(self.keys[i].to_sym, self[self.keys[i]])
      end
    elsif block_given?
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

    if self.respond_to?(:keys) && block_given?
      result = Hash.new
      for i in 0..self.keys.length - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    elsif block_given?
      result = Array.new
      for i in 0..self.count - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    end
    return result
  end

  def my_none?
    result = false
    if self.respond_to?(:keys) && block_given?
      for i in 0..self.keys.length - 1
        result = false if !yield(i)
        break if !yield(i)
      end
    elsif block_given?
      for i in 0..self.count - 1
        result = true if yield(self[i])
        break if yield(self[i])
      end
    end
    return !result
  end

  def my_count
    if self.respond_to?(:keys)
      self.keys.length
    else
      self.count
    end
  end

  def my_map
    if self.respond_to?(:keys) && block_given?
      result = Array.new
      for i in 0..self.keys.length - 1
        result[i] = yield(self.keys[i], self[self.keys[i]])
      end
      result
    elsif block_given?
      for i in 0..self.count - 1
        self[i] = yield(self[i])
      end
      self
    end
  end

  def my_inject
    if self.respond_to?(:keys) && block_given?
      raise "expected Array, got Hash"
    elsif block_given?
      result = self[0]
      for i in 1..self.count - 1
        result = yield(result, self[i])
      end
    end
    return result
  end
end

def multiply_els(arr)
  arr.inject { |sum, n| sum * n }
end

testhash = {
  "a" => 1,
  "b" => 2,
  "c" => 3,

}
print "\nBEGIN HASH TESTING\n\n"
testhash.each { |key, value| p "key: #{key} => value #{value}" }
testhash.my_each { |key, value| p "key: #{key} => value #{value}" }
print "\n"
testhash.each_with_index { |key, value| p "key: #{key} => value #{value}" }
testhash.my_each_with_index { |key, value| p "key: #{key} => value #{value}" }
print "\n"
p testhash.select { |key, value| value > 1 }
p testhash.my_select { |key, value| value > 1 }
print "\n"
p testhash.all? { |key, value| value > 1 }
p testhash.my_all? { |key, value| value > 1 }
print "\n"
p testhash.count
p testhash.my_count

print "\n"
p testhash.map { |key, value| value * value }
p testhash.my_map { |key, value| value * value }

print "\n"
p [2, 4, 5].inject { |sum, value| sum * value }
p multiply_els([2, 4, 5])

print "\nEND HASH TESTING\n\n\n"

testarray = [1, 2, 3, 4]
print "\nBEGIN ARRAY TESTING\n"
print "\n"
testarray.each { |value| p "value #{value}" }
testarray.my_each { |value| p "value #{value}" }

print "\n"
testarray.each_with_index { |value| p "value #{value}" }
testarray.my_each_with_index { |value| p "value #{value}" }

print "\n"
p testarray.select { |value| value > 1 }
p testarray.my_select { |value| value > 1 }

print "\n"
p testarray.all? { |value| value > 1 }
p testarray.my_all? { |value| value > 1 }

print "\n"
p testarray.none? { |value| value > 1 }
p testarray.my_none? { |value| value > 1 }

print "\n"
p testarray.count
p testarray.my_count

print "\n"
p testarray.map { |n| n * n }
p testarray.my_map { |n| n * n }

print "\n"
p testarray.inject { |sum, n| sum + n }
p testarray.my_inject { |sum, n| sum + n }

print "\n"
p [2, 4, 5].inject { |sum, n| sum * n }
p multiply_els([2, 4, 5])

print "\nEND ARRAY TESTING\n"
