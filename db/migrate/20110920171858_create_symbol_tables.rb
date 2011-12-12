class CreateSymbolTables < ActiveRecord::Migration
  def self.up
    create_table :symbol_tables do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :symbol_tables
  end
end
