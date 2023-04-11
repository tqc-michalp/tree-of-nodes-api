# frozen_string_literal: true

RSpec.describe 'Nodes', type: :request do
  describe 'GET /common_ancestor' do
    context 'with valid params' do
      it 'returns ok' do
        node_3 = create(:node)
        node_4 = create(:node, parent: node_3)
        create(:node, parent: node_4)
        node_6 = create(:node, parent: node_4)
        node_7 = create(:node, parent: node_6)

        get '/common_ancestor', params: { a: node_6.id, b: node_7.id }

        expect(JSON.parse(response.body)).to eq({ 'root_id' => node_4.id, 'lowest_common_ancestor' => node_3.id,
                                                  'depth' => 3 })
      end
    end
  end
end
