angular.module('user', ['ui.router'])
		.config(['$stateProvider','$urlRouterProvider', function($stateProvider,$urlRouterProvider) {
			$urlRouterProvider.otherwise("/userInfo");
			
			$stateProvider.state('userInfo',{
				url:'/userInfo',
				views:{
					'content':{
						templateUrl : 'user/userInfo.html',
						controllerAs : 'v',
						controller : ['$scope', function(scope) {
							var that = this;
							var $file = null;
							that.change = function(files){
								$file = files[0]
								lrz(files[0], {
			                        width: 480,//图片宽度
			                        quality: 0.9 //图片质量
				                    },
				                    function (rst) {
				                    	var show_img = new Image();
				                        show_img.src = rst.base64; //加密图片流
				                        scope.$apply(function(){
				                        	that.member.userPic = show_img.src;
				                        });
				                    }
				                );
							};
							
							that.updateInfo = function() {
								var member = that.member;
								
								if (member.nickName.trim() === "") {
									alertPopup("请输入昵称");
									return;
								}
								if (member.userPhone.trim() === "") {
									alertPopup("请输入手机号");
									return;
								}
								var formdata = new FormData();
								formdata.append("nickName", member.nickName);
								formdata.append("userPhone", member.userPhone);
								formdata.append("userPic", $file);
								$.ajax({
									url : frontUrl + 'user/updateInfo',
									type : 'POST',
									data : formdata,
									async : false,
									cache : false,
									contentType : false,
									processData : false,
									dataType : "json",
									success : function(data) { // 请求成功后处理函数。
										if (data.success) {
											alertPopup(data.message);
										} else {
											alertPopup(data.message);
										}
									},
									error : function() {
									}
								});
							};
						} ]
					}
				}
			});
			
			$stateProvider.state('address',{
				url:'/address',
				cache:false,
				views:{
					'content':{
						templateUrl:'user/address.html',
						controllerAs:'v',
						controller:[function(){
							var that = this;
							that.tab = 'add';
							that.info = {};
							that.page = {
								list:[],
								pageNumber:2
							};
							that.totalPage = [];
							that.cutTab = function(op){
								that.tab = op;
							};
							
							that.pageList = function(page){
								if(page<1 || page > that.page.pageNumber ){
									return;
								}
								ajaxPOST(frontUrl+"address/addressList",{page:page},function(data){
									if(data.success){
										var totalPage = data.data.totalPage,$totalPage=[];
										for(var i=0;i<totalPage;i++){
											$totalPage.push(i);
										}
										that.totalPage = $totalPage;
										that.page = data.data;
									}
								});
							};
							that.pageList(1);
						}]
					}
				}
			});
			
			$stateProvider.state('demand',{
				url:'/address',
				cache:false,
				views:{
					'content':{
						controllerAs:'v',
						templateUrl:'user/demand.html',
						controller:[function(){
							var that = this;
							that.tab = 'add';
							that.info = {};
							that.page = {
								list:[],
								pageNumber:2
							};
							that.totalPage = [];
							that.cutTab = function(op){
								that.tab = op;
							};
							
							that.pageList = function (page){
								if(page<1 || page > that.page.pageNumber ){
									return;
								}
								ajaxPOST(frontUrl+"user/demandRecord",{page:page},function(data){
									if(data.success){
										var totalPage = data.data.totalPage,$totalPage=[];
										for(var i=0;i<totalPage;i++){
											$totalPage.push(i);
										}
										that.totalPage = $totalPage;
										that.page = data.data;
									}
								});
							}
							that.pageList(1);
							
						}]
					}
				}
			});
			
			$stateProvider.state('feedback',{
				url:'/feedback',
				cache:false,
				views:{
					'content':{
						conctroller:'v',
						templateUrl:'user/userFeedback.html',
						controller:[function(){
							var that = this;
						}]
					}
				}
			});
			
			$stateProvider.state('notice',{
				url:'/notice',
				cache:false,
				views:{
					'content':{
						conctroller:'v',
						templateUrl:'user/notice.html',
						controller:[function(){
							var that = this;
						}]
					}
				}
			});
			
			$stateProvider.state('setting',{
				url:'/setting',
				cache:false,
				views:{
					'content':{
						conctroller:'v',
						templateUrl:'user/setting.html',
						controller:[function(){
							var that = this;
							
							
						}]
					}
				}
			});
		} ])
		.controller('contentCtrl', ['$state','$scope', function($state,scope) {
			var that = this,initState=true;
			that.tabName = 'userInfo';
			that.userInfo = {}; // 用户个人信息
			that.pageJump = function(url){
				that.tabName = url;
				$state.go(url);
			};
			
			that.initTab = function(){
				if(initState){
					initState = false;
					scope.$on('$stateChangeStart', function (event, toState, toParams, fromState, fromParams) {
						that.tabName = toState.name;
					});
				}
			};
			
		}])
		.directive('bootstrapSwitch',[function(){
			return {
				restrict : 'A',
				controller : ['$scope','$element','$attrs',
				          function(scope, ele, attr){
					$(ele).bootstrapSwitch();
				}],
				controllerAs : 'v',
				replace : true,
				bindToController : {
					src : '=httpImg'
				},
				scope : {}
			}
		}])
		
		
		.directive(
				'httpImg',
				[ function() {
					return {
						restrict : 'A',
						controller : ['$scope','$element','$attrs',
								function(scope, ele, attr) {
									var $ele = $(ele), error, listing = (attr.listing || attr.listing == 'true'),
									picType = {
										headPic : 'images/pro_pic_default.png'
									};
									if (attr.picType) {
										error = picType[attr.picType];
									} else {
										error = (attr.error || 'images/wzp.png');
									}
									var watch = scope.$watch('v.src',function(value) {
										if (value) {
											if (value.indexOf("base64") >= 0 || value.indexOf("http") >= 0) {
												if (value.indexOf("http") >= 0) {
													showImg(value);
												} else {
													$ele.attr('src',value);
												}
											} else {
												showImg(common.domain + value);
											}
											if (!listing) {
												watch(); // 取消监听
												watch = undefined;
											}

										} else {
											$ele.attr('src',error);
										}
									});
									var showImg = function(value) {
										$ele.attr('src', error);
										var img = new Image();
										img.src = value;
										if (img && img.complete) {
											$ele.attr('src', value);
											img = null;
											return;
										}
										if (img) {
											img.onload = function() {
												$ele.attr('src', value);
												img = null;
											};
										}
									};

									$ele[0].onerror = function() {
										$ele.attr('src', error);
									};
									scope.$on('$destroy', function() {
										if (!listing) {
											watch && watch();
										}
									});
								} ],
						controllerAs : 'v',
						replace : true,
						bindToController : {
							src : '=httpImg'
						},
						scope : {}
					}
				} ])// 新图片格式
			;
