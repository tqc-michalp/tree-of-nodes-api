# frozen_string_literal: true

require 'csv'

class ImportDataFromCsv < ActiveRecord::Migration[7.0]
  def up
    file_source = File.read(Rails.root.join('db/seeds/nodes.csv'))
    file_csv = CSV.parse(file_source, headers: true, encoding: 'us-ascii')
    return if file_csv.empty?

    Node.insert_all(
      file_csv
        .map { |row| row['parent_id'] }
        .compact
        .uniq
        .map { |parent_id| { id: parent_id } }
    )

    file_csv.each do |row|
      node = Node.find_by(id: row['id'])
      if node.present?
        node.update!(parent_id: row['parent_id'])
      else
        Node.create!(id: row['id'], parent_id: row['parent_id'])
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
