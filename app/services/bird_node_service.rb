# frozen_string_literal: true

class BirdNodeService
  attr_reader :node_ids

  def initialize(node_ids)
    @node_ids = node_ids
  end

  def call
    node_ids
      .map { |node_id| CommonAncestorService.new(node_id, node_id).nodes }
      .flatten
      .uniq
      .then { |nodes| Bird.where(node_id: nodes) }
      .ids
  end
end
