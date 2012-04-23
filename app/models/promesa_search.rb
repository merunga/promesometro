class PromesaSearch

  attr_accessor :promesas

  def initialize conditions = nil, page = 1
    @promesas ||= find_promesas conditions, page
  end

  private

  def find_promesas conditions, current_page
    @promesa_search = Promesa
    if conditions
      find_by_state_id conditions[:state] if conditions[:state]
      find_by_province_id conditions[:province] if conditions[:province]
      find_by_official_id conditions[:official] if conditions[:official]
      find_by_keywords conditions[:keyword] if conditions[:keyword]
    end
    @promesa_search.page current_page
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
    @promesa_search = @promesa_search.where('upper(promesas.title) LIKE upper(?)',"%#{title}%") if title
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

  def find_by_political_party_id pp_id
    find_by_id({:official => :political_party},'political_parties.id = ?',pp_id)
  end

  def find_by_keywords keywords
    @promesa_search = @promesa_search.joins(
        'LEFT JOIN comments ON comments.commentable_id = promesas.id and comments.commentable_type = "promesa"'+
        'LEFT JOIN info_funcionarios ON info_funcionarios.promesa_id = promesas.id '+
        'LEFT JOIN regiones ON regiones.id = promesas.region_id '+
        'LEFT JOIN pruebas ON pruebas.promesa_id = promesas.id '
    ).where(
        'upper(promesas.lo_prometido) LIKE upper(:keywords) '+
        'OR upper(info_funcionarios.nombre) LIKE upper(:keywords) '+
        'OR upper(info_funcionarios.cargo) LIKE upper(:keywords) '+
        'OR upper(info_funcionarios.entidad) LIKE upper(:keywords) '+
        'OR upper(regiones.nombre) LIKE upper(:keywords) '+
        'OR upper(pruebas.descripcion) LIKE upper(:keywords) '+
        'OR upper(comments.title) LIKE upper(:keywords) '+
        'OR upper(comments.body) LIKE upper(:keywords) ',
        :keywords => "%#{keywords}%"
    ).select("distinct promesas.*") if keywords
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
        @promesa_search = @promesa_search.joins(join).where(cond,id)
      end
    end

    def find_by_name(join,cond,name)
      if name != '' then
        @promesa_search = @promesa_search.joins(join).where(cond,name)
      end
    end
end