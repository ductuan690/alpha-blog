class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.belongs_to :article, index: true
      t.belongs_to :category, index: true
    end
  end
end
