class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :title
      t.text :description
      t.references :donatable, :polymorphic => true

      t.timestamps
    end
  end
end
