class CreateRoulettesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :roulettes do |t|
      t.string :roulette_number
      t.integer :landing_frequency
      t.integer :user_id
    end
  end
end
