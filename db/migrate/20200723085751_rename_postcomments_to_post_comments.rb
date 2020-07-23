class RenamePostcommentsToPostComments < ActiveRecord::Migration[5.2]
  def change
  	rename_table :postcomments, :post_comments
  end
end
