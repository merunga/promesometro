class Ability
  include CanCan::Ability

  def initialize(ciudadano)
    can :manage, :all if ciudadano.es_admin?
    can :denunciar, Promesa
    can :agregar_prueba, Promesa
    can :comentar, :all
    can :seguir, Promesa
    can :reclamar_cumplimiento, Promesa
    can [:seguir,:enviar_hacete_cargo], Ciudadano { |carlos|
      carlos.es_funcionario?
    }
    can [:hacerse_cargo, :lavarse_las_manos], Promesa
    can [:crear, :actualizar, :cumplir], Hito { |el_hito|
      ciudadano.es_duenio_de? el_hito
    } if ciudadano.es_funcionario?
    can :ver_perfil, Ciudadano { |maria|
      maria.es_funcionario?
    }
    can :editar, Promesa { |la_promesa|
      ciudadano.es_funcionario_de? la_promesa ||
      (!la_promesa.esta_legitimizada? && ciudadano.es_duenio_de?(la_promesa))
    }
   
  end
end
