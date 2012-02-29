module PromiseFilterHelper
  def input_value(params,param_name)
    search = params[:search]
    if search.is_a?(String) then
      if search == param_name.to_s then
        # TODO: funciona solo para officials TOTALLY HACK
        # Official.where("name = '#{params[:query]}'").first.id
        params[:query]
      end
    else
      (params[:search] == 'topic')? '':
          (params[:search]? params[:search][param_name]: nil)
    end
  end
end
