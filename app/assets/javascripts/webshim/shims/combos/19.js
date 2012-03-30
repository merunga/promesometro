(function(b){if(!Modernizr.genericDOM){var d=document,g,l,n=/<([\w:]+)/,t={option:1,optgroup:1,legend:1,thead:1,tr:1,td:1,col:1,area:1};b.webshims.fixHTML5=function(b){if("string"!=typeof b||t[(n.exec(b)||["",""])[1].toLowerCase()])return b;if(!l){g=d.body;if(!g)return b;l=d.createElement("div");l.style.display="none"}var m=l.cloneNode(!1);g.appendChild(m);m.innerHTML=b;g.removeChild(m);return m.childNodes}}})(jQuery);
jQuery.webshims.register("dom-extend",function(b,d,g,l,n){var t=d.modules,s=/\s*,\s*/,m={},u={},p={},w={},a={},e=b.fn.val,q=function(a,k,f,c,v){return v?e.call(b(a)):e.call(b(a),f)};b.fn.val=function(a){var k=this[0];arguments.length&&null==a&&(a="");if(!arguments.length)return!k||1!==k.nodeType?e.call(this):b.prop(k,"value",a,"val",!0);if(b.isArray(a))return e.apply(this,arguments);var f=b.isFunction(a);return this.each(function(c){k=this;1===k.nodeType&&(f?(c=a.call(k,c,b.prop(k,"value",n,"val",
!0)),null==c&&(c=""),b.prop(k,"value",c,"val")):b.prop(k,"value",a,"val"))})};var h="_webshimsLib"+Math.round(1E3*Math.random()),r=function(a,k,f){a=a.jquery?a[0]:a;if(!a)return f||{};var c=b.data(a,h);f!==n&&(c||(c=b.data(a,h,{})),k&&(c[k]=f));return k?c&&c[k]:c};[{name:"getNativeElement",prop:"nativeElement"},{name:"getShadowElement",prop:"shadowElement"},{name:"getShadowFocusElement",prop:"shadowFocusElement"}].forEach(function(a){b.fn[a.name]=function(){return this.map(function(){var b=r(this,
"shadowData");return b&&b[a.prop]||this})}});["removeAttr","prop","attr"].forEach(function(c){m[c]=b[c];b[c]=function(k,f,i,v,e){var d="val"==v,o=!d?m[c]:q;if(!k||!u[f]||1!==k.nodeType||!d&&v&&"attr"==c&&b.attrFn[f])return o(k,f,i,v,e);var y=(k.nodeName||"").toLowerCase(),j=p[y],r="attr"==c&&(!1===i||null===i)?"removeAttr":c,h,x,l;j||(j=p["*"]);j&&(j=j[f]);j&&(h=j[r]);if(h){if("value"==f)x=h.isVal,h.isVal=d;if("removeAttr"===r)return h.value.call(k);if(i===n)return h.get?h.get.call(k):h.value;h.set&&
("attr"==c&&!0===i&&(i=f),l=h.set.call(k,i));if("value"==f)h.isVal=x}else l=o(k,f,i,v,e);if((i!==n||"removeAttr"===r)&&a[y]&&a[y][f]){var g;g="removeAttr"==r?!1:"prop"==r?!!i:!0;a[y][f].forEach(function(b){if(!b.only||(b.only="prop"==c)||"attr"==b.only&&"prop"!=c)b.call(k,i,g,d?"val":r,c)})}return l};w[c]=function(a,f,i){p[a]||(p[a]={});p[a][f]||(p[a][f]={});var v=p[a][f][c],e=function(b,a,k){return a&&a[b]?a[b]:k&&k[b]?k[b]:"prop"==c&&"value"==f?function(b){return i.isVal?q(this,f,b,!1,0===arguments.length):
m[c](this,f,b)}:"prop"==c&&"value"==b&&i.value.apply?function(b){var a=m[c](this,f);a&&a.apply&&(a=a.apply(this,arguments));return a}:function(b){return m[c](this,f,b)}};p[a][f][c]=i;if(i.value===n){if(!i.set)i.set=i.writeable?e("set",i,v):d.cfg.useStrict&&"prop"==f?function(){throw f+" is readonly on "+a;}:b.noop;if(!i.get)i.get=e("get",i,v)}["value","get","set"].forEach(function(b){i[b]&&(i["_sup"+b]=e(b,v))})}});var c=!b.browser.msie||8<parseInt(b.browser.version,10),j=function(){var b=d.getPrototypeOf(l.createElement("foobar")),
a=Object.prototype.hasOwnProperty;return function(f,i,e){var j=l.createElement(f),h=d.getPrototypeOf(j);if(c&&h&&b!==h&&(!j[i]||!a.call(j,i))){var q=j[i];e._supvalue=function(){return q&&q.apply?q.apply(this,arguments):q};h[i]=e.value}else e._supvalue=function(){var b=r(this,"propValue");return b&&b[i]&&b[i].apply?b[i].apply(this,arguments):b&&b[i]},o.extendValue(f,i,e.value);e.value._supvalue=e._supvalue}}(),o=function(){var a={};d.addReady(function(c,f){var k={},i=function(a){k[a]||(k[a]=b(c.getElementsByTagName(a)),
f[0]&&b.nodeName(f[0],a)&&(k[a]=k[a].add(f)))};b.each(a,function(b,a){i(b);!a||!a.forEach?d.warn("Error: with "+b+"-property. methods: "+a):a.forEach(function(a){k[b].each(a)})});k=null});var c,f=b([]),i=function(f,i){a[f]?a[f].push(i):a[f]=[i];b.isDOMReady&&(c||b(l.getElementsByTagName(f))).each(i)};return{createTmpCache:function(a){b.isDOMReady&&(c=c||b(l.getElementsByTagName(a)));return c||f},flushTmpCache:function(){c=null},content:function(a,c){i(a,function(){var a=b.attr(this,c);null!=a&&b.attr(this,
c,a)})},createElement:function(b,a){i(b,a)},extendValue:function(a,c,f){i(a,function(){b(this).each(function(){r(this,"propValue",{})[c]=this[c];this[c]=f})})}}}(),x=function(b,a){if(b.defaultValue===n)b.defaultValue="";if(!b.removeAttr)b.removeAttr={value:function(){b[a||"prop"].set.call(this,b.defaultValue);b.removeAttr._supvalue.call(this)}}};b.extend(d,{getID:function(){var a=(new Date).getTime();return function(c){var c=b(c),f=c.attr("id");f||(a++,f="ID-"+a,c.attr("id",f));return f}}(),extendUNDEFProp:function(a,
c){b.each(c,function(b,c){b in a||(a[b]=c)})},createPropDefault:x,data:r,moveToFirstEvent:function(){var a=b._data?"_data":"data";return function(c,f,i){if((c=(b[a](c,"events")||{})[f])&&1<c.length)f=c.pop(),i||(i="bind"),"bind"==i&&c.delegateCount?c.splice(c.delegateCount,0,f):c.unshift(f)}}(),addShadowDom:function(a,c,f){f=f||{};a.jquery&&(a=a[0]);c.jquery&&(c=c[0]);if(!f.shadowFocusElement)f.shadowFocusElement=c;var i=b.data(a,h)||b.data(a,h,{}),e=b.data(c,h)||b.data(c,h,{});i.hasShadow=c;e.nativeElement=
a;e.shadowData=i.shadowData={nativeElement:a,shadowElement:c,shadowFocusElement:f.shadowFocusElement};f.shadowChilds&&f.shadowChilds.each(function(){r(this,"shadowData",e.shadowData)});if(f.data)i.shadowData.data=f.data,e.shadowData.data=f.data;f=null},propTypes:{standard:function(b){x(b);if(!b.prop)b.prop={set:function(a){b.attr.set.call(this,""+a)},get:function(){return b.attr.get.call(this)||b.defaultValue}}},"boolean":function(b){x(b);if(!b.prop)b.prop={set:function(a){a?b.attr.set.call(this,
""):b.removeAttr.value.call(this)},get:function(){return null!=b.attr.get.call(this)}}}},reflectProperties:function(a,c){"string"==typeof c&&(c=c.split(s));c.forEach(function(c){d.defineNodeNamesProperty(a,c,{prop:{set:function(a){b.attr(this,c,a)},get:function(){return b.attr(this,c)||""}}})})},defineNodeNameProperty:function(a,c,f){u[c]=!0;if(f.reflect)d.propTypes[f.propType||"standard"](f);["prop","attr","removeAttr"].forEach(function(i){var e=f[i];e&&(e="prop"===i?b.extend({writeable:!0},e):b.extend({},
e,{writeable:!0}),w[i](a,c,e),"*"!=a&&d.cfg.extendNative&&"prop"==i&&e.value&&b.isFunction(e.value)&&j(a,c,e),f[i]=e)});f.initAttr&&o.content(a,c);return f},defineNodeNameProperties:function(b,a,c,e){for(var j in a)!e&&a[j].initAttr&&o.createTmpCache(b),c&&(a[j][c]?d.log("override: "+b+"["+j+"] for "+c):(a[j][c]={},["value","set","get"].forEach(function(b){b in a[j]&&(a[j][c][b]=a[j][b],delete a[j][b])}))),a[j]=d.defineNodeNameProperty(b,j,a[j]);e||o.flushTmpCache();return a},createElement:function(a,
c,f){var e;b.isFunction(c)&&(c={after:c});o.createTmpCache(a);c.before&&o.createElement(a,c.before);f&&(e=d.defineNodeNameProperties(a,f,!1,!0));c.after&&o.createElement(a,c.after);o.flushTmpCache();return e},onNodeNamesPropertyModify:function(c,e,f,i){"string"==typeof c&&(c=c.split(s));b.isFunction(f)&&(f={set:f});c.forEach(function(b){a[b]||(a[b]={});"string"==typeof e&&(e=e.split(s));f.initAttr&&o.createTmpCache(b);e.forEach(function(c){a[b][c]||(a[b][c]=[],u[c]=!0);if(f.set){if(i)f.set.only=i;
a[b][c].push(f.set)}f.initAttr&&o.content(b,c)});o.flushTmpCache()})},defineNodeNamesBooleanProperty:function(a,c,f){f||(f={});if(b.isFunction(f))f.set=f;d.defineNodeNamesProperty(a,c,{attr:{set:function(b){this.setAttribute(c,b);f.set&&f.set.call(this,!0)},get:function(){return null==this.getAttribute(c)?n:c}},removeAttr:{value:function(){this.removeAttribute(c);f.set&&f.set.call(this,!1)}},reflect:!0,propType:"boolean",initAttr:f.initAttr||!1})},contentAttr:function(b,a,c){if(b.nodeName){if(c===
n)return c=(b.attributes[a]||{}).value,null==c?n:c;"boolean"==typeof c?c?b.setAttribute(a,a):b.removeAttribute(a):b.setAttribute(a,c)}},activeLang:function(){var a=[],c={},f,e,j=/:\/\/|^\.*\//,o=function(a,c,f){return c&&f&&-1!==b.inArray(c,f.availabeLangs||[])?(a.loading=!0,f=f.langSrc,j.test(f)||(f=d.cfg.basePath+f),d.loader.loadScript(f+c+".js",function(){a.langObj[c]?(a.loading=!1,q(a,!0)):b(function(){a.langObj[c]&&q(a,!0);a.loading=!1})}),!0):!1},h=function(b){c[b]&&c[b].forEach(function(b){b.callback()})},
q=function(b,a){if(b.activeLang!=f&&b.activeLang!==e){var c=t[b.module].options;if(b.langObj[f]||e&&b.langObj[e])b.activeLang=f,b.callback(b.langObj[f]||b.langObj[e],f),h(b.module);else if(!a&&!o(b,f,c)&&!o(b,e,c)&&b.langObj[""]&&""!==b.activeLang)b.activeLang="",b.callback(b.langObj[""],f),h(b.module)}};return function(j){if("string"==typeof j&&j!==f)f=j,e=f.split("-")[0],f==e&&(e=!1),b.each(a,function(b,a){q(a)});else if("object"==typeof j)if(j.register)c[j.register]||(c[j.register]=[]),c[j.register].push(j),
j.callback();else{if(!j.activeLang)j.activeLang="";a.push(j);q(j)}return f}}()});b.each({defineNodeNamesProperty:"defineNodeNameProperty",defineNodeNamesProperties:"defineNodeNameProperties",createElements:"createElement"},function(b,a){d[b]=function(b,c,e,j){"string"==typeof b&&(b=b.split(s));var o={};b.forEach(function(b){o[b]=d[a](b,c,e,j)});return o}});d.isReady("webshimLocalization",!0)});
(function(b,d){var g=b.webshims.browserVersion;if(!(b.browser.mozilla&&5<g)&&(!b.browser.msie||12>g&&7<g)){var l={article:"article",aside:"complementary",section:"region",nav:"navigation",address:"contentinfo"},n=function(b,d){b.getAttribute("role")||b.setAttribute("role",d)};b.webshims.addReady(function(g,s){b.each(l,function(d,a){for(var e=b(d,g).add(s.filter(d)),q=0,h=e.length;q<h;q++)n(e[q],a)});if(g===d){var m=d.getElementsByTagName("header")[0],u=d.getElementsByTagName("footer"),p=u.length;
m&&!b(m).closest("section, article")[0]&&n(m,"banner");p&&(m=u[p-1],b(m).closest("section, article")[0]||n(m,"contentinfo"))}})}})(jQuery,document);
jQuery.webshims.register("form-datalist",function(b,d,g,l,n){d.propTypes.element=function(g){d.createPropDefault(g,"attr");if(!g.prop)g.prop={get:function(){var d=g.attr.get.call(this);d&&(d=b("#"+d)[0])&&g.propNodeName&&!b.nodeName(d,g.propNodeName)&&(d=null);return d||null},writeable:!1}};(function(){if(!Modernizr.input.list){var t=0,s={submit:1,button:1,reset:1,hidden:1,range:1,date:1},m=b.browser.msie&&7>parseInt(b.browser.version,10),u={},p=function(b){if(!b)return[];if(u[b])return u[b];var e;
try{e=JSON.parse(localStorage.getItem("storedDatalistOptions"+b))}catch(d){}u[b]=e||[];return e||[]},w={_create:function(a){if(!s[b.prop(a.input,"type")]){var e=a.datalist,d=b.data(a.input,"datalistWidget");if(e&&d&&d.datalist!==e)d.datalist=e,d.id=a.id,b(d.datalist).unbind("updateDatalist.datalistWidget").bind("updateDatalist.datalistWidget",b.proxy(d,"_resetListCached")),d._resetListCached();else if(e){if(!(d&&d.datalist===e)){t++;var h=this;this.hideList=b.proxy(h,"hideList");this.timedHide=function(){clearTimeout(h.hideTimer);
h.hideTimer=setTimeout(h.hideList,9)};this.datalist=e;this.id=a.id;this.hasViewableData=!0;this._autocomplete=b.attr(a.input,"autocomplete");b.data(a.input,"datalistWidget",this);this.shadowList=b('<div class="datalist-polyfill" />').appendTo("body");this.index=-1;this.input=a.input;this.arrayOptions=[];this.shadowList.delegate("li","mouseenter.datalistWidget mousedown.datalistWidget click.datalistWidget",function(a){var c=b("li:not(.hidden-item)",h.shadowList),e="mousedown"==a.type||"click"==a.type;
h.markItem(c.index(a.currentTarget),e,c);"click"==a.type&&h.hideList();return"mousedown"!=a.type}).bind("focusout",this.timedHide);a.input.setAttribute("autocomplete","off");b(a.input).attr({"aria-haspopup":"true"}).bind("input.datalistWidget",function(){if(!h.triggeredByDatalist)h.changedValue=!1,h.showHideOptions()}).bind("keydown.datalistWidget",function(a){var c=a.keyCode;if(40==c&&!h.showList())return h.markItem(h.index+1,!0),!1;if(h.isListVisible){if(38==c)return h.markItem(h.index-1,!0),!1;
if(!a.shiftKey&&(33==c||36==c))return h.markItem(0,!0),!1;if(!a.shiftKey&&(34==c||35==c))return a=b("li:not(.hidden-item)",h.shadowList),h.markItem(a.length-1,!0,a),!1;if(13==c||27==c)return 13==c&&h.changeValue(b("li.active-item:not(.hidden-item)",h.shadowList)),h.hideList(),!1}}).bind("focus.datalistWidget",function(){b(this).hasClass("list-focus")&&h.showList()}).bind("mousedown.datalistWidget",function(){(this==l.activeElement||b(this).is(":focus"))&&h.showList()}).bind("blur.datalistWidget",
this.timedHide);b(this.datalist).unbind("updateDatalist.datalistWidget").bind("updateDatalist.datalistWidget",b.proxy(this,"_resetListCached"));this._resetListCached();a.input.form&&a.input.id&&b(a.input.form).bind("submit.datalistWidget"+a.input.id,function(){var e=b.prop(a.input,"value"),c=(a.input.name||a.input.id)+b.prop(a.input,"type");if(!h.storedOptions)h.storedOptions=p(c);if(e&&-1==h.storedOptions.indexOf(e)&&(h.storedOptions.push(e),e=h.storedOptions,c)){e=e||[];try{localStorage.setItem("storedDatalistOptions"+
c,JSON.stringify(e))}catch(d){}}});b(g).bind("unload",function(){h.destroy()})}}else d&&d.destroy()}},destroy:function(){var a=b.attr(this.input,"autocomplete");b(this.input).unbind(".datalistWidget").removeData("datalistWidget");this.shadowList.remove();b(l).unbind(".datalist"+this.id);this.input.form&&this.input.id&&b(this.input.form).unbind("submit.datalistWidget"+this.input.id);this.input.removeAttribute("aria-haspopup");a===n?this.input.removeAttribute("autocomplete"):b(this.input).attr("autocomplete",
a)},_resetListCached:function(b){var e=this,q;this.needsUpdate=!0;this.lastUpdatedValue=!1;this.lastUnfoundValue="";this.updateTimer||(g.QUnit||(q=b&&l.activeElement==e.input)?e.updateListOptions(q):d.ready("WINDOWLOAD",function(){e.updateTimer=setTimeout(function(){e.updateListOptions();e=null;t=1},200+100*t)}))},updateListOptions:function(a){this.needsUpdate=!1;clearTimeout(this.updateTimer);this.updateTimer=!1;this.shadowList.css({fontSize:b.curCSS(this.input,"fontSize"),fontFamily:b.curCSS(this.input,
"fontFamily")});var e=[],d=[],h=[],g,c,j,o;for(c=b.prop(this.datalist,"options"),j=0,o=c.length;j<o;j++){g=c[j];if(g.disabled)return;g={value:b(g).val()||"",text:b.trim(b.attr(g,"label")||g.textContent||g.innerText||b.text([g])||""),className:g.className||"",style:b.attr(g,"style")||""};g.text?g.text!=g.value&&(g.className+=" different-label-value"):g.text=g.value;d[j]=g.value;h[j]=g}if(!this.storedOptions)this.storedOptions=p((this.input.name||this.input.id)+b.prop(this.input,"type"));this.storedOptions.forEach(function(b){-1==
d.indexOf(b)&&h.push({value:b,text:b,className:"stored-suggest",style:""})});for(j=0,o=h.length;j<o;j++)c=h[j],e[j]='<li class="'+c.className+'" style="'+c.style+'" tabindex="-1" role="listitem"><span class="option-label">'+c.text+'</span> <span class="option-value">'+c.value+"</span></li>";this.arrayOptions=h;this.shadowList.html('<ul role="list" class="'+(this.datalist.className||"")+" "+this.datalist.id+'-shadowdom">'+e.join("\n")+"</ul>");b.fn.bgIframe&&m&&this.shadowList.bgIframe();(a||this.isListVisible)&&
this.showHideOptions()},showHideOptions:function(a){var e=b.prop(this.input,"value").toLowerCase();if(!(e===this.lastUpdatedValue||this.lastUnfoundValue&&0===e.indexOf(this.lastUnfoundValue))){this.lastUpdatedValue=e;var d=!1,g=b("li",this.shadowList);e?this.arrayOptions.forEach(function(a,c){if(!("lowerText"in a))a.lowerText=a.text!=a.value?a.text.toLowerCase()+a.value.toLowerCase():a.text.toLowerCase();-1!==a.lowerText.indexOf(e)?(b(g[c]).removeClass("hidden-item"),d=!0):b(g[c]).addClass("hidden-item")}):
g.length&&(g.removeClass("hidden-item"),d=!0);this.hasViewableData=d;!a&&d&&this.showList();if(!d)this.lastUnfoundValue=e,this.hideList()}},setPos:function(){var a=d.getRelOffset(this.shadowList,this.input);a.top+=b(this.input).outerHeight();a.width=b(this.input).outerWidth()-(parseInt(this.shadowList.css("borderLeftWidth"),10)||0)-(parseInt(this.shadowList.css("borderRightWidth"),10)||0);this.shadowList.css(a);return a},showList:function(){if(this.isListVisible)return!1;this.needsUpdate&&this.updateListOptions();
this.showHideOptions(!0);if(!this.hasViewableData)return!1;this.isListVisible=!0;var a=this,e;a.setPos();m&&(a.shadowList.css("height","auto"),250<a.shadowList.height()&&a.shadowList.css("height",220));a.shadowList.addClass("datalist-visible");b(l).unbind(".datalist"+a.id).bind("mousedown.datalist"+a.id+" focusin.datalist"+a.id,function(e){e.target===a.input||a.shadowList[0]===e.target||b.contains(a.shadowList[0],e.target)?(clearTimeout(a.hideTimer),setTimeout(function(){clearTimeout(a.hideTimer)},
9)):a.timedHide()});b(g).unbind(".datalist"+a.id).bind("resize.datalist"+a.id+"orientationchange.datalist "+a.id+" emchange.datalist"+a.id,function(){clearTimeout(e);e=setTimeout(function(){a.setPos()},9)});clearTimeout(e);return!0},hideList:function(){if(!this.isListVisible)return!1;var a=this,e=function(){a.changedValue&&b(a.input).trigger("change");a.changedValue=!1};a.shadowList.removeClass("datalist-visible list-item-active").scrollTop(0).find("li.active-item").removeClass("active-item");a.index=
-1;a.isListVisible=!1;if(a.changedValue){a.triggeredByDatalist=!0;d.triggerInlineForm&&d.triggerInlineForm(a.input,"input");if(a.input==l.activeElement||b(a.input).is(":focus"))b(a.input).one("blur",e);else e();a.triggeredByDatalist=!1}b(l).unbind(".datalist"+a.id);b(g).unbind(".datalist"+a.id);return!0},scrollIntoView:function(a){var e=b("> ul",this.shadowList),d=a.position();d.top-=(parseInt(e.css("paddingTop"),10)||0)+(parseInt(e.css("marginTop"),10)||0)+(parseInt(e.css("borderTopWidth"),10)||
0);0>d.top?this.shadowList.scrollTop(this.shadowList.scrollTop()+d.top-2):(d.top+=a.outerHeight(),a=this.shadowList.height(),d.top>a&&this.shadowList.scrollTop(this.shadowList.scrollTop()+(d.top-a)+2))},changeValue:function(a){if(a[0]){var a=b("span.option-value",a).text(),e=b.prop(this.input,"value");if(a!=e)b(this.input).prop("value",a).triggerHandler("updateInput"),this.changedValue=!0}},markItem:function(a,e,d){d=d||b("li:not(.hidden-item)",this.shadowList);if(d.length)0>a?a=d.length-1:a>=d.length&&
(a=0),d.removeClass("active-item"),this.shadowList.addClass("list-item-active"),d=d.filter(":eq("+a+")").addClass("active-item"),e&&(this.changeValue(d),this.scrollIntoView(d)),this.index=a}};(function(){d.defineNodeNameProperty("datalist","options",{prop:{writeable:!1,get:function(){var a=b("select",this);a[0]?a=a[0].options:(a=b("option",this).get(),a.length&&d.warn("you should wrap you option-elements for a datalist in a select element to support IE and other old browsers."));return a}}});d.defineNodeNameProperties("input",
{selectedOption:{prop:{writeable:!1,get:function(){var a=b.prop(this,"list"),e=null,d;if(!a)return e;d=b.attr(this,"value");if(!d)return e;a=b.prop(a,"options");if(!a.length)return e;b.each(a,function(a,g){if(d==b.prop(g,"value"))return e=g,!1});return e}}},autocomplete:{attr:{get:function(){var a=b.data(this,"datalistWidget");return a?a._autocomplete:"autocomplete"in this?this.autocomplete:this.getAttribute("autocomplete")},set:function(a){var e=b.data(this,"datalistWidget");e?(e._autocomplete=a,
"off"==a&&e.hideList()):"autocomplete"in this?this.autocomplete=a:this.setAttribute("autocomplete",a)}}},list:{attr:{get:function(){var b=d.contentAttr(this,"list");return null==b?n:b},set:function(a){d.contentAttr(this,"list",a);d.objectCreate(w,n,{input:this,id:a,datalist:b.prop(this,"list")})}},initAttr:!0,reflect:!0,propType:"element",propNodeName:"datalist"}});if(b.event.customEvent)b.event.customEvent.updateDatalist=!0,b.event.customEvent.updateInput=!0;d.addReady(function(b,e){e.filter("datalist > select, datalist, datalist > option, datalist > select > option").closest("datalist").triggerHandler("updateDatalist")})})()}})()});
jQuery.webshims.gcEval=function(b,d){with(d&&d.form||window)with(d||window)return function(b){eval(b)}.call(d||window,b)};
(function(b){var d=window.Modernizr,g=b.webshims;g.capturingEventPrevented=function(d){if(!d._isPolyfilled){var g=d.isDefaultPrevented,l=d.preventDefault;d.preventDefault=function(){clearTimeout(b.data(d.target,d.type+"DefaultPrevented"));b.data(d.target,d.type+"DefaultPrevented",setTimeout(function(){b.removeData(d.target,d.type+"DefaultPrevented")},30));return l.apply(this,arguments)};d.isDefaultPrevented=function(){return!(!g.apply(this,arguments)&&!b.data(d.target,d.type+"DefaultPrevented"))};
d._isPolyfilled=!0}};if(d.formvalidation){var l=b('<form action="#" style="width: 1px; height: 1px; overflow: hidden;"><select /><input type="date" required name="a" /><input type="submit" /></form>');d.bugfreeformvalidation=d.requiredSelect=!!("required"in b("select",l)[0]);if(window.opera||b.browser.webkit||window.testGoodWithFix){var n=b("input",l).eq(0),t,s=function(m){var p=["form-extend","form-message","form-native-fix"];m&&(m.preventDefault(),m.stopImmediatePropagation());clearTimeout(t);setTimeout(function(){l&&
(l.remove(),l=n=null)},9);if(!d.bugfreeformvalidation||!d.requiredSelect)g.addPolyfill("form-native-fix",{f:"forms",d:["form-extend"]}),g.modules["form-extend"].test=b.noop;g.isReady("form-number-date-api")&&p.push("form-number-date-api");g.reTest(p);if(b.browser.opera||window.testGoodWithFix)g.loader.loadList(["dom-extend"]),g.ready("dom-extend",function(){var l=function(b){b.preventDefault()};["form","input","textarea","select"].forEach(function(a){var d=g.defineNodeNameProperty(a,"checkValidity",
{prop:{value:function(){g.fromSubmit||b(this).bind("invalid.checkvalidity",l);g.fromCheckValidity=!0;var a=d.prop._supvalue.apply(this,arguments);g.fromSubmit||b(this).unbind("invalid.checkvalidity",l);g.fromCheckValidity=!1;return a}}})});d.input.list&&!(b("<datalist><select><option></option></select></datalist>").prop("options")||[]).length&&g.defineNodeNameProperty("datalist","options",{prop:{writeable:!1,get:function(){var a=this.options||[];if(!a.length){var d=b("select",this);if(d[0]&&d[0].options&&
d[0].options.length)a=d[0].options}return a}}})})};l.appendTo("head");if(window.opera||window.testGoodWithFix){g.bugs.validationMessage=!n.prop("validationMessage");if((d.inputtypes||{}).date){try{n.prop("valueAsNumber",0)}catch(m){}g.bugs.valueAsNumberSet="1970-01-01"!=n.prop("value")}n.prop("value","")}l.bind("submit",function(b){d.bugfreeformvalidation=!1;s(b)});t=setTimeout(function(){l&&l.triggerHandler("submit")},9);g.capturingEvents(["input"]);g.capturingEvents(["invalid"],!0);b("input, select",
l).bind("invalid",s).filter('[type="submit"]').bind("click",function(b){b.stopImmediatePropagation()}).trigger("click")}else g.capturingEvents(["input"]),g.capturingEvents(["invalid"],!0)}})(jQuery);
jQuery.webshims.register("form-core",function(b,d,g,l,n,t){var s={radio:1},m={checkbox:1,radio:1},u=b([]),p=function(a){var a=b(a),d=a[0].name;return s[a[0].type]&&d?b(a[0].form&&a[0].form[d]||l.getElementsByName(d)).not(a[0]):u},w=d.getContentValidationMessage=function(a,e){var g=a.getAttribute("x-moz-errormessage")||a.getAttribute("data-errormessage")||"";if(g&&-1!=g.indexOf("{")){try{g=jQuery.parseJSON(g)}catch(h){return g}"object"==typeof g&&(e=e||b.prop(a,"validity")||{valid:1},e.valid||b.each(e,
function(b,a){if(a&&"valid"!=b&&g[b])return g=g[b],!1}));d.data(a,"contentErrorMessage",g);if("object"==typeof g)g=g.defaultMessage}return g||""},a={number:1,range:1,date:1,time:1,"datetime-local":1,datetime:1,month:1,week:1};b.extend(b.expr.filters,{"valid-element":function(a){return!(!b.prop(a,"willValidate")||!(b.prop(a,"validity")||{valid:1}).valid)},"invalid-element":function(a){return!(!b.prop(a,"willValidate")||(b.prop(a,"validity")||{valid:1}).valid)},"required-element":function(a){return!(!b.prop(a,
"willValidate")||!b.prop(a,"required"))},"optional-element":function(a){return!!(b.prop(a,"willValidate")&&!1===b.prop(a,"required"))},"in-range":function(c){if(!a[b.prop(c,"type")]||!b.prop(c,"willValidate"))return!1;c=b.prop(c,"validity");return!(!c||c.rangeOverflow||c.rangeUnderflow)},"out-of-range":function(c){if(!a[b.prop(c,"type")]||!b.prop(c,"willValidate"))return!1;c=b.prop(c,"validity");return!(!c||!c.rangeOverflow&&!c.rangeUnderflow)}});["valid","invalid","required","optional"].forEach(function(a){b.expr.filters[a]=
b.expr.filters[a+"-element"]});var e=b.event.customEvent||{},q=b.prop,h={selectedIndex:1,value:1,checked:1,disabled:1,readonly:1};b.prop=function(a,d,e){var g=q.apply(this,arguments);if(a&&"form"in a&&h[d]&&e!==n&&b(a).hasClass("form-ui-invalid")&&(b.prop(a,"validity")||{valid:1}).valid)b(a).getShadowElement().removeClass("form-ui-invalid"),"checked"==d&&e&&p(a).removeClass("form-ui-invalid").removeAttr("aria-invalid");return g};var r=function(a,d){var e;b.each(a,function(a,c){if(c)return e="customError"==
a?b.prop(d,"validationMessage"):a,!1});return e};b(l).bind("focusout change refreshvalidityui",function(a){if(a.target&&"submit"!=a.target.type&&b.prop(a.target,"willValidate")){var d=b.data(a.target,"webshimsswitchvalidityclass");d&&clearTimeout(d);b.data(a.target,"webshimsswitchvalidityclass",setTimeout(function(){var d=b(a.target).getNativeElement()[0],e=b.prop(d,"validity"),g=b(d).getShadowElement(),j,f,i,h;e.valid?g.hasClass("form-ui-valid")||(j="form-ui-valid",f="form-ui-invalid",h="changedvaliditystate",
i="changedvalid",m[d.type]&&d.checked&&p(d).removeClass(f).addClass(j).removeAttr("aria-invalid"),b.removeData(d,"webshimsinvalidcause")):(e=r(e,d),b.data(d,"webshimsinvalidcause")!=e&&(b.data(d,"webshimsinvalidcause",e),h="changedvaliditystate"),g.hasClass("form-ui-invalid")||(j="form-ui-invalid",f="form-ui-valid",m[d.type]&&!d.checked&&p(d).removeClass(f).addClass(j),i="changedinvalid"));j&&(g.addClass(j).removeClass(f),setTimeout(function(){b(d).trigger(i)},0));h&&setTimeout(function(){b(d).trigger(h)},
0);b.removeData(a.target,"webshimsswitchvalidityclass")},9))}});e.changedvaliditystate=!0;e.changedvalid=!0;e.changedinvalid=!0;e.refreshvalidityui=!0;d.triggerInlineForm=function(a,e){a.jquery&&(a=a[0]);var g="on"+e,h=a[g]||a.getAttribute(g)||"",l,k,e=b.Event({type:e,target:a,currentTarget:a});h&&(d.warn(g+" used. we will drop inline event handler support, with next release. use event binding: $.bind instead"),"string"==typeof h&&(k=d.gcEval(h,a),a[g]&&(l=!0,a[g]=!1)));!1===k&&(e.stopPropagation(),
e.preventDefault());b(a).trigger(e);l&&(a[g]=h);return k};e=function(){d.scrollRoot=b.browser.webkit||"BackCompat"==l.compatMode?b(l.body):b(l.documentElement)};e();d.ready("DOM",e);d.getRelOffset=function(a,d){var a=b(a),e=b(d).offset(),g;b.swap(b(a)[0],{visibility:"hidden",display:"inline-block",left:0,top:0},function(){g=a.offset()});e.top-=g.top;e.left-=g.left;return e};d.validityAlert=function(){var a=!b.browser.msie||7<parseInt(b.browser.version,10)?"span":"label",e,h=!1,m=!1,n,k={hideDelay:5E3,
showFor:function(a,c,d,l){k._create();var a=b(a),p=b(a).getShadowElement(),q=k.getOffsetFromBody(p);k.clear();l?this.hide():(this.getMessage(a,c),this.position(p,q),e.css({fontSize:a.css("fontSize"),fontFamily:a.css("fontFamily")}),this.show(),this.hideDelay&&(h=setTimeout(n,this.hideDelay)),b(g).bind("resize.validityalert orientationchange.validityalert emchange.validityalert",function(){clearTimeout(m);m=setTimeout(function(){k.position(p)},9)}));d||this.setFocus(p,q)},getOffsetFromBody:function(b){return d.getRelOffset(e,
b)},setFocus:function(f,g){var h=b(f).getShadowFocusElement(),k=d.scrollRoot.scrollTop(),m=(g||h.offset()).top-30,o;d.getID&&"label"==a&&e.attr("for",d.getID(h));k>m&&(d.scrollRoot.animate({scrollTop:m-5},{queue:!1,duration:Math.max(Math.min(600,1.5*(k-m)),80)}),o=!0);try{h[0].focus()}catch(p){}o&&(d.scrollRoot.scrollTop(k),setTimeout(function(){d.scrollRoot.scrollTop(k)},0));setTimeout(function(){b(l).bind("focusout.validityalert",n)},10)},getMessage:function(a,c){b("span.va-box",e).text(c||w(a[0])||
a.prop("validationMessage"))},position:function(a,c){c=c?b.extend({},c):k.getOffsetFromBody(a);c.top+=a.outerHeight();e.css(c)},show:function(){"none"===e.css("display")&&e.css({opacity:0}).show();e.addClass("va-visible").fadeTo(400,1)},hide:function(){e.removeClass("va-visible").fadeOut()},clear:function(){clearTimeout(!1);clearTimeout(h);b(l).unbind(".validityalert");b(g).unbind(".validityalert");e.stop().removeAttr("for")},_create:function(){if(!e)e=k.errorBubble=b("<"+a+' class="validity-alert-wrapper" role="alert"><span  class="validity-alert"><span class="va-arrow"><span class="va-arrow-box"></span></span><span class="va-box"></span></span></'+
a+">").css({position:"absolute",display:"none"}),d.ready("DOM",function(){e.appendTo("body");b.fn.bgIframe&&b.browser.msie&&7>parseInt(b.browser.version,10)&&e.bgIframe()})}};n=b.proxy(k,"hide");return k}();(function(){var a,d=[],e;b(l).bind("invalid",function(g){if(!g.wrongWebkitInvalid){var h=b(g.target),k=h.getShadowElement();k.hasClass("form-ui-invalid")||(k.addClass("form-ui-invalid").removeClass("form-ui-valid"),setTimeout(function(){b(g.target).trigger("changedinvalid").trigger("changedvaliditystate")},
0));if(!a)a=b.Event("firstinvalid"),a.isInvalidUIPrevented=g.isDefaultPrevented,k=b.Event("firstinvalidsystem"),b(l).triggerHandler(k,{element:g.target,form:g.target.form,isInvalidUIPrevented:g.isDefaultPrevented}),h.trigger(a);a&&a.isDefaultPrevented()&&g.preventDefault();d.push(g.target);g.extraData="fix";clearTimeout(e);e=setTimeout(function(){var e={type:"lastinvalid",cancelable:!1,invalidlist:b(d)};a=!1;d=[];b(g.target).trigger(e,e)},9);k=h=null}})})();t.replaceValidationUI&&d.ready("DOM",function(){b(l).bind("firstinvalid",
function(a){a.isInvalidUIPrevented()||(a.preventDefault(),b.webshims.validityAlert.showFor(a.target,b(a.target).prop("customValidationMessage")))})})});
