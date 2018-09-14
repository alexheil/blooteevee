class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.references :user
      t.string :title
      t.text :video_data
      t.text :image_data
      t.text :description
      t.string :slug

      t.timestamps
    end
  end
end
