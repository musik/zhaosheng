class RenameMajorZhaoshengLeibieToMoshi < ActiveRecord::Migration
  def change
    rename_column :majors,:zhaosheng_leibie,:moshi
  end
end
