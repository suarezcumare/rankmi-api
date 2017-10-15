# == Schema Information
#
# Table name: trees
#
#  id         :integer          not null, primary key
#  area       :string
#  nota       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string
#

class Tree < ApplicationRecord
  has_ancestry

  validates :area, presence: true
  validates :nota, presence: true
  after_commit :update_parent, on: [:create, :update]

  def self.as_json(options={}, hash=nil)
      hash ||= arrange(options)
      current_hast = []
      hash.each do |node, children|
        branch = {id: node.id, area: node.area, nota: node.nota}
        branch[:hijos] = as_json(options, children) unless children.empty?
        current_hast << branch
      end
      current_hast
    rescue SomeError
      return []
  end

  def sibling_notas
      siblings.pluck(:nota).sum
    rescue SomeError
      return 0
  end

  def sibling_count
      siblings.count
    rescue SomeError
      return 1
  end

  private
    def update_parent(child=self)
      update_notas(child)
    end

    def update_notas(child)
      if child.has_parent?
        parent = child.parent
        average = child.sibling_notas / child.sibling_count
        parent.update_columns(nota: average)
        update_notas(parent)
      end
    end
end
