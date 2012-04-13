class Epic < Story
  has_many :stories, :class_name => 'Story', :foreign_key => "epic_id"

  def is_estimatable?
    false
  end

  def all_stories_finished?
    stories.each do |story|
       if !story.finished?
         return false
       end
    end
    true
  end

  def all_stories_delivered?
    stories.each do |story|
       if !story.delivered?
         return false
       end
    end
    true
  end

  def all_stories_accepted?
    stories.each do |story|
       if !story.accepted?
         return false
       end
    end
    true
  end

  def all_stories_rejected?
    stories.each do |story|
       if !story.rejected?
         return false
       end
    end
    true
  end

end
