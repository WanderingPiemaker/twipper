class Tweet < ActiveRecord::Base
	include Twitter::Extractor

	def extract_hash_tags
		extract_hashtags(self.tweet)
	end

	validate :hashtags_created

	def hashtags_created
		begin
			transaction do
				puts '1'
				@hashtags = self.extract_hash_tags
			puts '2'
				@hashtags.each_with_index do |the_hashtag, index|
					puts "the hashtag is #{the_hashtag} and the index is #{index}"
					if Hashtag.where(h: the_hashtag).any?
						# do nothing
					else
						if Hashtag.create!(h: the_hashtag)
							# do nothing
						else
							self.errors.add(:tweet, "The hashtag is invalid")
						end
					end
				end
			end
		rescue
			# code will continue here if runtime error is encountered
			self.errors.add(:tweet, "The hashtag is invalid")
		end
	end

	belongs_to :user
	validates :tweet, length: { maximum: 140 }

	
end
