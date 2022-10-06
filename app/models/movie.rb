class Movie < ActiveRecord::Base
    def self.all_ratings
        ['G','PG','PG-13','R']
    end

    def self.with_ratings(ratings)
        if ratings.nil?
            return Movie.all
        else
            return Movie.where('UPPER(rating) IN (?)', ratings)
        end
    end
end