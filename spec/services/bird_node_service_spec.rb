# frozen_string_literal: true

RSpec.describe BirdNodeService, type: :service do
  describe '.call' do
    context 'when there is two nodes without common ancestor' do
      it 'returns all birds id by traversing through all nodes' do
        node_1 = create(:node)
        node_2 = create(:node, parent: node_1)
        node_3 = create(:node)
        node_4 = create(:node, parent: node_3)
        node_5 = create(:node, parent: node_4)
        bird_1 = create(:bird, node: node_1)
        bird_2 = create(:bird, node: node_2)
        bird_3 = create(:bird, node: node_3)

        result = BirdNodeService.new([node_2.id, node_5.id]).call

        expect(result).to eq([bird_1.id, bird_2.id, bird_3.id])
        expect(result.size).to eq(3)
      end
    end
  end
end
