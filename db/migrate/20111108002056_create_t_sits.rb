class CreateTSits < ActiveRecord::Migration
  def self.up
    create_table :t_sits do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :t_sits
  end
end
