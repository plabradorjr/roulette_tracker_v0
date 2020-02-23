class CreateSpinsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :spins do |t|
      t.string :landed
      t.integer :user_id
    end
  end
end
