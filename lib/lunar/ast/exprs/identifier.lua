local SyntaxKind = require "lunar.ast.syntax_kind"
local SyntaxNode = require "lunar.ast.syntax_node"

local Identifier = setmetatable({}, SyntaxNode)
Identifier.__index = Identifier

function Identifier.new(name, type_annotation)
  local super = SyntaxNode.new(SyntaxKind.identifier)
  local self = setmetatable(super, Identifier)
  self.name = name
  self.type_annotation = type_annotation

  self.symbol = nil -- Symbol | nil - The symbol corresponding to this identifier, initialized in binding

  return self
end

return Identifier