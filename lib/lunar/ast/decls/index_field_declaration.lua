local SyntaxKind = require("lunar.ast.syntax_kind")
local SyntaxNode = require("lunar.ast.syntax_node")
local IndexFieldDeclaration = setmetatable({}, {
  __index = SyntaxNode,
})
IndexFieldDeclaration.__index = setmetatable({}, SyntaxNode)
function IndexFieldDeclaration.new(key, value)
  return IndexFieldDeclaration.constructor(setmetatable({}, IndexFieldDeclaration), key, value)
end
function IndexFieldDeclaration.constructor(self, key, value)
  SyntaxNode.constructor(self, SyntaxKind.index_field_declaration)
  self.key = key
  self.value = value
  return self
end
return IndexFieldDeclaration
