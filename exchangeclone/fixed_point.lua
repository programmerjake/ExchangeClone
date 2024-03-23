---keeps calling `eval_node(node)` on nodes until nothing changes anymore.
---basically it works by keeping track of which nodes can be changed by any
---node, using that information to only recalculate nodes whose inputs have changed.
---@alias NodeId integer | string a node identifier, e.g. an index or node name
---@param node_ids NodeId[] the list of node identifiers to operate on
---@param get_input_node_ids fun(node_id: NodeId): NodeId[] returns the list of nodes that `node_id` calculates its value from
---@param eval_node fun(node_id: NodeId): boolean recalculate the value of `node_id`, return `true` if the value changed, `false` otherwise
function exchangeclone.fixed_point(node_ids, get_input_node_ids, eval_node)
    -- a fixed-point algorithm using a worklist

    ---nodes that a node uses as inputs
    ---@type table<NodeId, NodeId[]>
    local input_dependencies = {}
    ---nodes that a node is an input of
    ---@type table<NodeId, NodeId[]>
    local output_dependencies = {}
    ---array of nodes that need to be recalculated
    ---@type NodeId[]
    local worklist = {}
    ---set of nodes that need to be recalculated
    ---@type table<NodeId, true>
    local worklist_set = {}
    for _, node_id in ipairs(node_ids) do
        output_dependencies[node_id] = {}
        input_dependencies[node_id] = get_input_node_ids(node_id)
        if not worklist_set[node_id] then
            table.insert(worklist, node_id)
            worklist_set[node_id] = true
        end
    end
    for output_node_id, input_node_ids in pairs(input_dependencies) do
        for _, input_node_id in ipairs(input_node_ids) do
            table.insert(output_dependencies[input_node_id], output_node_id)
        end
    end
    while #worklist > 0 do
        local node_id = table.remove(worklist)
        worklist_set[node_id] = nil
        if eval_node(node_id) then
            for _, output_node_id in ipairs(output_dependencies[node_id]) do
                if not worklist_set[output_node_id] then
                    table.insert(worklist, output_node_id)
                    worklist_set[output_node_id] = true
                end
            end
        end
    end
end
