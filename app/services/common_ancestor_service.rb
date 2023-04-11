# frozen_string_literal: true

class CommonAncestorService
  attr_reader :a, :b

  def initialize(id_a, id_b)
    @a = Node.find_by(id: id_a)
    @b = id_a == id_b ? @a : Node.find_by(id: id_b)
  end

  def call
    return outcome if a.nil? || b.nil?

    tree_of_nodes(a, nodes_a)
    if a.id == b.id
      outcome.merge!(root_id: a.id, lowest_common_ancestor: nodes_a.min, depth: nodes_a.size)
    else
      tree_of_nodes(b, nodes_b)
      outcome.merge!(root_id:, lowest_common_ancestor:, depth:)
    end

    outcome
  end

  private

  def outcome
    @outcome ||= { root_id: nil, lowest_common_ancestor: nil, depth: nil }
  end

  def nodes_a
    @nodes_a ||= []
  end

  def nodes_b
    @nodes_b ||= []
  end

  def tree_of_nodes(node, node_a_or_b)
    while node.parent_id.present?
      if node.parent_id.present?
        parent = Node.find_by(id: node.parent_id)
        node_a_or_b.push(parent.id)
        node = parent
      else
        node_a_or_b.push(node.id)
      end
    end
  end

  def common_nodes
    @common_nodes ||= nodes_a & nodes_b
  end

  def root_id
    @root_id ||= common_nodes.first
  end

  def lowest_common_ancestor
    @lowest_common_ancestor ||= common_nodes.min
  end

  def depth
    @depth ||= (nodes_a + nodes_b).uniq.size
  end
end
