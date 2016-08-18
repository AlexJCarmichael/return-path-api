class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :vote_type, null: false
      t.references :votable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
