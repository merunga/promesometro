class Ability
  include CanCan::Ability

  def initialize(ciudadano)
    #can :manage, :all if ciudadano.es_admin?
    can [:ver,:buscar], Promesa
    if ciudadano
      can [:agregar_prueba], Promesa
      can :comentar, :all
      can [:seguir,:enviar_hacete_cargo], Ciudadano do |carlos|
        carlos.es_funcionario?
      end
      can [:seguir,:reclamar_cumplimiento], Promesa
      can [:hacerse_cargo, :lavarse_las_manos], Promesa
      can [:crear, :actualizar, :cumplir], Hito do |el_hito|
        ciudadano.es_duenio_de? el_hito
      end if ciudadano.es_funcionario? 
      can :ver_perfil, Ciudadano do |maria|
        maria.es_funcionario?
      end
      can [:editar,:actualizar], Promesa do |la_promesa|
        ciudadano.es_funcionario_de? la_promesa ||
        (la_promesa.no.esta_legitimizada? && ciudadano.es_uploader_de?(la_promesa))
      end
      can :editar, Prueba do |la_prueba|
        ciudadano.es_uploader_de? la_prueba
      end
    end
    can [:denunciar], Promesa
  end
end
