class PromiseSearch

  attr_accessor :promises

  def initialize conditions = nil, page = 1
    @promises ||= find_promises conditions, page
  end

  private

  def find_promises conditions, current_page
    @promise_search = Promise
    if conditions
      puts conditions.inspect
      find_by_title conditions[:title] if conditions[:title]
      find_by_state_id conditions[:state] if conditions[:state]
      find_by_province_id conditions[:province] if conditions[:province]
      find_by_official_id conditions[:official] if conditions[:official]
      find_by_keywords conditions[:keywords] if conditions[:keywords]
      find_by_topic_id conditions[:topic] if conditions[:topic]
    end
    @promise_search.page current_page
  end

  def find_by_title title
    @promise_search = @promise_search.where('promises.title iLIKE ?',"%#{title}%") if title
  end

  def find_by_state state_name
    @promise_search = @promise_search.joins(:official => :state).where('states.name iLIKE ?',"%#{state_name}%") if state_name
  end

  def find_by_state_id state_id
    find_by_id({:official => :state},'states.id = ?',state_id)
  end

  def find_by_province_name province_name
    @promise_search = @promise_search.joins(:official => :province).where('provinces.name iLIKE ?',"%#{province_name}%") if province_name
  end

  def find_by_province_id province_id
    find_by_id({:official => :province},'provinces.id = ?',province_id)
  end

  def find_by_official_name official_name
    @promise_search = @promise_search.joins(:official).where('officials.name iLIKE ?',"%#{official_name}%") if official_name
  end

  def find_by_official_id official_id
    find_by_id(:official,'officials.id = ?',official_id)
  end

  def find_by_keywords keywords
    @promise_search = @promise_search.where('title iLIKE ? OR description iLIKE ?',"%#{keywords}%", "%#{keywords}%") if keywords
  end

  def find_by_topic_name topic_name
    @promise_search = @promise_search.joins(:topics).where('topics.name iLIKE ?',"%#{topic_name}%") if topic_name
  end

  def find_by_topic_id topic_id
    find_by_id(:topics,'topics.id = ?',topic_id)
  end

  private
    def find_by_id(join,cond,id)
      @promise_search = @promise_search.joins(join).where(cond,id) if id
    end
end