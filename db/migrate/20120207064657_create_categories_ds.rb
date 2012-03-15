class CreateCategoriesDs < ActiveRecord::Migration
  def self.up

    create_table :categories_ds do |t|
      t.string :name
   
      t.timestamps
    end
  end
    def self.down
    drop_table :categories_ds
  end

end
