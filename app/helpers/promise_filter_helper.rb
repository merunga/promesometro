module PromiseFilterHelper
  def input_value(params,param_name)
    (params[:search] == 'topic')? '': (params[:search]? params[:search][param_name]: nil)
  end
end
