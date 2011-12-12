class CreateSintacticTables < ActiveRecord::Migration
  def self.up
    create_table :sintactic_tables do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :sintactic_tables
  end
end
