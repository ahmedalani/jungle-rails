class DropUsers1 < ActiveRecord::Migration
  def change
    drop_table :users    
  end
end
