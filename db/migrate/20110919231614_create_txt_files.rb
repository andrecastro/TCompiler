class CreateTxtFiles < ActiveRecord::Migration
  def self.up
    create_table :txt_files do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :txt_files
  end
end
