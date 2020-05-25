var ajaxPOST = function(url, data, callback) {
	$.ajax({
		type : "POST",
		url : url,
		dataType : "json",
		cache : false,
		timeout : 30000,
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		data : data,
		success : function(data) {
			callback(data);
		},
		error : function(data) {
		}
	});
};

var ajaxHTML = function(url, data, callback) {
	$.ajax({
		type : "POST",
		url : url,
		dataType : "html",
		cache : false,
		timeout : 30000,
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		data : data,
		success : function(data) {
			callback(data);
		},
		error : function(data) {
		}
	});
};

var alertPopup = function(title,callback) {
	var $popup = $(".alert-popup");
	$popup.find($(".gr_zl_info")).html(title);
	$popup.addClass('is-visible4');
	$popup.find($(".cd-popup-close")).on(
			'click',
			function(event) {
				if ($(event.target).is('.cd-popup-close')
						|| $(event.target).is('.cd-popup4')) {
					event.preventDefault();
					$popup.removeClass('is-visible4');
				}
			});
	$popup.find("button").on('click', function(event) {
		event.preventDefault();
		if(callback)callback();
		$popup.removeClass('is-visible4');
	});
}


//读取cookies 
function readCookie(name) { 
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg)){
        return unescape(arr[2]); 
    }else{
        return null;
    }
}


//写cookies 
function setCookie(name,value) { 
    var days = 1; 
    var exp = new Date(); 
    exp.setTime(exp.getTime() + days*24*60*60*1000); 
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString(); 
} 

function delCookie(name) { 
    var cval=readCookie(name); 
    if(cval!=null){
        document.cookie= name + "="+cval+";expires="+(new Date(0)).toGMTString();
    }
} 