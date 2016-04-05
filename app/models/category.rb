class Category < ActiveRecord::Base
  validates :category_name, presence: true,
                            uniqueness: { case_sensitive: false },
                            length: { minimum: 3, maximum: 20 }

end