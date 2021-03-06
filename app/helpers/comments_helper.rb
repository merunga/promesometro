module CommentsHelper
  
  #def latest_simple_comments(limit = 5, truncate_comment = true, length = 30, omission = '...')
  #  render :partial => 'comments/simple_comment', :collection => Comment.by_newest.limit(limit), :locals => { :truncate_comment => truncate_comment, :length => length, :omission => omission }
  #end
  #
  def latest_comments(limit = 5, truncate_comment = true, length = 30, omission = '...')
    Comment.by_newest.limit(limit).each do |c|
      render :partial => 'comments/comment',
        :locals => { :comment => c, :level => 0, :position => 0 }
    end
  end

  #def show_comments(comments, truncate_comment = false, length = 30, omission = '...')
  #  render :partial => 'comments/comment', :collection => comments, :locals => { :truncate_comment => truncate_comment, :length => length, :omission => omission }
  #end
  #
  ## parent is the object to which the comments will be attached
  ## comment is the optional parent comment for the new comment.
  #def comment_form(parent, comment = nil, render_new = false, comment_button_class = 'comment-submit', comment_button_text = nil)
  #  render :partial => 'comments/form', :locals => {:parent => parent,
  #                                                  :comment => comment,
  #                                                  :render_new => render_new,
  #                                                  :comment_button_class => comment_button_class,
  #                                                  :comment_button_text => comment_button_text }
  #end
  #
  ## Render a comment for using the tiny mce editor.  Note that this method
  ## requires that muck-contents be installed and configured correctly and that the
  ## controller that calls the page where this method is called have 'uses_tiny_mce' defined ie:
  ##    uses_tiny_mce(:options => MuckContents.configuration.simple_mce_options,
  ##                  :only => [:new, :create, :edit, :update])
  ## parent is the object to which the comments will be attached
  ## comment is the optional parent comment for the new comment.
  #def tiny_mce_comment_form(parent, comment = nil, render_new = false, comment_button_class = 'comment-submit', comment_button_text = nil)
  #  render :partial => 'comments/tiny_mce_form', :locals => {:parent => parent,
  #                                                           :comment => comment,
  #                                                           :render_new => render_new,
  #                                                           :comment_button_class => comment_button_class,
  #                                                           :comment_button_text => comment_button_text}
  #end
  #
  ## make_muck_parent_params is defined in muck-engine and used by many of the engines.
  ## This will generate a url suitable for a form to post a create to.
  #def new_comment_path_with_parent(parent)
  #  comments_path(make_muck_parent_params(parent))
  #end
  #
  ## Generates a link to the 'new' page for a comment
  #def new_comment_for_path(parent)
  #  new_comment_path(make_muck_parent_params(parent))
  #end
  #
  ## Renders a delete button for a comment
  #def delete_comment(comment, button_type = :button, button_text = t("muck.activities.delete"))
  #  render :partial => 'shared/delete', :locals => { :delete_object => comment,
  #                                                       :button_type => button_type,
  #                                                       :button_text => button_text,
  #                                                       :form_class => 'comment-delete',
  #                                                       :delete_path => comment_path(comment, :format => 'js') }
  #end
  #
  #def limit_comment(text, truncate_comment = false, length = 30, omission = '...')
  #  if truncate_comment
  #    html_summarize(text, length, omission)
  #  else
  #    text
  #  end
  #end
  ## outputs a partial that will embed disqus into any page with a unique url
  ##
  ## Extra instructions from the disqus site:
  ## Append #disqus_thread to the end of permalinks. The comment count code will replace the text of these links with the comment count.
  ## For example, you may have a link with this HTML:
  ## <a href="http://example.com/my_article.html#disqus_thread">Comments</a>
  ## The comment count code will replace the text "Comments" with the number of comments on the page http://example.com/my_article.html
  ##
  ## disqus_short_name: The short name you selected when setting up your site.
  #def disqus(disqus_short_name)
  #  render :partial => 'external/disqus', :locals => { :disqus_short_name => disqus_short_name }
  #end
  
end