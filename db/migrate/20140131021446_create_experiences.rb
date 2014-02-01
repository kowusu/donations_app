class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :primary_contact_name
      t.string :location
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
