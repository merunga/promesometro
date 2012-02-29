class PromiseSearch

  attr_accessor :promises

  def initialize conditions = nil, page = 1
    @promises ||= find_promises conditions, page
  end

  private

  def find_promises conditions, current_page
    @promise_search = Promise
    if conditions

      find_by_state_id conditions[:state] if conditions[:state]
      find_by_province_id conditions[:province] if conditions[:province]
      find_by_official_id conditions[:official] if conditions[:official]
      find_by_keywords conditions[:keyword] if conditions[:keyword]
      find_by_topic_id conditions[:topic] if conditions[:topic]
      find_by_political_party_id conditions[:political_party] if conditions[:political_party]
    end
    @promise_search.page current_page
  end

  def set_id_value(conditions, field)
    if conditions[:query] then
      if search == param_name.to_s then
        # TODO: funciona solo para officials TOTALLY HACK
        Official.where("name = '#{params[:query]}'").first.id
      end
    else
      conditions[:state]
    end
  end

  def find_by_title title
    @promise_search = @promise_search.where('upper(promises.title) LIKE upper(?)',"%#{title}%") if title
  end

  def find_by_state state_name
    find_by_name({:official => :state},'upper(states.name) LIKE upper(?)', state_name)
  end

  def find_by_state_id state_id
    find_by_id({:official => :state},'states.id = ?',state_id)
  end

  def find_by_province_name province_name
    find_by_name({:official => :provinces},'upper(provinces.name) LIKE upper(?)', province_name)
  end

  def find_by_province_id province_id
    #find_by_id({:official => {:state => :provinces} },'provinces.id = ?',province_id)
    find_by_id({:official => :province},'provinces.id = ?',province_id)
  end

  def find_by_official_name official_name
    find_by_name(:official,'upper(officials.name) LIKE upper(?)',official_name)
  end

  def find_by_official_id official_id
    find_by_id(:official,'officials.id = ?',official_id)
  end

  def find_by_political_party_name pp_name
    find_by_name({:official => :political_party},'upper(political_parties.name) LIKE upper(?)',pp_name)
  end

  def find_by_political_party_id pp_id
    find_by_id({:official => :political_party},'political_parties.id = ?',pp_id)
  end

  def find_by_keywords keywords
    @promise_search = @promise_search.where('upper(title) LIKE upper(?) OR upper(description) LIKE upper(?)',"%#{keywords}%", "%#{keywords}%") if keywords
  end

  def find_by_topic_name topic_name
    find_by_name(:topics,'upper(topics.name) LIKE upper(?)',topic_name)
  end

  def find_by_topic_id topic_id
    find_by_id(:topics,'topics.id = ?',topic_id)
  end

  private
    def find_by_id(join,cond,id)
      if id != '' then
        @promise_search = @promise_search.joins(join).where(cond,id)
      end
    end

    def find_by_name(join,cond,name)
      if name != '' then
        @promise_search = @promise_search.joins(join).where(cond,name)
      end
    end
end