# frozen_string_literal: true

class CreateNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :nodes do |t|
      t.references :parent, foreign_key: { to_table: :nodes }

      t.timestamps
    end
  end
end
