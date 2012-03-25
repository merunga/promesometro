# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
window.promesa ||= {}

$(document).ready ->
  $('.promesa .field.type > input[type=radio]').live 'change', ->
    $this = $(this)
    klass = $this.val().toLowerCase()
    $parent = $this.parents('.prueba')
    
    fields_to_hide = $parent.find('.field:not(.type):not(.'+klass+')')
    fields_to_hide.hide()
    fields_to_hide.find('input, textarea').attr('disabled',true)
    
    field_to_show = $parent.find('.field.'+klass)
    field_to_show.find('input, textarea').removeAttr('disabled')
    field_to_show.show()
    
promesa.add_prueba = ->
  $pruebas = $('#pruebas')
  $pruebas.append $ Mustache.render $('#prueba_upload_template').html(), {count : $pruebas.find('.prueba').size()}

promesa.remove_prueba = ($prueba) ->
  $prueba.find('input, textarea').attr('disabled',true)
  $prueba.hide()
