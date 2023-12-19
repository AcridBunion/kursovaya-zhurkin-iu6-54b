class CreateAutos < ActiveRecord::Migration[7.0]
  def change
    create_table :autos do |t|
      t.string :title
      t.text :car_text
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
      t.string :image
      t.string :pictures
    end
  end
end
