local Symbol = {}
Symbol.__index = {}
function Symbol.new(name)
  return Symbol.constructor(setmetatable({}, Symbol), name)
end
function Symbol.constructor(self, name)
  self.assignment_references = {}
  self.references = {}
  self.declarations = {}
  self.declaration_references = {}
  self.builtin = false
  self.name = name
  return self
end
function Symbol.__index:is_builtin()
  return self.builtin
end
function Symbol.__index:is_assigned()
  return (#self.assignment_references) > 0
end
function Symbol.__index:is_declared()
  return (#self.declarations) > 0
end
function Symbol.__index:is_redeclared()
  return (#self.declarations) > 1
end
function Symbol.__index:get_canonical_declaration()
  return self.declarations[1]
end
function Symbol.__index:is_referenced()
  return (#self.references) > 0
end
function Symbol.__index:bind_as_builtin()
  self.builtin = true
end
function Symbol.__index:bind_declaration_reference(ident_or_varargs, declaration)
  local refs = self.declaration_references
  refs[(#refs) + 1] = ident_or_varargs
  ident_or_varargs.symbol = self
  local decls = self.declarations
  decls[(#decls) + 1] = declaration
end
function Symbol.__index:bind_declaration(declaration)
  local decls = self.declarations
  decls[(#decls) + 1] = declaration
end
function Symbol.__index:bind_reference(ident_or_varargs)
  local refs = self.references
  refs[(#refs) + 1] = ident_or_varargs
  ident_or_varargs.symbol = self
end
function Symbol.__index:bind_assignment_reference(ident_or_varargs)
  local refs = self.assignment_references
  refs[(#refs) + 1] = ident_or_varargs
  ident_or_varargs.symbol = self
end
function Symbol.__index:merge_into(new_symbol)
  for _, k in pairs({
    "references",
    "declarations",
    "declaration_references",
    "assignment_references",
  }) do
    local nodes = self[k]
    local other_nodes = new_symbol[k]
    for i = 1, (#nodes) do
      local node = nodes[i]
      if node.symbol == self then
        node.symbol = new_symbol
      end
      other_nodes[(#other_nodes) + 1] = node
    end
  end
end
function Symbol.__index:__tostring()
  return "Symbol ('" .. tostring(self.name) .. "')"
end
return Symbol
