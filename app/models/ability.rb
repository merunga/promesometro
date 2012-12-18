class Ability
  include CanCan::Ability

  def initialize(ciudadano)
    can :manage, :all if (ciudadano && (ciudadano.admin?))
    can [:ver], Promesa do |la_promesa|
      la_promesa.publica || (ciudadano && (
        ciudadano.es_funcionario_de?(la_promesa) ||
        (ciudadano.es_uploader_de?(la_promesa) && !la_promesa.funcionario) ||
        (la_promesa.compartida_con.include?(ciudadano.email))
      ))
    end
    can [:buscar], Promesa
    if ciudadano
      can [:crear, :agregar_prueba], Promesa
      can :comentar, :all
      can :reply, Comment
      can [:seguir], Ciudadano
      can :ver_perfil, Ciudadano do |maria|
        maria.perfil_publico
      end
      can [
        :seguir, :dejar_de_seguir, :reclamar_cumplimiento,
        :dejar_de_reclamar_cumplimiento
      ], Promesa
      can [:hacerme_cargo, :lavarme_las_manos, :enviar_hazte_cargo], Promesa
      #can [:crear, :actualizar, :cumplir], Hito do |el_hito|
      #  ciudadano.es_duenio_de? el_hito
      #end if ciudadano.es_funcionario? 
      can [:editar,:actualizar], Promesa do |la_promesa|
        #ciudadano.es_funcionario_de? la_promesa ||
        #(la_promesa.no.esta_legitimizada? && ciudadano.es_uploader_de?(la_promesa))
        (ciudadano.es_uploader_de?(la_promesa) && !la_promesa.funcionario) ||
        ciudadano.es_funcionario_de?(la_promesa)
      end
      can :editar, Prueba do |la_prueba|
        ciudadano.es_uploader_de? la_prueba
      end
      can [:vote_up, :vote_down], Vote
    end
    can [:denunciar, :prometer], Promesa
    can [:autocomplete_region_nombre, :autocomplete_tag_name], Promesa
  end
end
