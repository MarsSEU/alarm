<%--
  Created by IntelliJ IDEA.
  User: dnbsxs88
  Date: 2016/7/27
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="common-header.jsp"%>

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
                <li><a href="#">Items</a></li>
            </ul>
            <div id="cfg" class="scroll-pane">
                <!--配置 Items-->
                <div class="row-fluid sortable">
                    <div class="box span12">
                        <!--header start-->
                        <div class="box-header" data-original-title>
                            <h2><i class="halflings-icon edit"></i><span class="break"></span>Items Congifuration</h2>
                            <div class="box-icon">
                                <a href="#" class="btn-setting"><i class="halflings-icon wrench"></i></a>
                                <a href="#" class="btn-minimize"><i class="halflings-icon chevron-up"></i></a>
                                <a href="#" class="btn-close"><i class="halflings-icon remove"></i></a>
                            </div>
                        </div>
                        <!--Header end-->
                        <!--content start-->
                        <div class="box-content">
                            <form class="form-horizontal" id="itemForm" method="post" action="">
                                <fieldset>
                                    <div class="control-group">
                                        <label class="control-label" for="itemName">Item Name</label>
                                        <div class="controls">
                                            <input class="input-xlarge focused" id="itemName" name="name" type="text">
                                        </div>
                                    </div>


                                    <div class="control-group">
                                        <label class="control-label" for="monitorType" >Monitor Type</label>
                                        <div class="controls">
                                            <select id="monitorType" name="monitorTypeNo">

                                            </select>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label" for="monitorTarget">Monitor Target</label>
                                        <div class="controls">
                                            <select id="monitorTarget" name="monitorTargetNo" >

                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="monitorHost">Monitor Host</label>
                                        <div class="controls">
                                           <select id="monitorHost" name="hostId" >
                                           </select>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label" for="updateInterval">Update Interval</label>
                                        <div class="controls">
                                            <input class="input-xlarge focused" id="updateInterval" name="updateInterval" type="text">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="itemStatus">Enable</label>
                                        <div class="controls">
                                            <select id="itemStatus" name="status" data-rel="chosen">
                                                <option value="1" selected="selected">Yes</option>
                                                <option value="0">No</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label" for="historyKeep">History Keep</label>
                                        <div class="controls">
                                            <input class="input-xlarge focused" id="historyKeep" name="historyKeep" type="text">
                                        </div>
                                    </div>

                                    <div class="form-actions">
                                        <button type="submit" class="btn btn-primary" id="itemSubmit" onclick="saveItem()">Save Item</button>
                                        <button class="btn", id="itemCancel", onclick="cancleItem()">Cancel</button>
                                    </div>
                                </fieldset>
                            </form>

                        </div>
                        <!--content end-->
                    </div><!--/span-->

                </div><!--/row-->
                <!--配置 Items结束-->


            </div>
            <!-- end: Content -->
        </div><!--/#content.span10-->
    </div><!--/fluid-row-->
</div>

    <%@include file="common-footer.jsp"%>

    <script>
            var typeData;
            var targetData;
            var hostData;
            $(document).ready(function () {
                $.ajax({
                    type:"GET",
                    url: "http://localhost:8081/alarm/monitor/query/monitorType",
                    dataType : "json",
                    success:function(data){
                        debugger;
                        typeData = eval(data);
                        debugger;
                        $.each(typeData,function (index, item) {
                            debugger;
                            var html = '';
                            html += '<option value='+ item.id+'>'+item.name+'</option>';
                            $("#monitorType").append(html);
                        });
                    },
                    error:function (e) {
                        debugger;
                        alert(e);
                    }

                });
                $("#monitorType").show();
            });

            $(document).ready(function () {
                $.ajax({
                    type:"GET",
                    url: "http://localhost:8081/alarm/monitor/query/monitorTarget",
                    dataType : "json",
                    success:function(data){
                        debugger;
                        targetData = eval(data);
                        debugger;
                        var type = $("#monitorType").val();
                        $.each(targetData,function (index, item) {
                            debugger;
                            var html = '';
                            if(item.typeId == type) {
                                html += '<option value=' + item.id + '>' + item.name + '</option>';
                                $("#monitorTarget").append(html);
                            }
                        });
                    },
                    error:function (e) {
                        debugger;
                        alert(e);
                    }

                });
            });

             $("#monitorType").change(function () {
                debugger;
                var type = $("#monitorType").val();
                $("#monitorTarget").empty();
                $.each(targetData,function (index, item) {
                    debugger;
                    var html = '';
                    if(item.typeId == type) {
                        html += '<option value=' + item.id + '>' + item.name + '</option>';
                        $("#monitorTarget").append(html);
                    }
                 });
             });

              $(document).ready(function () {
                   $.ajax({
                        type:"GET",
                        url: "http://localhost:8081/alarm/monitor/query/monitorHost",
                        dataType : "json",
                        success:function(data){
                             debugger;
                             hostData = eval(data);
                             debugger;
                             $.each(hostData,function (index, item) {
                                debugger;
                                var html = '';
                                html += '<option value=' + item.hostId + '>' + item.hostName + '</option>';
                                $("#monitorHost").append(html);

                             });
                        },
                        error:function (e) {
                            debugger;
                            alert(e);
                        }

                    });
              });


            function serializeFromToJson($selector) {
                var o = {};
                var a = $selector.serializeArray();
                $.each(a, function() {
                    if (o[this.name]) {
                        if (!o[this.name].push) {
                            o[this.name] = [ o[this.name] ];
                        }
                        o[this.name].push(this.value || '');
                    } else {
                        o[this.name] = this.value || '';
                    }
                });
                return o;
            }


            function saveItem() {
                $.ajax({
                    type:'POST',
                    async:false,
                    url: "http://localhost:8081/alarm/config/item/insert",
                    data:"["+JSON.stringify(serializeFromToJson($("#itemForm")))+"]",
                    dataType:'json',
                    contentType: "application/json;charset=UTF-8",
                    success:function (data) {
                        $("#itemForm").clear;
                        alert("插入成功！");
                     },
                    error:function (data) {
                        alert("插入失败...."+data);
                    }
                })
            }

            function cancleItem() {
                $("#itemForm").clean();
            }

        </script>

</body>
</html>
