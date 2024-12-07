class CreateNotices < ActiveRecord::Migration[6.1]

  def change
    create_table :notices do |t|
      t.references :user, foreign_key: true, null: false
      t.references :noticeable, polymorphic: true, null: false
      t.text :reason, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end

end
