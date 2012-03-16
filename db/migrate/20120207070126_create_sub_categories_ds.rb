class CreateSubCategoriesDs < ActiveRecord::Migration
  def change
    create_table :sub_categories_ds do |t|
      t.string :name

      t.timestamps
    end
  end
end
