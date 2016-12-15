var isIE = !!document.all;
/*首页初始化*/
function initIndex()
{
	timer = window.setInterval("Transfer()", 3000);
	bindTransfer();
}
/*创建相册页面初始化*/
function initAlbumCreate()
{
	bindSelector("privency");
}
/*上传照片页面初始化*/
function initPhotoUpload()
{
	bindSelector("albumId");
}

//幻灯显示照片
function Transfer()
{
	var transImage = document.getElementById("transImage");
	var lis = transImage.parentNode.getElementsByTagName("LI");
	transImage.src = "images/photo_"+ currentId +".jpg";
	for(li in lis) lis[li].className = "";
	lis[currentId - 1].className = "current";
	currentId++;
	if(currentId > 2) currentId = 1;
}

//绑定幻灯事件
function bindTransfer()
{
	var transImage = document.getElementById("transImage");
	var lis = transImage.parentNode.getElementsByTagName("LI");
	transImage.onmouseover = function() {
		clearInterval(timer);
	}
	transImage.onmouseout = function() {
		timer = window.setInterval("Transfer()", 3000);
	}
	for(li in lis) {
		lis[li].onclick = function(){
			currentId = parseInt(this.innerHTML);
			Transfer();
		}
	}
}

//绑定下拉列表
function bindSelector(id)
{
	var input = document.getElementById(id);
	var selecter = input.parentNode.getElementsByTagName("ul")[0];
	var option = selecter.getElementsByTagName("li");
	input.onclick = function(){
		selecter.className = selecter.className == "hide" ? "show" : "hide";
	}
	for(o in option) {
		option[o].onclick = function(){
			input.value = this.childNodes[0].innerHTML;
			selecter.className = "hide";
		}
	}
	document.documentElement.onclick = function(){
		selecter.className = "hide";
	}
	input.parentNode.onclick = function(event){
		if(isIE) {
			window.event.cancelBubble = true;
		} else {
			event.stopPropagation();
		}
	}
}

//相册删除按钮
function toggleCloseButton(obj,ishow)
{
	var em = obj.getElementsByTagName("em")[0];
	em.style.visibility = ishow ? "visible" : "hidden";
}
function deleteAlbum(id)
{
	if(confirm("确实要删除该相册吗？此操作不可恢复。")) {
		alert("删除成功！");
	}
}

//评论相关
function replyIt(txt,id)
{
	document.getElementById("commentBox").value = "回复"+ txt + ":";
}