class TreesController < ApplicationController
  before_action :set_tree, only: [:show, :update, :destroy, :create_child]

  # GET /trees
  def index
    trees
    json_response(@trees)
  end

  # POST /trees/:id
  def create_child
    child = @tree.children.new(tree_params)
    if child.save
      json_response(child, :created, I18n.t("tree.action.create.success"))
    else
      json_response(child.errors, :unprocessable_entity, I18n.t("tree.action.create.error"))
    end
  end

  # PATCH/PUT /trees/:1
  def update
    if @tree.update(tree_params)
      json_response(@tree, :ok, I18n.t("tree.action.update.success"))
    else
      json_response(@tree.errors, :unprocessable_entity, I18n.t("tree.action.update.error"))
    end
  end

  private
    def set_tree
      @tree = Tree.find(params[:id] || params[:tree_id])
    end

    def tree_params
      params.require(:tree).permit(:area, :nota)
    end

    def trees
      @trees ||= Tree.as_json
    end
end
