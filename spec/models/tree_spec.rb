require 'rails_helper'

RSpec.describe Tree, type: :model do
  
  context 'validations' do
    it "should presence_of a area" do
      should validate_presence_of(:area)
    end

    it "should presence_of a nota" do
      should validate_presence_of(:nota)
    end
  end

  describe "#sibling_count" do
   let (:management) { FactoryGirl.create(:tree, area: "Management", nota: 0) }

   it "when is siblings, returns the number in the tree" do
      management_1 = management.children.create(area: "management 1", nota: 1)
      management_2 = management.children.create(area: "management 2", nota: 2)
     expect(management_1.sibling_count - 1).to eq 1
   end

   it "when is not siblings, returns the number of siblings in the tree" do
     expect(management.sibling_count - 1).to eq 0
   end
  end

  describe "#sibling_notas" do
   let (:management) { FactoryGirl.create(:tree, area: "Management", nota: 1) }

   it "when is siblings, returns the number in the tree" do
      management_1 = management.children.create(area: "management 1", nota: 5)
      management_2 = management.children.create(area: "management 2", nota: 2)
     expect(management_2.sibling_notas).to eq 7
   end

   it "when is not siblings, returns the number of siblings in the tree" do
     expect(management.sibling_notas).to eq 1
   end
  end

  describe "#as_json" do
    context 'when is elements' do
      let (:management) { FactoryGirl.create(:tree, area: "Management", nota: 1) }

      it "when is siblings, returns the number in the tree" do
        management_1 = management.children.create(area: "management 1", nota: 5)
        management_2 = management.children.create(area: "management 2", nota: 2)
        _tree = Tree.as_json
        expect(_tree.count).to eq 1
        expect(_tree.first[:hijos].count).to eq 2
      end
    end

    context 'when is not elements' do
      Tree.destroy_all
      it "when is not siblings, returns the number of siblings in the tree" do
        _tree = Tree.as_json
        expect(_tree).to eq []
        expect(_tree.count).to eq 0
      end
    end
  end
end
