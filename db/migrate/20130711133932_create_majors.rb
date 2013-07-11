class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :name
      t.integer :source_id
      t.integer :school_id
      t.string :zhaosheng_leibie
      t.string :leibie
      t.string :duixiang
      t.string :code
      t.integer :xuezhi
      t.integer :renshu
      t.integer :xuefei

      t.timestamps
    end
    add_index :majors,:source_id,:uniq=>true
    add_index :majors,:school_id
  end
end
