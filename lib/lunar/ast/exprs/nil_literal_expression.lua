local SyntaxKind = require("lunar.ast.syntax_kind")
local SyntaxNode = require("lunar.ast.syntax_node")
local NilLiteralExpression = setmetatable({}, {
  __index = SyntaxNode,
})
NilLiteralExpression.__index = setmetatable({}, SyntaxNode)
function NilLiteralExpression.new()
  return NilLiteralExpression.constructor(setmetatable({}, NilLiteralExpression))
end
function NilLiteralExpression.constructor(self)
  SyntaxNode.constructor(self, SyntaxKind.nil_literal_expression)
  return self
end
return NilLiteralExpression
