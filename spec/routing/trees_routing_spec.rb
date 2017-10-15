require "rails_helper"

RSpec.describe TreesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/trees").to route_to("trees#index")
    end

    it "routes to #create_child" do
      expect(post: "/trees/1/create_child").to route_to("trees#create_child", tree_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/trees/1").to route_to("trees#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trees/1").to route_to("trees#update", id: "1")
    end
  end
end
