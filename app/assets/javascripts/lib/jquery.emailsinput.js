/*

	jQuery Emails Input Plugin 1.3.3
	
	Copyright (c) 2011 XOXCO, Inc
	
	Documentation for this plugin lives here:
	http://xoxco.com/clickable/jquery-emails-input
	
	Licensed under the MIT license:
	http://www.opensource.org/licenses/mit-license.php

	ben@xoxco.com

*/

(function($) {

	var delimiter = new Array();
	var emails_callbacks = new Array();
	/*$.fn.doAutosize = function(o){
	    var minWidth = $(this).data('minwidth'),
	        maxWidth = $(this).data('maxwidth'),
	        val = '',
	        input = $(this),
	        testSubject = $('#'+$(this).data('tester_id'));
	
	    if (val === (val = input.val())) {return;}
	
	    // Enter new content into testSubject
	    var escaped = val.replace(/&/g, '&amp;').replace(/\s/g,' ').replace(/</g, '&lt;').replace(/>/g, '&gt;');
	    testSubject.html(escaped);
	    // Calculate new width + whether to change
	    var testerWidth = testSubject.width(),
	        newWidth = (testerWidth + o.comfortZone) >= minWidth ? testerWidth + o.comfortZone : minWidth,
	        currentWidth = input.width(),
	        isValidWidthChange = (newWidth < currentWidth && newWidth >= minWidth)
	                             || (newWidth > minWidth && newWidth < maxWidth);
	
	    // Animate width
	    if (isValidWidthChange) {
	        input.width(newWidth);
	    }


  };
  $.fn.resetAutosize = function(options){
    // alert(JSON.stringify(options));
    var minWidth =  $(this).data('minwidth') || options.minInputWidth || $(this).width(),
        maxWidth = $(this).data('maxwidth') || options.maxInputWidth || ($(this).closest('.emailsinput').width() - options.inputPadding),
        val = '',
        input = $(this),
        testSubject = $('<tester/>').css({
            position: 'absolute',
            top: -9999,
            left: -9999,
            width: 'auto',
            fontSize: input.css('fontSize'),
            fontFamily: input.css('fontFamily'),
            fontWeight: input.css('fontWeight'),
            letterSpacing: input.css('letterSpacing'),
            whiteSpace: 'nowrap'
        }),
        testerId = $(this).attr('id')+'_autosize_tester';
    if(! $('#'+testerId).length > 0){
      testSubject.attr('id', testerId);
      testSubject.appendTo('body');
    }

    input.data('minwidth', minWidth);
    input.data('maxwidth', maxWidth);
    input.data('tester_id', testerId);
    input.css('width', minWidth);
  };*/
  
	$.fn.addEmail = function(value,options) {
			// is email?
			if(!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(value))) {
				return false
			}
			options = jQuery.extend({focus:false,callback:true},options);
			this.each(function() { 
				var id = $(this).attr('id');

				var emailslist = $(this).val().split(delimiter[id]);
				if (emailslist[0] == '') { 
					emailslist = new Array();
				}

				value = jQuery.trim(value);
		
				if (options.unique) {
					var skipEmail = $(this).emailExist(value);
					if(skipEmail == true) {
					    //Marks fake input as not_valid to let styling it
    				    $('#'+id+'_email').addClass('not_valid');
    				}
				} else {
					var skipEmail = false; 
				}
				
				if (value !='' && skipEmail != true) { 
                    $('<span>').addClass('email').append(
                        $('<span>').text(value).append('&nbsp;&nbsp;'),
                        $('<a>', {
                            href  : '#',
                            title : 'Removing email',
                            text  : 'x'
                        }).click(function () {
                            return $('#' + id).removeEmail(escape(value));
                        })
                    ).insertBefore('#' + id + '_addEmail');

					emailslist.push(value);
				
					$('#'+id+'_email').val('');
					if (options.focus) {
						$('#'+id+'_email').focus();
					} else {		
						$('#'+id+'_email').blur();
					}
					
					$.fn.emailsInput.updateEmailsField(this,emailslist);
					
					if (options.callback && emails_callbacks[id] && emails_callbacks[id]['onAddEmail']) {
						var f = emails_callbacks[id]['onAddEmail'];
						f.call(this, value);
					}
					if(emails_callbacks[id] && emails_callbacks[id]['onChange'])
					{
						var i = emailslist.length;
						var f = emails_callbacks[id]['onChange'];
						f.call(this, $(this), emailslist[i-1]);
					}					
				}
		
			});		
			
			return false;
		};
		
	$.fn.removeEmail = function(value) { 
			value = unescape(value);
			this.each(function() { 
				var id = $(this).attr('id');
	
				var old = $(this).val().split(delimiter[id]);
					
				$('#'+id+'_emailsinput .email').remove();
				str = '';
				for (i=0; i< old.length; i++) { 
					if (old[i]!=value) { 
						str = str + delimiter[id] +old[i];
					}
				}
				
				$.fn.emailsInput.importEmails(this,str);

				if (emails_callbacks[id] && emails_callbacks[id]['onRemoveEmail']) {
					var f = emails_callbacks[id]['onRemoveEmail'];
					f.call(this, value);
				}
			});
					
			return false;
		};
	
	$.fn.emailExist = function(val) {
		var id = $(this).attr('id');
		var emailslist = $(this).val().split(delimiter[id]);
		return (jQuery.inArray(val, emailslist) >= 0); //true when email exists, false when not
	};
	
	// clear all existing emails and import new ones from a string
	$.fn.importEmails = function(str) {
                id = $(this).attr('id');
		$('#'+id+'_emailsinput .email').remove();
		$.fn.emailsInput.importEmails(this,str);
	}
		
	$.fn.emailsInput = function(options) { 
    var settings = jQuery.extend({
      interactive:true,
      defaultText:'agrega un email',
      minChars:0,
      width:'300px',
      height:'100px',
      autocomplete: {selectFirst: false },
      'hide':true,
      'delimiter':',',
      'unique':true,
      removeWithBackspace:false,
      placeholderColor:'#666666',
      autosize: true,
      comfortZone: 20,
      inputPadding: 6*2
    },options);

		this.each(function() { 
			if (settings.hide) { 
				$(this).hide();				
			}
			var id = $(this).attr('id');
			if (!id || delimiter[$(this).attr('id')]) {
				id = $(this).attr('id', 'emails' + new Date().getTime()).attr('id');
			}
			
			var data = jQuery.extend({
				pid:id,
				real_input: '#'+id,
				holder: '#'+id+'_emailsinput',
				input_wrapper: '#'+id+'_addEmail',
				fake_input: '#'+id+'_email'
			},settings);
	
			delimiter[id] = data.delimiter;
			
			if (settings.onAddEmail || settings.onRemoveEmail || settings.onChange) {
				emails_callbacks[id] = new Array();
				emails_callbacks[id]['onAddEmail'] = settings.onAddEmail;
				emails_callbacks[id]['onRemoveEmail'] = settings.onRemoveEmail;
				emails_callbacks[id]['onChange'] = settings.onChange;
			}
	
			var markup = '<div id="'+id+'_emailsinput" class="emailsinput"><div id="'+id+'_addEmail">';
			
			if (settings.interactive) {
				markup = markup + '<input id="'+id+'_email" value="" data-default="'+settings.defaultText+'" />';
			}
			
			markup = markup + '</div><div class="emails_clear"></div></div>';
			
			$(markup).insertAfter(this);

			$(data.holder).css('width',settings.width);
			$(data.holder).css('min-height',settings.height);
			$(data.holder).css('height','100%');
	
			if ($(data.real_input).val()!='') { 
				$.fn.emailsInput.importEmails($(data.real_input),$(data.real_input).val());
			}		
			if (settings.interactive) { 
				$(data.fake_input).val($(data.fake_input).attr('data-default'));
				$(data.fake_input).css('color',settings.placeholderColor);
		        $(data.fake_input).resetAutosize(settings);
		
				$(data.holder).bind('click',data,function(event) {
					$(event.data.fake_input).focus();
				});
			
				$(data.fake_input).bind('focus',data,function(event) {
					if ($(event.data.fake_input).val()==$(event.data.fake_input).attr('data-default')) { 
						$(event.data.fake_input).val('');
					}
					$(event.data.fake_input).css('color','#000000');		
				});
						
				if (settings.autocomplete_url != undefined) {
					autocomplete_options = {source: settings.autocomplete_url};
					for (attrname in settings.autocomplete) { 
						autocomplete_options[attrname] = settings.autocomplete[attrname]; 
					}
				
					if (jQuery.Autocompleter !== undefined) {
						$(data.fake_input).autocomplete(settings.autocomplete_url, settings.autocomplete);
						$(data.fake_input).bind('result',data,function(event,data,formatted) {
							if (data) {
								$('#'+id).addEmail(data[0] + "",{focus:true,unique:(settings.unique)});
							}
					  	});
					} else if (jQuery.ui.autocomplete !== undefined) {
						$(data.fake_input).autocomplete(autocomplete_options);
						$(data.fake_input).bind('autocompleteselect',data,function(event,ui) {
							$(event.data.real_input).addEmail(ui.item.value,{focus:true,unique:(settings.unique)});
							return false;
						});
					}
				
					
				} else {
						// if a user tabs out of the field, create a new email
						// this is only available if autocomplete is not used.
						$(data.fake_input).bind('blur',data,function(event) { 
							var d = $(this).attr('data-default');
							if ($(event.data.fake_input).val()!='' && $(event.data.fake_input).val()!=d) { 
								if( (event.data.minChars <= $(event.data.fake_input).val().length) && (!event.data.maxChars || (event.data.maxChars >= $(event.data.fake_input).val().length)) )
									$(event.data.real_input).addEmail($(event.data.fake_input).val(),{focus:true,unique:(settings.unique)});
							} else {
								$(event.data.fake_input).val($(event.data.fake_input).attr('data-default'));
								$(event.data.fake_input).css('color',settings.placeholderColor);
							}
							return false;
						});
				
				}
				// if user types a comma, create a new email
				$(data.fake_input).bind('keypress',data,function(event) {
					if (event.which==event.data.delimiter.charCodeAt(0) || event.which==13 ) {
					    event.preventDefault();
						if( (event.data.minChars <= $(event.data.fake_input).val().length) && (!event.data.maxChars || (event.data.maxChars >= $(event.data.fake_input).val().length)) )
							$(event.data.real_input).addEmail($(event.data.fake_input).val(),{focus:true,unique:(settings.unique)});
					  	$(event.data.fake_input).resetAutosize(settings);
						return false;
					} else if (event.data.autosize) {
			            $(event.data.fake_input).doAutosize(settings);
            
          			}
				});
				//Delete last email on backspace
				data.removeWithBackspace && $(data.fake_input).bind('keydown', function(event)
				{
					if(event.keyCode == 8 && $(this).val() == '')
					{
						 event.preventDefault();
						 var last_email = $(this).closest('.emailsinput').find('.email:last').text();
						 var id = $(this).attr('id').replace(/_email$/, '');
						 last_email = last_email.replace(/[\s]+x$/, '');
						 $('#' + id).removeEmail(escape(last_email));
						 $(this).trigger('focus');
					}
				});
				$(data.fake_input).blur();
				
				//Removes the not_valid class when user changes the value of the fake input
				if(data.unique) {
				    $(data.fake_input).keydown(function(event){
				        if(event.keyCode == 8 || String.fromCharCode(event.which).match(/\w+|[áéíóúÁÉÍÓÚñÑ,/]+/)) {
				            $(this).removeClass('not_valid');
				        }
				    });
				}
			} // if settings.interactive
		});
			
		return this;
	
	};
	
	$.fn.emailsInput.updateEmailsField = function(obj,emailslist) { 
		var id = $(obj).attr('id');
		$(obj).val(emailslist.join(delimiter[id]));
	};
	
	$.fn.emailsInput.importEmails = function(obj,val) {			
		$(obj).val('');
		var id = $(obj).attr('id');
		var emails = val.split(delimiter[id]);
		for (i=0; i<emails.length; i++) { 
			$(obj).addEmail(emails[i],{focus:false,callback:false});
		}
		if(emails_callbacks[id] && emails_callbacks[id]['onChange'])
		{
			var f = emails_callbacks[id]['onChange'];
			f.call(obj, obj, emails[i]);
		}
	};

})(jQuery);
