class CreateTokenizers < ActiveRecord::Migration
  def self.up
    create_table :tokenizers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :tokenizers
  end
end
