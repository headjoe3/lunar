local SyntaxKind = require("lunar.ast.syntax_kind")
local SyntaxNode = require("lunar.ast.syntax_node")
local Identifier = setmetatable({}, {
  __index = SyntaxNode,
})
Identifier.__index = setmetatable({}, SyntaxNode)
function Identifier.new(name, type_annotation)
  return Identifier.constructor(setmetatable({}, Identifier), name, type_annotation)
end
function Identifier.constructor(self, name, type_annotation)
  SyntaxNode.constructor(self, SyntaxKind.identifier)
  self.name = name
  self.type_annotation = type_annotation
  return self
end
return Identifier
