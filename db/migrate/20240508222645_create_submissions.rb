class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.string :content, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
