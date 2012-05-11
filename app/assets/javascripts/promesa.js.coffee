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
    
promesa.upload_template = null
    
promesa.add_prueba = (tipo, cont_selector) ->
  cont_selector = '#pruebas' if not cont_selector
  $pruebas = $(cont_selector)
  ctx = {count: $pruebas.find('fieldset.prueba').size()}
  ctx[recurso] = tipo == recurso for recurso in ['link','imagen','archivo','video','mapa']
  if !promesa.upload_template
    promesa.upload_template = $('#prueba_upload_template')
      .html().replace(/_0_/g,'_{{count}}_').replace(/\[0\]/g,'[{{count}}]')
  $pruebas.append $ Mustache.render promesa.upload_template, ctx

promesa.remove_prueba = ($prueba) ->
  $prueba.find('input, textarea').attr('disabled',true)
  $prueba.remove()
  
jQuery ($) ->
  $('.seguir a[data-type=html], .reclamar a[data-type=html]').parent().on 'ajax:success', (event, data, status, xhr) ->
    $(this).html data
  $(document).on 'ajax:success', '.comentar form[data-remote=true]', (event, data, status, xhr) ->
    $(this).parents('.comentar').siblings('.comentarios').append $(data)
  $(document).on 'ajax:success', '.responder form[data-remote=true]', (event, data, status, xhr) ->
    $(this).parents('.comment:not(.reply)').first().find('.thread:first').append $(data)
  $(document).on 'ajax:success', '#pruebas > .add > form[data-remote=true]', (event, data, status, xhr) ->
    $(this).parent('.add').replaceWith data
  $(document).on 'ajax:success', '.hazte_cargo form[data-remote=true]', (event, data, status, xhr) ->
    $(this).parent('.hazte_cargo').remove
    