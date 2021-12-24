<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2021/12/7
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>

    <%--web路径问题
        以/开头的资源路径 需要在前面加上项目名
    --%>

    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>



    <!-- Modal -->
<div class="modal fade" id="empAndModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="W"> 女
                            </label>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                                <option value="1">开发部</option>
                                <option value="2">测试部</option>
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

    <%--员工修改的模态框--%>
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" >修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">EmpName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update_static"></p>
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender"  value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender"  value="W"> 女
                                </label>

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_update_select">
                                    <option value="1">开发部</option>
                                    <option value="2">测试部</option>
                                </select>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

<%--搭建显示页面--%>
<div class="container"></div>
<%--标题--%>
<div class="row">
    <div class="col-md-12">
        <h1>SSM-CRUD</h1>
    </div>
</div>
<%--按钮--%>
<div class="row">
    <div class="col-md-4 col-md-offset-8">
        <button class="btn btn-info" id="emp_add_model_btn">新增</button>
        <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
    </div>
</div>
<%--显示表格数据--%>
<div class="row">
    <div class="col-md-12">
        <table class="table table-hover" id="emps_table">
            <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>

            </tbody>

        </table>
    </div>
</div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

    <script type="text/javascript">
        //总记录数
        var numItems;
        //当前第几页
        var currentPage;

        //1.页面加载完成以后，直接去发生ajax请求，要到分页数据
        $(function () {
            to_page(1);
        });

        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    //1.解析并显示员工数据
                    build_emps_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析并显示分页条
                    build_page_nav(result);
                }
            });
        };

        //员工表格
        function build_emps_table(result){
            //清空table表格
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-success btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-plus")).append("编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前员工id
                editBtn.attr("edit_id",item.empId);
                var delBtn = $("<button></button>").addClass("btn btn-warning btn btn-primary btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性，来表示当前员工id
                delBtn.attr("del_id",item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                //append方法执行完成以后还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
            })
        }

        //分页信息
        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前第" + result.extend.pageInfo.pageNum + "页,总" +  result.extend.pageInfo.pages + "页,总" +  result.extend.pageInfo.total + "条记录");
            numItems = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        //分页条
        function build_page_nav(result) {
            $("#page_nav_area").empty();

            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(result.extend.pageInfo.isFirstPage == true){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }
            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            if(result.extend.pageInfo.isLastPage == true){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });


            //添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);

            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
               var numLi = $("<li></li>").append($("<a></a>").append(item));
               if(result.extend.pageInfo.pageNum == item){
                   numLi.addClass("active");
               }
               numLi.click(function () {
                    to_page(item)
               });

               ul.append(numLi);
            });
            //添加后一页和末页
            ul.append(nextPageLi).append(lastPageLi);
            
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");

        }

        //清空表单样式及内容
        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        //点击新增跳出模态框
        $("#emp_add_model_btn").click(function () {
            //清除新增里的数据 表单的数据以及表单的样式
            reset_form("#empAndModal form");

            //发出ajax请求 查出部门信息  显示在下拉列表中
            // getDepts("#empAndModal select")
            //弹出模态框
            $("#empAndModal").modal({
                backdrop:"static"
            });
        });

        //查出所有的部门信息并显示在下拉列表中   1.7版本的jq不支持 失败~
        /*function getDepts(ele) {
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    // console.log(result);
                    $.each(result.extend.depts.deptName,function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.dId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }*/

        function show_validata_msg(ele,status,msg) {
            //应该清空这个元素之前的样式
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if("success" == status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }

        }

        //校验
        function validate_add_form(){

            //1.拿到要校验的数据  使用正则表达式
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

            if(!regName.test(empName)){
                //失败
                // alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
                show_validata_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
                return false;
            }else{
                show_validata_msg("#empName_add_input","success","")
            }
            //校验邮箱信息
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

            if(!regEmail.test(email)){
                // alert("邮箱格式不正确");
                show_validata_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validata_msg("#email_add_input","success","");
            }

            return true;

        }

        $("#empName_add_input").change(function () {
            //发送ajax请求校验用户名是否可用
            var empName = this.value;
            $.ajax({
               url:"${APP_PATH}/checkuser",
               data:"empName=" + empName,
               type:"POST",
               success:function (result) {
                    if(result.code == 100){
                        //成功
                        show_validata_msg("#empName_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else{
                        //失败
                        show_validata_msg("#empName_add_input","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
               }
            });
        })
        



        //点击保存 保存员工
        $("#emp_save_btn").click(function () {
            //1.将模态框中填写的表单数据提交给服务器进行保存
            // 先对要提交给服务器的数据进行校验
            if(!validate_add_form()){
                return false;
            }
            if($(this).attr("ajax-va") == "error"){
                return false;
            }
            //2.发送Ajax请求保存员工
            $.ajax({
               url:"${APP_PATH}/emp",
               type:"POST",

               data:$("#empAndModal form").serialize(),
               success:function (result) {
                   if (result.code == 100) {
                       //1.关闭模态框
                       $("#empAndModal").modal('hide');
                       //2.来到最后一页查看添加的数据
                       //发送ajax请求显示最后一页数据
                       to_page(numItems);
                   }else {
                       console.log(result);
                   }

               }

            });
        });

        $(document).on("click",".edit_btn",function () {
             //1.查出员工信息 显示员工信息

            getEmp($(this).attr("edit_id"));

            //把员工id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));

            //发出ajax请求 查出部门信息  显示在下拉列表中
            //弹出模态框
            $("#empUpdateModal").modal({
                backdrop:"static"
            });
        });

        function getEmp(id) {
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    var empData = result.extend.emp;
                    $("#empName_update_static").text(empData.empName);
                    $("#email_update_input").val(empData.email);
                    $("#empUpdateModal input[name=gender]").val([empData.gender]);
                    $("#empUpdateModal select").val([empData.dId]);
                }
            });
        }

        //给更新按钮绑定单机事件
        $("#emp_update_btn").click(function () {
            //验证邮箱是否合法
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                // alert("邮箱格式不正确");
                show_validata_msg("#email_update_input","error","邮箱格式不正确");
                return false;
            }else {
                show_validata_msg("#email_update_input","success","");
            }

            //发送ajax请求保存更新的数据
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
                type:"POST",
                data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                success:function (result) {
                    // alert(result.msg);
                    //1.关闭模态框
                    $("#empUpdateModal").modal('hide');
                    //2.来到最后一页查看修改的数据
                    to_page(currentPage);
                }
            });

        })

        //删除根据id
        $(document).on("click",".del_btn",function () {
            //1.弹出是否确实删除对话框
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            var empId = $(this).attr("del_id");
            if(confirm("确认删除[" + empName + "吗?]")){
                $.ajax({
                   url:"${APP_PATH}/emp/"+empId,
                   type:"POST",
                   data:"&_method=DELETE",
                   success:function(result){
                        alert(result.msg);
                        //回到本页
                       to_page(currentPage);
                   }
                });
            }
        })

        //完成全选/全不选功能
        $("#check_all").click(function () {
            // $(this).prop("checked");
            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        //
        $(document).on("click",".check_item",function () {
            //判断是否选中5个 选择5个返回true  没选满返回false
            var flag = $(".check_item:checked").length==$(".check_item").length;
            $("#check_all").prop("checked",flag);
        })

        //点击全部删除 批量删除
        $("#emp_delete_all_btn").click(function () {
            var empNames = "";
            var del_idstr = "";
            $.each($(".check_item:checked"),function () {
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";

                //组装员工id字符串
                del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
            })
            //取出empNames多余的逗号
            empNames = empNames.substr(0,empNames.length - 1);
            //取出del_idstr多余的-
            del_idstr = del_idstr.substr(0,del_idstr.length - 1);
            if(confirm("确认删除["+empNames+"吗?]")){
                //发送ajax请求删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+del_idstr,
                    type:"POST",
                    data:"&_method=DELETE",
                    success:function (result) {
                        alert(result.msg);

                        to_page(currentPage);
                    }
                })
            }
        })

    </script>

</body>
</html>
