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
 	<!-- CK Editor -->


</head>
<body>	

	
	 <div class="row">
        <div class="col-md-12">
          <div class="box box-info">
            <div class="box-header">
              <h3 class="box-title">上传图文素材
              
              </h3>
              <!-- tools box -->
              <div class="pull-right box-tools">
                
              </div>
              <!-- /. tools -->
            </div>
            <!-- /.box-header -->
            <div class="box-body pad">
              <form action="${ctx }/wxMedia/addNews" method="post">
              <div class="form-group">
                <label for="title">标题</label>
                <input id="title" name="title" type="text" class="form-control"/>
              </div>
              <div class="form-group">
                <label for="thumbMediaId">封面图片素材id</label>
                <input id="thumbMediaId" name="thumbMediaId" type="text" class="form-control"/>
              </div>
              <div class="form-group">
                <label for="author">作者</label>
                <input id="author" name="author" type="text" class="form-control"/>
              </div>
               <div class="form-group">
               <label for="digest">摘要，仅有单图文消息才有摘要，多图文此处为空</label>
               	<input id="digest" name="digest" type="text" class="form-control"/>

               </div>
               <div class="form-group">
               <label for="showCoverPic">是否显示封面</label>
               
               	<select id="showCoverPic" name="showCoverPic" class="form-control">
               		<option value="0">否</option>
               		<option value="1">是</option>
               	</select>

               </div>
               <div class="form-group">
                  	<label for="contentSourceUrl">原文地址</label>
                    <input id="contentSourceUrl" name="contentSourceUrl" type="text" class="form-control"/>
                </div>
                
                <div class="form-group">
                <label for="content">具体内容</label>
                  <textarea id="content" name="content" rows="10" cols="80"></textarea>
                </div>
                
                   <div class="box-footer">
              
	                <button type="submit" id="saveCard" class="btn btn-primary">保存</button>
	                
	              </div>
               	  
              </form>
            </div>
          </div>
         </div>
	 </div>
	 <!-- CK Editor -->

<!-- Bootstrap WYSIHTML5 -->
 <script type="text/javascript">
 var allowedFileExtensions=['jpg', 'png'] ;
 $(function () {
	 $('#media').fileinput({
        language: 'zh',
        uploadUrl: '${ctx}/wxMedia/uploadMedia?mediaType='+$("#mediaType").val(),
        allowedFileExtensions : allowedFileExtensions
    }).on("fileuploaded", function(event, data) {
    	
        if(data.response)
        {
           // $("#logoUrl").val((data.response["url"]));
           alert(data.response);
        }
    });
	 
	 $("#content").wysihtml5();
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