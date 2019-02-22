local require_dev = require "spec.helpers.require_dev"

describe("WhileStatement transpilation", function()
  require_dev()

  it("should support while loops calling 'test' 5 times and 'test_was_ran' 4 times", function()
    local input = "while test() do test_was_ran() end"

    local tokens = Lexer.new(input):tokenize()
    local ast = Parser.new(tokens):parse()
    local result = Transpiler.new(ast):transpile()

    local n = 0
    local test = spy.new(function()
      n = n + 1
      return n < 5
    end)
    local test_was_ran = spy.new(function() end)

    local env = Environment.new(result, {
      test = test,
      test_was_ran = test_was_ran
    }):run()

    assert.equal(n, 5)
    assert.spy(test).was.called(5)
    assert.spy(test_was_ran).was.called(4)
  end)
end)