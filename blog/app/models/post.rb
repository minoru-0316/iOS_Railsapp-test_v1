class Post < ApplicationRecord
    def self.search(search)
      search ? where('title LIKE ? or id LIKE ? or memo LIKE ? or user_id LIKE ?', "%#{search}%" , "%#{search}%" , "%#{search}%" , "%#{search}%") : all
    end
end