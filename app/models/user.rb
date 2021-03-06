class User < ActiveRecord::Base

    has_secure_password

    has_many :roulettes
    has_many :spins
    
    def slug
        username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug.downcase}
    end

end