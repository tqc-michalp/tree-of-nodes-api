# frozen_string_literal: true

RSpec.describe CommonAncestorService, type: :service do
  describe '.call' do
    context 'when value provided by' do
      let(:node_1) { create(:node) }
      let(:node_2) { create(:node, parent: node_1) }
      let(:node_3) { create(:node) }
      let(:node_4) { create(:node, parent: node_3) }
      let(:node_5) { create(:node, parent: node_4) }

      context 'first param is nil' do
        it 'returns empty response' do
          result = CommonAncestorService.new(nil, node_5.id).call

          expect(result).to eq(root_id: nil, lowest_common_ancestor: nil, depth: nil)
        end
      end

      context 'second param is nil' do
        it 'returns empty response' do
          result = CommonAncestorService.new(node_2.id, nil).call

          expect(result).to eq(root_id: nil, lowest_common_ancestor: nil, depth: nil)
        end
      end

      context 'node by first param does not exist' do
        it 'returns empty response' do
          result = CommonAncestorService.new(22, node_5.id).call

          expect(result).to eq(root_id: nil, lowest_common_ancestor: nil, depth: nil)
        end
      end

      context 'node by second param does not exist' do
        it 'returns empty response' do
          result = CommonAncestorService.new(node_1.id, 22).call

          expect(result).to eq(root_id: nil, lowest_common_ancestor: nil, depth: nil)
        end
      end

      context 'both of params are equal' do
        it 'returns as a root input, lowest by traversing to parent nil and depth adequatly' do
          result = CommonAncestorService.new(node_5.id, node_5.id).call

          expect(result).to eq(root_id: node_5.id, lowest_common_ancestor: node_3.id, depth: 2)
        end
      end
    end

    context 'when there is no common ancestor' do
      it 'returns empty response with 0 depth' do
        node_1 = create(:node)
        node_2 = create(:node)

        result = CommonAncestorService.new(node_1.id, node_2.id).call

        expect(result).to eq({ root_id: nil, lowest_common_ancestor: nil, depth: 0 })
      end
    end

    context 'when there is one common ancestor' do
      it 'returns response pointing to common ancestor' do
        node_1 = create(:node)
        node_2 = create(:node, parent: node_1)
        node_3 = create(:node, parent: node_1)
        node_4 = create(:node, parent: node_3)
        node_5 = create(:node, parent: node_4)

        result = CommonAncestorService.new(node_2.id, node_5.id).call

        expect(result).to eq({ root_id: node_1.id, lowest_common_ancestor: node_1.id, depth: 3 })
      end
    end

    context 'when there is one common ancestor and exist lowest common ancestor' do
      it 'returns response pointing to first common ancestor with lowest common ancestor' do
        node_3 = create(:node)
        node_4 = create(:node, parent: node_3)
        create(:node, parent: node_4)
        node_6 = create(:node, parent: node_4)
        node_7 = create(:node, parent: node_6)

        result = CommonAncestorService.new(node_6.id, node_7.id).call

        expect(result).to eq({ root_id: node_4.id, lowest_common_ancestor: node_3.id, depth: 3 })
      end
    end

    context 'when there is one common ancestor and exist lowest common ancestor' do
      it 'returns response pointing to first common ancestor with lowest common ancestor' do
        node_3 = create(:node)
        node_4 = create(:node, parent: node_3)
        node_5 = create(:node, parent: node_4)
        node_6 = create(:node, parent: node_5)
        node_7 = create(:node, parent: node_6)
        node_8 = create(:node, parent: node_7)
        node_66 = create(:node, parent: node_5)
        node_77 = create(:node, parent: node_66)
        node_88 = create(:node, parent: node_77)

        result = CommonAncestorService.new(node_88.id, node_8.id).call

        expect(result).to eq({ root_id: node_5.id, lowest_common_ancestor: node_3.id, depth: 7 })
      end
    end
  end
end
