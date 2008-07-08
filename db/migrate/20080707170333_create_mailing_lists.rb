class CreateMailingLists < ActiveRecord::Migration
  def self.up
    create_table :mailing_lists do |t|
      t.string :name
      t.string :form_text

      t.timestamps
    end
  end

  def self.down
    drop_table :mailing_lists
  end
end
