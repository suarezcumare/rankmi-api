class TreeExample < SeedMigration::Migration
  def up
    management = Tree.create(area: "Gerencia", nota: 11)
    management_1 = management.children.create(area: "Gerencia 1", nota: 12)
    management_2 = management.children.create(area: "Gerencia 2", nota: 13)

    management_1.children.create(area: "Gerencia 1 - 1", nota: 14)
    management_1.children.create(area: "Gerencia 1 - 2", nota: 15)

    management_2.children.create(area: "Gerencia 2 - 1", nota: 16)
    management_2.children.create(area: "Gerencia 2 - 2", nota: 17)
  end

  def down
    Tree.destroy_all
  end
end
