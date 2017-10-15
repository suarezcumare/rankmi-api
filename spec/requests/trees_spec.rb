require 'rails_helper'

RSpec.describe "Trees", type: :request do
  describe "GET /trees" do
    context 'when tree not exists' do
      Tree.destroy_all
      it "return ok but with 0 element" do
        get trees_path
        expect(response).to have_http_status(200)
        expect(json["response"].length).to equal(0)
      end
    end

    context 'when tree exists' do
      let (:management) { FactoryGirl.create(:tree, area: "Management", nota: 0) }
      it "return ok" do
        management_1 = management.children.create(area: "management 1", nota: 1)
        management_2 = management.children.create(area: "management 2", nota: 2)

        get trees_path
        expect(response).to have_http_status(200)
        expect(json["response"].length).to equal(1)
        expect(json["response"][0]["hijos"].length).to equal(2)
      end
    end
  end

  describe "Put /update/:id" do
    let!(:management) { create(:tree) }
    let(:valid_attributes) { {"tree": { "nota": 10.0 } } }

    context 'when tree exists' do
      let (:management) { FactoryGirl.create(:tree, area: "Management", nota: 0) }
      it "return " do
        management_1 = management.children.create(area: "management 1", nota: 1)
        management_2 = management.children.create(area: "management 2", nota: 2)
        put tree_path(management_2.id), params: valid_attributes
        average = (management_1.nota + management_2.reload.nota) / 2
        expect(json["response"]["id"]).to eq (management_2.id)
        expect(json["response"]["area"]).to eq (management_2.area)
        expect(json["response"]["nota"].to_f).to eq(10.0)
        expect(Tree.first.nota).to eq(average)
      end
    end

    context 'when tree not exists' do
      let(:invalid_attributes) { {"tree": {"nota": 3.1 } } }
      it "return ok but errors" do
        put tree_path(100), params: invalid_attributes
        expect(json["status"]).to eq("not_found") 
      end
    end
  end

  describe "Put /tree/:id/create_child" do
    let!(:management) { create(:tree) }
    let(:valid_attributes) { {"tree": { "area": "nombre", "nota": 3.1 } } }

    context 'when tree exists' do
      let (:management) { FactoryGirl.create(:tree, area: "Management", nota: 0) }
      it "return " do
        management_1 = management.children.create(area: "management 1", nota: 1)
        management_2 = management.children.create(area: "management 2", nota: 2)
        post tree_create_child_path(management_2.id), params: valid_attributes
        average = (management_1.nota + management_2.reload.nota) / 2
        expect(json["response"]["area"]).to eq ("nombre")
        expect(json["response"]["nota"].to_f).to eq(3.1)
        expect(Tree.first.nota).to eq(average)
      end
    end

    context 'when tree not exists' do
      let(:invalid_attributes) { {"tree": {"nota": 3.1 } } }
      it "return ok but errors" do
        post tree_create_child_path(management.id), params: invalid_attributes
        expect(json["response"]["area"][0..17]).to eq( [I18n.t("activerecord.errors.models.tree.attributes.area.blank")] )
      end
    end
  end

end
