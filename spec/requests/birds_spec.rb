# frozen_string_literal: true

RSpec.describe 'Birds', type: :request do
  describe 'GET /birds' do
    context 'with valid params' do
      it 'returns JSON array of bird ids' do
        node_1 = create(:node)
        node_2 = create(:node, parent: node_1)
        bird_1 = create(:bird, node: node_1)

        get '/birds', params: { node_ids: [node_2.id] }

        expect(JSON.parse(response.body)).to eq([bird_1.id])
      end
    end
  end
end
