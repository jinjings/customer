<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
  <base href="<%=basePath%>">
  <meta charset="utf-8">
  <title>菜单</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=0">
 	
</head>
<body>	

	
	 <div class="row">
        <div class="col-md-12">
          <div class="box box-info">
            <div class="box-header">
              <h3 class="box-title">上传临时素材
              
              </h3>
              <!-- tools box -->
              <div class="pull-right box-tools">
                
              </div>
              <!-- /. tools -->
            </div>
            <!-- /.box-header -->
            <div class="box-body pad">
              <form>
              
               <div class="form-group">
               <label for="media">素材类型</label>
               		<select name="mediaType" id="mediaType"  class="form-control" onchange="changeType(this)">
						<option value="image">图片</option>
						<option value="video">视频</option>
						<option value="voice">语音</option>
						<option value="thumb">缩略图</option>
					</select>
               </div>
               <div class="form-group">
                  	<label for="media">素材</label>
                    <input id="media" name="media" type="file" class="form-control"/>
                </div>
              </form>
            </div>
          </div>
         </div>
	 </div>
 <script type="text/javascript">
 var allowedFileExtensions=['jpg', 'png'] ;
 $(function () {
	 $('#media').fileinput({
        language: 'zh',
        uploadUrl: '${ctx}/wxMedia/uploadTmepMedia?mediaType='+$("#mediaType").val(),
        allowedFileExtensions : allowedFileExtensions
    }).on("fileuploaded", function(event, data) {
    	
        if(data.response)
        {
           // $("#logoUrl").val((data.response["url"]));
           alert(data.response);
        }
    });
 });
 function changeType(t){
	 if(t.value=="image"){
		 allowedFileExtensions=['jpg', 'png',"gif","jpeg"];
		 $('#media').fileinput("clear");
	 }else if(t.value=="video"){
		 allowedFileExtensions=['mp4'];
		 $('#media').fileinput("clear");
	 }else if(t.value=="voice"){
		 allowedFileExtensions=['amr', 'mp3'];
		 $('#media').fileinput("clear");
	 }else if(t.value=="thumb"){
		 allowedFileExtensions=['jpg'];
		 $('#media').fileinput("clear");
	 }else{
		 allowedFileExtensions=[]; 
		 $('#media').fileinput("clear");
	 }
	 
	 allowedFileExtensions
 }
</script>	
</body>

</html>