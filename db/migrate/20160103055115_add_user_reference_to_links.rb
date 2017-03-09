# frozen_string_literal: true
class AddUserReferenceToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :user, index: true, foreign_key: true
    add_index :links, [:user_id, :created_at]
  end
end
