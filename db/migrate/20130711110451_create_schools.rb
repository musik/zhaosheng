class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :code
      t.boolean :gongban
      t.string :address
      t.string :phone
      t.string :postal
      t.timestamps
    end
    add_index :schools,:name,:uniq=>true
  end
end
