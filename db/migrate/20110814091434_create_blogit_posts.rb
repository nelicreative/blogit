class CreateBlogitPosts < ActiveRecord::Migration
  def change
    create_table :blogit_posts do |t|
      t.with_options(null: false) do |r|
        r.string :state, default: Blogit::configuration.hidden_states.first.to_s
        r.integer :comments_count, default: 0
      end
      t.references :blogger, polymorphic: true
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Blogit::Post.create_translation_table! title: :string, body: :text, description: :text
      end

      dir.down do
        Blogit::Post.drop_translation_table!
      end
    end
  end
end
