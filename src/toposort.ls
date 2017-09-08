function toposort nodes
  deps = {}
  Object.values nodes .for-each (parents) ->
    parents.for-each (id) -> deps[id] := (deps[id] || 0) + 1
  start = Object.keys nodes .filter (-> !(it of deps))
  cut = ->
    head = nodes[it]map (id) ->
      deps[id] -= 1
      if deps[id] == 0 then cut id else []
    []concat ...head, it
  []concat ...start.map cut

export default: toposort
