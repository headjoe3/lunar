local AST = require "lunar.ast"
local Lexer = require "lunar.compiler.lexical.lexer"
local Parser = require "lunar.compiler.syntax.parser"

describe("Parser:parse_expression", function()
  describe("LiteralExpression syntax", function()
    it("should return one NilLiteralExpression node", function()
      local tokens = Lexer.new("nil"):tokenize()
      local ast = Parser.new(tokens):parse_expression()

      assert.same(AST.NilLiteralExpression.new(), ast)
    end)

    it("should return one BooleanLiteralExpression node given a value of true", function()
      local tokens = Lexer.new("true"):tokenize()
      local ast = Parser.new(tokens):parse_expression()

      assert.same(AST.BooleanLiteralExpression.new(true), ast)
    end)

    it("should return one BooleanLiteralExpression node given a value of false", function()
      local tokens = Lexer.new("false"):tokenize()
      local ast = Parser.new(tokens):parse_expression()

      assert.same(AST.BooleanLiteralExpression.new(false), ast)
    end)

    it("should return one NumberLiteralExpression node given a value of 100", function()
      local tokens = Lexer.new("100"):tokenize()
      local ast = Parser.new(tokens):parse_expression()

      assert.same(AST.NumberLiteralExpression.new(100), ast)
    end)

    it("should return one StringLiteralExpression node given a string value", function()
      local tokens = Lexer.new("'Hello, world!'"):tokenize()
      local ast = Parser.new(tokens):parse_expression()

      assert.same(AST.StringLiteralExpression.new("'Hello, world!'"), ast)
    end)
  end)

  describe("ExpressionList syntax", function()
    it("should return one ExpressionList with two expression nodes", function()
      local tokens = Lexer.new("1, 2"):tokenize()
      local ast = Parser.new(tokens):parse_expression_list()

      assert.same(AST.ExpressionList.new(AST.NumberLiteralExpression.new(1), AST.NumberLiteralExpression.new(2)), ast)
    end)
  end)
end)
