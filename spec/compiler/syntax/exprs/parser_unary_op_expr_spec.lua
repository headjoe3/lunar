local require_dev = require "spec.helpers.require_dev"

describe("UnaryOpExpression syntax", function()
  require_dev()

  it("should return an UnaryOpExpression node whose operand is BooleanLiteralExpression and operator is not_op", function()
    local tokens = Lexer.new("not false"):tokenize()
    local result = Parser.new(tokens):expression()

    local operator = AST.UnaryOpKind.not_op
    local operand = AST.BooleanLiteralExpression.new(false)

    assert.same(AST.UnaryOpExpression.new(operator, operand), result)
  end)

  it("should return an UnaryOpExpression node whose operand is NumberLiteralExpression and operator is negative_op", function()
    local tokens = Lexer.new("-1"):tokenize()
    local result = Parser.new(tokens):expression()

    local operator = AST.UnaryOpKind.negative_op
    local operand = AST.NumberLiteralExpression.new(1)

    assert.same(AST.UnaryOpExpression.new(operator, operand), result)
  end)

  it("should return an UnaryOpExpression node whose operand is TableLiteralExpression and operator is length_op", function()
    local tokens = Lexer.new("#{}"):tokenize()
    local result = Parser.new(tokens):expression()

    local operator = AST.UnaryOpKind.length_op
    local operand = AST.TableLiteralExpression.new({})

    assert.same(AST.UnaryOpExpression.new(operator, operand), result)
  end)
end)
