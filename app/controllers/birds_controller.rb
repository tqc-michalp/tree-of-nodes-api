# frozen_string_literal: true

class BirdsController < ApplicationController
  def index
    render json: BirdNodeService.new(params[:node_ids]).call
  end
end
