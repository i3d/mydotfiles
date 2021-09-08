-- This is a pretty simple function that gets the context and up the
-- tree for the current position.

local ts_utils = require 'nvim-treesitter.ts_utils';

local opts = {}

local targets = {
    'function',
    'method_declaration',
    'function_declaration',
    'function_definition',
    'local_function',
    'arrow_function',
    'method_definition',
    'arguments',

    'if_statement',
    'if_expression',

    'switch_expression',

    'class_declaration',
    'struct_expression',

    'test_expression',

    'while_expression',
    'while_statement',

    'for_expression',
    'foreach_statement',
    'for_statement',
    'for_in_statement',

    -- rust
    'match_expression',
    'if_let_expression',
    'tuple_struct_pattern',
    'while_let_expression',
    'for_expression',
    'function_item',
    'struct_item',
    'mod_item',

    -- ruby target
    'class',
    'module',
    'method',
    'do_block',
    'if',
    'while',
    'for',

    -- typescript
    'interface_declaration',
    'enum_declaration',
    -- lua,
    'local_variable_declaration',
    -- go
    'type_declaration',
    'type_spec',
    'short_var_declaration',
    'defer_statement',
    'expression_switch_statement',
    'composite_literal',
    'element',
    'func_literal',
    'go_statement',
    'select_statement',
    'communication_case',
    'default_case',
}
local M = {}

function M.setup(user_opts)
	opts = vim.tbl_extend('force', opts, user_opts or {})
end

local function setVirtualText(node)
    if vim.tbl_contains(targets, node:type()) then
        local targetLineNumber = node:end_();
        local min_rows = opts.min_rows;
        -- default min_rows == 1, meaning needs at least one other line
        -- (total 2 lines) to trigger context show.
        if not min_rows then min_rows = 1 end
        if targetLineNumber < node:start() + min_rows then return end

		local virtualText

		if opts.custom_text_handler then
			virtualText = opts.custom_text_handler(node)
		else
			virtualText = "--> " .. ts_utils.get_node_text(node, 0)[1];
		end

		-- Add a guard here to allow users to filter which node to show virtual text
		if not virtualText then
			return
		end

        vim.api.nvim_buf_set_virtual_text(0, vim.g.context_vt_namespace, targetLineNumber, {{ virtualText, 'Comment' }}, {});
    end

end

function M.showDebug()
    node = ts_utils.get_node_at_cursor();
    print("current type")
    print(node:type());
    print("parent type")
    print(node:parent():type());
end

function M.showContext(node)
    if node == nil then
        -- Clear the existing.
        vim.api.nvim_buf_clear_namespace(0, vim.g.context_vt_namespace, 0, -1);
        -- Get the node at the current position.
        node = ts_utils.get_node_at_cursor();
    end

    if  not node then
        return
    end

    local parentNode = node:parent();

    setVirtualText(node)
    if not parentNode then
        return
    end
    setVirtualText(parentNode)

    if parentNode and not (parentNode:type() == 'program') then
        M.showContext(parentNode);
    end
end

return M
