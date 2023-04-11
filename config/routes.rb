# frozen_string_literal: true

Rails.application.routes.draw do
  get 'common_ancestor', to: 'nodes#common_ancestor'
end
