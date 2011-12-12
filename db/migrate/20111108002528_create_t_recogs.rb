class CreateTRecogs < ActiveRecord::Migration
  def self.up
    create_table :t_recogs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :t_recogs
  end
end
