class CreateDeaths < ActiveRecord::Migration[6.0]
  def change
    create_table :deaths do |t|
      t.integer :amount
      t.datetime :snapshot

      t.timestamps
    end
  end
end
