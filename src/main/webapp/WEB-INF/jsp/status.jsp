<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="common-header.jsp"%>

    <script>
        function getNowFormatDate() {
            var date = new Date();
            var seperator1 = "-";
            var seperator2 = ":";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                    + " " + date.getHours() + seperator2 + date.getMinutes()
                    + seperator2 + date.getSeconds();
            document.getElementById("timer").innerHTML = currentdate;
            return currentdate;
        }
        setInterval("getNowFormatDate()", 1000);
    </script>

</head>
<body>
    <%@include file="common-title.jsp"%>
    <div class="container-fluid-full">
        <div class="row-fluid">

        <%@include file="common-mainmenu.jsp"%>
        <noscript>
            <div class="alert alert-block span10">
                <h4 class="alert-heading">Warning!</h4>
                <p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p>
            </div>
        </noscript>

        <!-- start: Content -->
        <div id="content" class="span10">

            <ul class="breadcrumb">
                <li>
                    <i class="icon-home"></i>
                    <a href="index">Home</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li><a href="#">Status</a></li>
            </ul>
            <div>
                <h1>Status Panel</h1>
                <div class="header span12">
                    <div class="from"><i class="halflings-icon user"></i> <b>Admistrator</b> / administrator@htsc.com</div>
                    <div class="date"><i class="halflings-icon time"></i> <b id = "timer"></b> </div>
                    <div class="menu"></div>
                </div>

                <div class="span10">
                    <table id="alarmtable" class="table">
                        <caption class="header">监控状态</caption>

                        <thead>
                        <tr class="success">
                            <th>编号</th>
                            <th>名称</th>
                            <th>监控IP</th>
                            <th>监控类型</th>
                            <th>实时值</th>
                            <th>监控状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="tbodycontent">
                        </tbody>
                    </table>
                </div>

             </div><!--/.fluid-container-->
        </div>
        <!-- end: Content -->
    </div><!--/#content.span10-->
</div><!--/fluid-row-->
        <%--<div id="myModal" class="modal hide fade in" style="display: none; ">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h3>处理意见</h3>
            </div>
            <div class="modal-body">
                <textarea id="solveText" class="form-control" cols="60"></textarea>
            </div>

            <div class="modal-footer">
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" id="textSubmit">Submit</button>
                    <button class="btn btn-default" id="textCancel" data-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
        --%>
    <input id="hidenAlarmId" type="hidden" name="alarmId"/>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">处理信息</h4>
                </div>
                <div class="modal-body">
                    <textarea id="solveText" class="form-control"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="textCancel" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="textSubmit">Submit</button>
                </div>
            </div>
        </div>
    </div>

    <%@include file="common-footer.jsp"%>

    <script>
        $(function () {
            refresh();
            setInterval(refresh,10000);
        });
        function refresh(){

            $.ajax({
                type:"GET",
                async: false,
                url: "http://localhost:8081/alarm/display/status/1",
                dataType : "json",
                success:function(data){
                    var datas = eval(data);
                    var htmlInfo = '';
                    var htmlError = '';
                    var errorIndex = 0;
                    var infoIndex = 0;
                    $.each(datas,function (index, item) {

                        if(item.alarmLevel == 'ERROR' && item.alarmClear != 1){
                            htmlError += '<tr class="alert-error">';
                            htmlError += '<td >'+ item.id+'</td>';
                            htmlError += '<td>'+ item.alarmName+ '</td>';
                            htmlError += '<td>'+ item.ipSource +'</td>';
                            htmlError += '<td>'+ item.alarmType +'</td>';
                            htmlError += '<td>'+ item.alarmValue +'</td>';
                            htmlError += '<td>'+ item.alarmLevel +'</td>';
                            htmlError += '<td><a href="" data-toggle="modal" onclick="solveAlarm('+item.id+')" > Solve</a></td>';
                            htmlError += '</tr>';
                        }
                        else if(item.alarmLevel == 'ERROR'){
                            htmlInfo += '<tr class="text-warning">';
                            htmlInfo += '<td>' + item.id + '</td>';
                            htmlInfo += '<td>' + item.alarmName + '</td>';
                            htmlInfo += '<td>' + item.ipSource + '</td>';
                            htmlInfo += '<td>' + item.alarmType + '</td>';
                            htmlInfo += '<td>' + item.alarmValue + '</td>';
                            htmlInfo += '<td>' + item.alarmLevel + '</td>';
                            htmlInfo += '<td>Solved</td>';
                            htmlInfo += '</tr>';
                        }else{
                            htmlInfo += '<tr class="text-info">';
                            htmlInfo += '<td>' + item.id + '</td>';
                            htmlInfo += '<td>' + item.alarmName + '</td>';
                            htmlInfo += '<td>' + item.ipSource + '</td>';
                            htmlInfo += '<td>' + item.alarmType + '</td>';
                            htmlInfo += '<td>' + item.alarmValue + '</td>';
                            htmlInfo += '<td>' + item.alarmLevel + '</td>';
                            htmlInfo += '<td></td>';
                            htmlInfo += '</tr>';
                        }
          //              $("#tbodycontent").append(html);
                    });
                    if(htmlError != '' || htmlInfo != ''){
                        $("#tbodycontent").html("");
                        debugger;
                        $("#tbodycontent").append(htmlError);
                        $("#tbodycontent").append(htmlInfo);
                    }

                },
                error:function (e) {
                    debugger;
                    alert(e);
                }

            });
        }

        function solve(id) {
            $.ajax({
                type:"GET",
                async: false,
                url: 'http://localhost:8081/alarm/alarmInfo/solve/'+id,
                dataType : "json",
                success:function(data){
                    debugger;
                    if(data == 'success')
                        alert("处理成功，等待刷新");
                    else
                        alert("处理失败");

                },
                error:function () {
                    alert("请求失败！");
                }

            });

        }

        function solveAlarm(id) {
            $("#hidenAlarmId").val(id);
            $("#solveText").val('');
            $("#myModal").modal('show');
        }

        $("#textSubmit").click(function () {
            var text = $("#solveText").val();
            var id = $("#hidenAlarmId").val();
            $("#myModal").modal('hide');
            $.ajax({
                type:"GET",
                async: false,
                url: 'http://localhost:8081/alarm/alarmInfo/solve/'+id+'?desc='+text,
                dataType : "json",
                success:function(){
                    alert("处理成功，等待刷新");
                },
                error:function () {
                    alert("请求失败！");
                }

            });

        });

        $("#textCancel").click(function () {
            $("#myModal").modal('hide');
        });

    </script>
    <%--<script>
        $(function () { $('#myModal').modal('hide')});
    </script>--%>
   <%-- <script>
        $(function () { $('#myModal').on('hide.bs.modal', function () {
            alert('处理关闭');})
        });
    </script>--%>


</body>



</html>
