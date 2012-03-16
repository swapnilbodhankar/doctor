class DoctersHaveAndBelongToManyCategoriesDs < ActiveRecord::Migration
def self.up
   create_table :categories_ds_docters, :id => false do |t|
   t.references :categories_d, :docter
   end
end

def self.down
drop_table :categories_ds_docters
end
end
