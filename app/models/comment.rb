class Comment < ActiveRecord::Base
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]
  
  validates_presence_of :user
  validates_presence_of :body, :message => '^Comentario vacio'

  scope :by_newest, :order => "comments.created_at DESC"
  scope :by_oldest, :order => "comments.created_at ASC"
  scope :newer_than, lambda { |*args| where("comments.created_at > ?", args.first || 1.week.ago) }
  scope :by_user, lambda { |*args| where('comments.user_id = ?', args.first) }
  
  # NOTE: install the acts_as_votable plugin if you 
  # want user to vote on the quality of comments.
  #acts_as_voteable
  
  # NOTE: Comments belong to a user
  belongs_to :user
  
  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, comment)
    c = self.new
    c.commentable_id = obj.id 
    c.commentable_type = obj.class.name 
    c.body = comment 
    c.user_id = user_id
    return c
  end

  # Send an email to everyone in the thread
  def after_create
    emails = []
    #Comment.find_comments_for_parent(comment) do |c|
    parent = self.commentable_type.classify.constantize.find(self.commentable_id)
    parent.comment_threads.each do |c|
      emails << c.user.email unless emails.include?(c.user.email) if c.user and c.user.send_notifications
    end

    if !emails.empty? then
      CommentMailer.new_comment(self).deliver
    end
  end
  
  #helper method to check if a comment has children
  def has_children?
    self.children.size > 0 
  end
  
  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for 
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  scope :find_comments_for_parent, lambda { |c|
    Comment.find_comments_for_commentable(c.commentable_str,c.commentable_id)
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id 
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end
end
