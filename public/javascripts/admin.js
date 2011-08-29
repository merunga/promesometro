$.extend({
  new_milestone: function() {
    $('a#nuevo_hito').click(function(){
      html = $('#new_milestones .well').first().clone();
      $.clean_milestone(html);
      html.appendTo('#new_milestones');
      return false;
    });
  },
  
  clean_milestone: function(html) {
    html.find('input').val('').attr('name','promise[milestones_attributes]['+$('#new_milestones .well').size()+'][name]');
    html.find('textarea').val('').attr('name','promise[milestones_attributes]['+$('#new_milestones .well').size()+'][description]');;
  },
  
  close_milestone: function() {
    $('.well a.close').live('click',function(){
      if($('#new_milestones .well').size() > 1)
        $(this).parent().remove();
      return false;
    });
  },
  
  close_alerts: function() {
    $('.alert-message a.close').click(function(){
      $(this).parent().hide();
    });
  },
  
  auto_close_alerts: function() {
    $('.alert-message').delay(3000).fadeOut(2000)
  },
  
  sorteable_topics: function(url, authenticity_token) {
    $("#sorteable_topics tbody").sortable({
      type: 'post',
      update: function(){
        $.ajax({async:true, 
          complete:function(request){
            $("#sorteable_topics tbody").effect("highlight") }, 
            data:$("#sorteable_topics tbody").sortable('serialize') + '&authenticity_token=' + encodeURIComponent(authenticity_token), 
            dataType:'script', 
            url: url})
        }
    });
    $("#sorteable_topics").disableSelection();
  },
  
  change_provinces_select: function() {
    province_select = $('select#official_province_id');
    if($('select#official_position').attr('value') == '0') {
      province_select.removeAttr('disabled').removeClass('uneditable-input');
      $.fill_province_select();
    } else {
      province_select.attr('disabled', true).addClass('uneditable-input');
    }
  },
  
  change_province: function() {
    $('select#official_state_id').change(function(){ $.change_provinces_select(); });
    $('select#official_position').change(function(){ $.change_provinces_select(); });
  },
  
  fill_province_select: function() {
    state_id = $('select#official_state_id').attr('value')
    if( state_id != '') {
      $('select#official_province_id option').remove();
      $.getJSON('/admin/officials/provinces/' + state_id ,function(data){
        $.each(data, function(key, val) {
          option = $('<option>'+ val.province.name+'</option>')
            .attr('value',val.province.id)
            .appendTo('select#official_province_id');
        });
      });
    }
  }
});

$(document).ready(function(){  
  $.new_milestone();
  $.close_milestone();
  $.close_alerts();
  $.auto_close_alerts();
  $.change_province();
});