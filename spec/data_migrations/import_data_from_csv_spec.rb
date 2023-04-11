# frozen_string_literal: true

require Rails.root.join('db', 'data', '20230408123111_import_data_from_csv.rb')

describe ImportDataFromCsv do
  let(:file_source) { File.read(Rails.root.join('db', 'seeds', 'nodes.csv')) }
  let(:file_csv) { CSV.parse(file_source, headers: true, encoding: 'us-ascii') }

  before do
    Node.delete_all
    ImportDataFromCsv.new.up
  end

  it 'imported same number of records' do
    expect(Node.count).to eq 3145
  end

  it 'match size of ids without parent_id' do
    expect(Node.where(parent_id: nil).count).to eq 203
  end

  it 'present some random imported nodes' do
    expect(Node.find_by(id: 256_411, parent_id: nil)).to be_present
    expect(Node.find_by(id: 340_629, parent_id: 165_531)).to be_present
  end
end
