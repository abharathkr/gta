class Student < ActiveRecord::Base
	def self.search(q)
#		where("unmid::text LIKE ?","%#{q}%").all
		find("unmid = ?","#{q}")
	end
end
