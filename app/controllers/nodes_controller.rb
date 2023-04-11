# frozen_string_literal: true

class NodesController < ApplicationController
  def common_ancestor
    render json: CommonAncestorService.new(params[:a], params[:b]).call
  end
end
