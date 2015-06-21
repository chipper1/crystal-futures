# An ExecutionContext can execute program logic
# asynchronously
# Include this module in a class to implement
#
# A block can be passed to the exec method to
# execute it asynchronously
module ExecutionContext
  # Runs a block of code on this execution context
  abstract def execute(&block)

  # Overload for execute that takes an object with
  # a call method
  def execute(callable)
    self.execute do
      callable.call
    end
  end
end

# Implements `ExecutionContext`. Every call to `execute`
# spawns a new Fiber
class InfiniteFiberExecutionContext
  include ExecutionContext

  def execute(&block)
    spawn do
      block.call
    end
  end
end