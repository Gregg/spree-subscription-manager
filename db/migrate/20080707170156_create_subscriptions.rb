class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :mailing_list_id

      t.timestamps
    end
    
    add_index :subscriptions, :user_id
    add_index :subscriptions, :mailing_list_id
  end

  def self.down
    drop_table :subscriptions
  end
end
