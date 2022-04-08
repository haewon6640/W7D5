# == Schema Information
#
# Table name: posts
#
#  id        :bigint           not null, primary key
#  title     :string           not null
#  url       :string
#  content   :text
#  sub_id    :integer          not null
#  author_id :integer          not null
#
class Post < ApplicationRecord
    validates :title, :author_id, presence: true
    before_validation :ensure_url

    belongs_to :author,
        class_name: :User

    has_many :post_subs,
        foreign_key: :post_id,
        class_name: :PostSub,
        dependent: :destroy
    
    has_many :subs,
        through: :post_subs,
        source: :sub

    def ensure_url
        unless self.url.nil?
            unless self.url.starts_with?("https://") 
                self.url = "https://#{self.url}"
            end
        end
    end
end
