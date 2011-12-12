class CreateTlexes < ActiveRecord::Migration
  def self.up
    create_table :tlexes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :tlexes
  end
end
