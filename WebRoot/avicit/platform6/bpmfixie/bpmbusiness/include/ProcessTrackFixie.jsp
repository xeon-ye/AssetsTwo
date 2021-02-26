<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>

<%
	String processInstanceId = request.getParameter("processInstanceId");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程跟踪</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
</head>

<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';
var processInstanceId = '<%=processInstanceId%>';
	$(function() {
		var div = $("#bpmImageDiv").width("100%").height("100%").css({
			overflow : "auto",
			zindex : "300",
			position : "relative"
		});
		var img = $("#img").attr("src", "platform/bpm/clientbpmdisplayaction/getfiguretrack.gif?processInstanceId=" + processInstanceId);
		img.appendTo(div);
		ajaxRequest("POST", "processInstanceId=" + processInstanceId, "platform/bpm/clientbpmdisplayaction/getgraphcoordinate", "json", "draw");
	});

	function draw(obj) {
		var currentArray = obj.redsquare;
		if (currentArray != null && currentArray.length > 0) {
			for ( var current in currentArray) {
				var xywh = currentArray[current];
				var array = xywh.split(",");
				var x = array[0];
				var y = array[1];
				var w = array[2];
				var h = array[3];
				var name = array[4];
				$("#bpmImageDiv").append("<div onmouseover='createTip(\"" + name + "\",this,event);' onmouseout='hiddenTip();' style='z-index:400;position:absolute;border:3px solid red;left:" + x + "px;top:" + y + "px;width:" + w + "px;height:" + h + "px;'></div>");
			}
		}

		var histArray = obj.greensign;
		if (histArray != null && histArray.length > 0) {
			for ( var hist in histArray) {
				var xywh = histArray[hist];
				var array = xywh.split(",");
				var x = array[0];
				var y = array[1];
				var w = array[2];
				var h = array[3];
				var name = array[4];
				$("#bpmImageDiv").append("<div onmouseover='createTip(\"" + name + "\",this,event);' onmouseout='hiddenTip();' style='background:url(static/images/platform/bpm/client/images/tick.png) no-repeat center;z-index:400;position:absolute;left:" + x + "px;top:" + y + "px;width:" + w + "px;height:" + h + "px;'></div>");
			}
		}
		//debugger;
		var divObj = $("#bpmImageDiv");
		var jG = new jsGraphics(divObj);
		jG.setColor("red");
		jG.setStroke(3);
		var lineArray = obj.redline;
		if (lineArray != null && lineArray.length > 0) {
			for ( var line in lineArray) {
				var xywh = lineArray[line];
				var array = xywh.split(",");
				var x1 = array[0];
				var y1 = array[1];
				var x2 = array[2];
				var y2 = array[3];
				if (x1 != null && x1 != "") {
					jG.drawLine(parseInt(x1), parseInt(y1), parseInt(x2), parseInt(y2));
				}
			}
			jG.paint(divObj);
		}
	}

	var posx = "";
	var posy = "";
	function createTip(name, obj, event) {
		posx = getPointerX(event);
		posy = getPointerY(event);
		ajaxRequest("POST", "processInstanceId=" + processInstanceId + "&activityName=" + name, "platform/bpm/clientbpmdisplayaction/gettracktip", "json", "drawTip");
	}
	function drawTip(obj) {
		$('#bpmImageDiv').append("<div id='div_tip' style='z-index:600;background-color:#fdfcc2;position: absolute'></div>");
		var divObj = $("#div_tip").show();
		var tracks = obj.tracks;
		var histActivity = obj.histActivity;
		var tab = "";
		if (histActivity != null) {
			var currentActiveLabel = histActivity.alias;
			var consumeTime = histActivity.consumeTime;
			var iTime = histActivity.sTime;
			var eTime = histActivity.eTime;
			tab += "<table style=margin:3px 3px 3px 3px; width=400px>";
			tab += "<tr>";
			tab += "<td width=50%><font color=blue>节点：" + replaceNull2Space(currentActiveLabel) + "</font></td>";
			tab += "<td width=50%><font color=blue>耗时：" + replaceNull2Space(consumeTime) + "</font></td>";
			tab += "</tr>";
			tab += "<tr>";
			tab += "<td width=50%><font color=blue>开始：" + replaceNull2Space(iTime) + "</font></td>";
			tab += "<td width=50%><font color=blue>结束：" + replaceNull2Space(eTime) + "</font></td>";
			tab += "</tr>";
			tab += "</table>";

			if (histActivity.type != null && histActivity.type != 'start') {
				tab += "<table style=border-collapse:collapse;margin:3px 3px 3px 3px; cellpadding=3 cellspacing=3 border=1 width=400px>";
				tab += "<tr><th width=50px>接收人</th><th width=50px>处理人</th><th width=165px>意见</th><th width=125px>时间</th></tr>";
				for ( var t in tracks) {
					var track = tracks[t];
					if (replaceNull2Space(track.assigneeName) == '') {
						continue;
					}
					tab += "<tr><td width=40px>" + replaceNull2Space(track.assigneeName) + "</td><td width=40px>" + replaceNull2Space(track.operateUserName) + "</td><td width=160px>" + replaceNull2Space(track.message) + "</td><td width=80px>" + replaceNull2Space(track.eTime) + "</td></tr>";
					if (t > 1) {
						tab += "<tr><td>......</td><td>......</td><td>......</td><td>......</td></tr>";
						break;
					}
				}
			}

			tab += "</table>";
		}
		divObj.css({
			left : (posx + 10) + "px",
			top : (posy - 80) + "px"
		});
		divObj.html(tab);

	}
	function hiddenTip() {
		$("#div_tip").hide();
	}
</script>
<body class="easyui-layout" fit="true">
	<div id="bpmImageDiv">
		<img id="img" />
	</div>
</body>
</html>