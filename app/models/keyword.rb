class Keyword < ActiveRecord::Base
  attr_accessible :description, :name
end

# Info from profile:
# Current position: just title? http://developer.linkedin.com/documents/profile-fields#positions
# Patents, publications, etc. For resume but not for matching

#Matching skills

