<%-- 
    Document   : management
    Created on : Nov 4, 2013, 1:03:00 PM
    Author     : wesley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="index" />
<html  lang="${language}">
    <head>
        <title>Management - Info Support</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width">

        <!-- Company Style -->
        <link rel="Shortcut Icon" href="resources/images/favicon.ico" type="image/x-icon">
        <link rel="Icon" href="resources/images/favicon.ico" type="image/x-icon">
        <!-- Bootstrap-->
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="resources/bootstrap/dist/css/bootstrap.min.css">
        <script src="resources/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="resources/bootstrap/dist/js/alert.js"></script>
        <!-- DHTMLX General -->
        <script src="resources/dhtmlx/dhtmlxTabbar/codebase/dhtmlxcommon.js"></script>
        <!-- DHTMLX Tabbar -->
        <link rel="stylesheet" type="text/css" href="resources/dhtmlx/dhtmlxTabbar/codebase/dhtmlxtabbar.css">
        <script src="resources/dhtmlx/dhtmlxTabbar/codebase/dhtmlxtabbar.js"></script>
        <script src="resources/dhtmlx/dhtmlxTabbar/codebase/dhtmlxtabbar_start.js"></script>
        <!-- DHTMLX Grid -->
        <link rel="stylesheet" type="text/css" href="resources/dhtmlx/dhtmlxGrid/codebase/dhtmlxgrid.css">
        <script src="resources/dhtmlx/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>        
        <script src="resources/dhtmlx/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>  
        <script src="resources/dhtmlx/dhtmlxGrid/codebase/ext/dhtmlxgrid_start.js"></script>
        <!-- DHTMLX Menu -->
        <script src="resources/dhtmlx/dhtmlxMenu/codebase/dhtmlxmenu.js"></script>
        <script src="resources/dhtmlx/dhtmlxMenu/codebase/ext/dhtmlxmenu_ext.js"></script>
    </head>
    <body>
        <!--Start nav bar-->
        <nav class="navbar navbar-inverse" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/PDL/homepage"><img src="resources/images/Logo.png"></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="margin-top:12px">
                <ul class="nav navbar-nav">
                    <li><a href="/PDL/homepage">Home</a></li>
                    <li><a href="/PDL/courses"><fmt:message key="navbar.course"/></a></li>
                        <c:if test="${loggedInIsAdmin || loggedInIsTeacher || loggedInIsManager == true}">                    
                        <li class="dropdown active">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Management <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="/PDL/management">Management</a></li>
                                <li class="divider"></li>
                                <li><a href="/PDL/i18n_nl">Internationalisation</a></li>
                            </ul>
                        </li>                    
                    </c:if>
                    <li><a href="/PDL/profile?id=${loggedInUserId}"><fmt:message key="navbar.profile"/></a></li>
                        <c:if test="${loggedInIsAdmin || loggedInIsManager == true}">
                        <li><a href="/PDL/vga">VGA</a></li>
                        </c:if>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Settings <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="index.jsp">Logout</a></li>
                            <li class="divider"></li>
                            <li><a href="/PDL/i18n">Internationalisation</a></li>
                            <li>
                                <a >
                                    <form>
                                        <select id="language" name="language" onchange="submit()">
                                            <option value="en_US" ${language == 'en_US' ? 'selected' : ''}>English</option>
                                            <option value="nl_NL" ${language == 'nl_NL' ? 'selected' : ''}>Nederlands</option>
                                        </select>
                                    </form>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
        <!-- eof navbar-->
        <c:if test="${loggedInIsAdmin == true}">   
            <div id="usersGrid" style="height:650px;"></div>
        </c:if>
        <c:if test="${loggedInIsAdmin || loggedInIsManager || loggedInIsTeacher == true}">   
            <div id="coursesGrid" style="height:650px;"></div>
        </c:if>
        <c:if test="${loggedInIsAdmin || loggedInIsManager == true}">   
            <div id="newsItemsGrid" style="height:650px;"></div>
        </c:if>
        </br>
        <!-- General -->
        <script>
            //contextual menu settings for the whole page (this includes only the option New)
            cmenu = new dhtmlXMenuObject();
            cmenu.setIconsPath("resources/dhtmlx/dhtmlxMenu/samples/common/images/");
            cmenu.setSkin('dhx_terrace');
            cmenu.renderAsContextMenu();
            cmenu.attachEvent('onClick', cmenuOnButtonClick);
            cmenu.loadXML("resources/dhtmlx/dhtmlxMenu/structures/general.xml");
            //add as default menu for the body
            cmenu.addContextZone(document.body);
            function cmenuOnButtonClick() {
            <c:if test="${loggedInIsAdmin == true}">
                switch (tabbar.getActiveTab()) {
                    case "t1":
                        openUserWindow(null);
                        break;
                    case "t2":
                        openCourseWindow(null);
                        break;
                    case "t3":
                        openNewsItemWindow(null);
                        break;

                }
            </c:if>
            <c:if test="${loggedInIsManager == true}">
                switch (tabbar.getActiveTab()) {
                    case "t1":
                        openCourseWindow(null);
                        break;
                    case "t2":
                        openNewsItemWindow(null);
                        break;
                }
            </c:if>
            <c:if test="${loggedInIsTeacher == true}">
                switch (tabbar.getActiveTab()) {
                    case "t1":
                        openCourseWindow(null);
                        break;
                }
            </c:if>
            }
        </script>

        <!-- User Management -->
        <script>
            var toDelete;
            //contextual menu settings for grid
            usersMenu = new dhtmlXMenuObject();
            usersMenu.setIconsPath("resources/dhtmlx/dhtmlxMenu/samples/common/images/");
            usersMenu.setSkin('dhx_terrace');
            usersMenu.renderAsContextMenu();
            usersMenu.attachEvent('onClick', usersGridOnButtonClick);
            usersMenu.loadXML("resources/dhtmlx/dhtmlxMenu/structures/users.xml");

            //grid settings
            usersGrid = new dhtmlXGridObject('usersGrid');
            usersGrid.setImagePath("resources/dhtmlx/dhtmlxGrid/codebase/imgs/");
            usersGrid.setSkin('dhx_terrace');
            usersGrid.enableContextMenu(usersMenu);
            //white space between columns
            usersGrid.enableMultiline(true);
            usersGrid.setHeader("ID, Username, First Name, Last Name, E-mail address, Position, Admin, Manager, Teacher");
            //column width in percentage
            usersGrid.setInitWidthsP('10, 10, 10, 10, 20, 19, 7, 7, 7');
            //way in which text has to be aligned
            usersGrid.setColAlign("right,left,left,left,left,left,center,center,center");
            //int=integer, str=string
            usersGrid.setColSorting("int,str,str,str,str,str,str,str,str");
            //ro=readonly, ch=checkbox
            usersGrid.setColTypes("ro,ro,ro,ro,ro,ro,ch,ch,ch");
            //disable cell editing
            usersGrid.enableEditEvents(false, false, false);
            //disable checkbox editing
            usersGrid.attachEvent("onEditCell", function(stage, rId, cInd, nValue, oValue) {
                return false;
            });
            usersGrid.init();

            //now lets build a javascript array with our users for the grid
            var users = new Array();

            <c:forEach var='user' items='${users}'>
            var row = ['${user.userId}', '${user.username}', '${user.firstname}', '${user.lastname}', '${user.emailAddress}', '${user.position}', '${user.isAdmin}', '${user.isManager}', '${user.isTeacher}'];
            users.push(row);
            </c:forEach>

            //set data in grid
            usersGrid.parse(users, "jsarray");

            //event handling for contextual menu
            function usersGridOnButtonClick(menuitemId) {
                var data = usersGrid.contextID.split("_");
                var rowIndex = data[0];
                var columnIndex = data[1];

                switch (menuitemId) {
                    case "new":
                        openUserWindow(null);
                        break;
                    case "view":
                        openUserProfile(usersGrid.cells(rowIndex, 0).getValue());
                        break;
                    case "edit":
                        openUserWindow(usersGrid.cells(rowIndex, 0).getValue());
                        break;
                    case "delete":
                        toDelete = usersGrid.cells(rowIndex, 0).getValue();
                        deleteDialog();
                        break;
                }
            }
            //variables for the sizes and location (center) of a popup
            var popupWidth = 800;
            var popupHeight = 500;
            var popupLeft = (screen.width / 2) - (popupWidth / 2);
            var popupTop = (screen.height / 2) - (popupHeight / 2);

            // view profile
            function openUserProfile(userId) {
                var uri = "profile?id=";

                if (userId !== null) {
                    uri += userId;
                }

                window.open(uri, "menubar=no" +
                        ",width=" + popupWidth + ",height=" + popupHeight +
                        ",top=" + popupTop + ",left=" + popupLeft);
            }

            //window for creating/editing a user
            function openUserWindow(userId) {
                var uri = "users/edit?userId=";
                //edit a user
                if (userId !== null) {
                    uri += userId;
                }

                //now open a new window for creating/editing a user
                window.open(uri, "_blank", "menubar=no" +
                        ",width=" + popupWidth + ",height=" + popupHeight +
                        ",top=" + popupTop + ",left=" + popupLeft);
            }

            function deleteDialog() {
                if (toDelete == 1){
                    //administrator cannot be deleted
                    document.getElementById('btnDeleteUser').style.display = 'none';
                    document.getElementById('btnDeleteUserCancel').style.display = 'none';
                    document.getElementById('btnDeleteUserOk').style.display = 'inline';
                    document.getElementById('titleUserDelete').innerHTML = '<fmt:message key="administrator.delete.title"/>';
                    document.getElementById('bodyUserDelete').innerHTML = '<fmt:message key="administrator.delete.message"/>';
                }
                else{
                    document.getElementById('btnDeleteUser').style.display = 'inline';
                    document.getElementById('btnDeleteUserCancel').style.display = 'inline';
                    document.getElementById('btnDeleteUserOk').style.display = 'none';
                    document.getElementById('titleUserDelete').innerHTML = '<fmt:message key="management.title.delete"/>';
                    document.getElementById('bodyUserDelete').innerHTML = '<fmt:message key="management.delete.user"/>';
                }
                $('#myModal').modal('show')
            }

            function deleteUser() {
                window.location = 'users/delete?userId=' + toDelete;
            }


        </script>
        <!-- Modal Dialog for Canceling -->
        <div class="modal fade" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="titleUserDelete"><fmt:message key="management.title.delete"/></h4>
                    </div>
                    <div class="modal-body">
                        <p id="bodyUserDelete"><fmt:message key="management.delete.user"/></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="btnDeleteUserCancel" class="btn btn-default" data-dismiss="modal"><fmt:message key="edit.popup.cancel"/></button>
                        <button type="button" id="btnDeleteUserOk" style="display:none" class="btn btn-primary" data-dismiss="modal">Ok</button>
                        <button type="button" id="btnDeleteUser" class="btn btn-danger" onclick="deleteUser()"><fmt:message key="edit.popup.delete"/></button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <!-- Courses Management -->
        <script>
            var toDeleteCourse;
            //contextual menu settings for grid
            coursesMenu = new dhtmlXMenuObject();
            coursesMenu.setIconsPath("resources/dhtmlx/dhtmlxMenu/samples/common/images/");
            coursesMenu.setSkin('dhx_terrace');
            coursesMenu.renderAsContextMenu();
            coursesMenu.attachEvent('onClick', coursesGridOnButtonClick);
            coursesMenu.loadXML("resources/dhtmlx/dhtmlxMenu/structures/news.xml");

            //grid settings
            coursesGrid = new dhtmlXGridObject('coursesGrid');
            coursesGrid.setImagePath("resources/dhtmlx/dhtmlxGrid/codebase/imgs/");
            coursesGrid.setSkin('dhx_terrace');
            coursesGrid.enableContextMenu(coursesMenu);
            //white space between columns
            coursesGrid.enableMultiline(true);
            coursesGrid.setHeader("ID, Name, Level, Description, Owner, Visible");
            //column width in percentage
            coursesGrid.setInitWidthsP('10, 15, 15, 30, 20, 10');
            //way in which text has to be aligned
            coursesGrid.setColAlign("right,left,left,left,left,center");
            //int=integer, str=string, date=datum
            coursesGrid.setColSorting("int,str,str,str,str,str");
            //ro=readonly, ch=checkbox
            coursesGrid.setColTypes("ro,ro,ro,ro,ro,ch");
            //disable cell editing
            coursesGrid.enableEditEvents(false, false, false);
            //disable checkbox editing
            coursesGrid.attachEvent("onEditCell", function(stage, rId, cInd, nValue, oValue) {
                return false;
            });
            coursesGrid.init();

            //now lets build a javascript array with our courses for the grid
            var courses = new Array();
            <c:if test="${loggedInIsAdmin || loggedInIsManager == true}">
                <c:forEach var='course' items='${courses}'>
            var row = ['${course.courseId}', '${course.name}', '${course.level}', '${course.description}', '${course.owner.firstname}' + ' ${course.owner.lastname}', ' ${course.isVisible}'];
            courses.push(row);
                </c:forEach>
            </c:if>

            <c:if test="${loggedInIsTeacher == true}">
                <c:forEach var='course' items='${courses}'>
                    <c:if test="${loggedInUsername == course.owner.username}">
            var row = ['${course.courseId}', '${course.name}', '${course.level}', '${course.description}', '${course.owner.firstname}' + ' ${course.owner.lastname}', ' ${course.isVisible}'];
            courses.push(row);
                    </c:if>
                </c:forEach>
            </c:if>

            //set data in grid
            coursesGrid.parse(courses, "jsarray");

            //event handling for contextual menu
            function coursesGridOnButtonClick(menuitemId) {
                var data = coursesGrid.contextID.split("_");
                var rowIndex = data[0];
                var columnIndex = data[1];

                switch (menuitemId) {
                    case "new":
                        openCourseWindow(null);
                        break;
                    case "edit":
                        openCourseWindow(coursesGrid.cells(rowIndex, 0).getValue());
                        break;
                    case "delete":
                        toDeleteCourse = coursesGrid.cells(rowIndex, 0).getValue();
                        deleteDialogCourse();
                        break;
                }
            }
            //variables for the sizes and location (center) of a popup
            var popupWidth = 800;
            var popupHeight = 500;
            var popupLeft = (screen.width / 2) - (popupWidth / 2);
            var popupTop = (screen.height / 2) - (popupHeight / 2);


            //window for creating/editing a course
            function openCourseWindow(courseId) {
                var uri = "courses/edit?courseId=";
                //edit a course
                if (courseId !== null) {
                    uri += courseId;
                }

                //now open a new window for creating/editing a course
                window.open(uri, "_blank", "menubar=no" +
                        ",width=" + popupWidth + ",height=" + popupHeight +
                        ",top=" + popupTop + ",left=" + popupLeft);
            }


            function deleteDialogCourse() {
                $('#myModalCourse').modal('show')

            }

            function deleteCourse() {
                window.location = 'courses/delete?courseId=' + toDeleteCourse;
            }

        </script>
        <!-- Modal Dialog for Canceling -->
        <div class="modal fade" id="myModalCourse">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><fmt:message key="management.title.delete"/></h4>
                    </div>
                    <div class="modal-body">
                        <p><fmt:message key="management.delete.course"/></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="edit.popup.cancel"/></button>
                        <button type="button" class="btn btn-danger" onclick="deleteCourse()"><fmt:message key="edit.popup.delete"/></button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <!-- News Item Management -->
        <script>
            var toDeleteNews;
            //contextual menu settings for grid
            newsItemsMenu = new dhtmlXMenuObject();
            newsItemsMenu.setIconsPath("resources/dhtmlx/dhtmlxMenu/samples/common/images/");
            newsItemsMenu.setSkin('dhx_terrace');
            newsItemsMenu.renderAsContextMenu();
            newsItemsMenu.attachEvent('onClick', newsItemsGridOnButtonClick);
            newsItemsMenu.loadXML("resources/dhtmlx/dhtmlxMenu/structures/news.xml");

            //grid settings
            newsItemsGrid = new dhtmlXGridObject('newsItemsGrid');
            newsItemsGrid.setImagePath("resources/dhtmlx/dhtmlxGrid/codebase/imgs/");
            newsItemsGrid.setSkin('dhx_terrace');
            newsItemsGrid.enableContextMenu(newsItemsMenu);
            //white space between columns
            newsItemsGrid.enableMultiline(true);
            newsItemsGrid.setHeader("ID, Title, Description, Modified, Editor");
            //column width in percentage
            newsItemsGrid.setInitWidthsP('10, 15, 40, 15, 20');
            //way in which text has to be aligned
            newsItemsGrid.setColAlign("right,left,left,left,left");
            //int=integer, str=string, date=datum
            newsItemsGrid.setColSorting("int,str,str,str,str");
            //ro=readonly
            newsItemsGrid.setColTypes("ro,ro,ro,ro,ro");
            //disable cell editing
            newsItemsGrid.enableEditEvents(false, false, false);
            //disable checkbox editing
            newsItemsGrid.attachEvent("onEditCell", function(stage, rId, cInd, nValue, oValue) {
                return false;
            });
            newsItemsGrid.init();

            //now lets build a javascript array with our newsItems for the grid
            var newsItems = new Array();

            <c:forEach var='newsItem' items='${newsItems}'>
            var row = ['${newsItem.newsId}', '${newsItem.title}', '${newsItem.description}', '${newsItem.updated}', '${newsItem.editedBy.firstname}' + ' ${newsItem.editedBy.lastname}'];
            newsItems.push(row);
            </c:forEach>

            //set data in grid
            newsItemsGrid.parse(newsItems, "jsarray");

            //event handling for contextual menu
            function newsItemsGridOnButtonClick(menuitemId) {
                var data = newsItemsGrid.contextID.split("_");
                var rowIndex = data[0];
                var columnIndex = data[1];

                switch (menuitemId) {
                    case "new":
                        openNewsItemWindow(null);
                        break;
                    case "edit":
                        openNewsItemWindow(newsItemsGrid.cells(rowIndex, 0).getValue());
                        break;
                    case "delete":
                        toDeleteNews = newsItemsGrid.cells(rowIndex, 0).getValue();
                        deleteDialogNews();
                        break;
                }
            }
            //variables for the sizes and location (center) of a popup
            var popupWidth = 800;
            var popupHeight = 500;
            var popupLeft = (screen.width / 2) - (popupWidth / 2);
            var popupTop = (screen.height / 2) - (popupHeight / 2);

            //window for creating/editing a newsItem
            function openNewsItemWindow(newsItemId) {
                var uri = "news/edit?newsId=";
                //edit a newsItem
                if (newsItemId !== null) {
                    uri += newsItemId;
                }

                //now open a new window for creating/editing a newsItem
                window.open(uri, "_blank", "menubar=no" +
                        ",width=" + popupWidth + ",height=" + popupHeight +
                        ",top=" + popupTop + ",left=" + popupLeft);
            }

            function deleteDialogNews() {
                $('#myModalNews').modal('show')

            }

            function deleteNewsItem() {
                window.location = 'news/delete?newsId=' + toDeleteNews;
            }


        </script>
        <!-- Modal Dialog for Canceling -->
        <div class="modal fade" id="myModalNews">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><fmt:message key="management.title.delete"/></h4>
                    </div>
                    <div class="modal-body">
                        <p><fmt:message key="management.delete.news"/></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="edit.popup.cancel"/></button>
                        <button type="button" class="btn btn-danger" onclick="deleteNewsItem()"><fmt:message key="edit.popup.delete"/></button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div id="tabbar" style="height:700px;"></div>
        <c:if test="${loggedInIsAdmin == true}">
            <script>
                tabbar = new dhtmlXTabBar("tabbar", "top");
                tabbar.setSkin('dhx_terrace');
                tabbar.setImagePath("resources/dhtmlx/dhtmlxTabbar/codebase/imgs/");

                //we load our tabbar from an xml file (because it works best)
                tabbar.loadXML("resources/dhtmlx/dhtmlxTabbar/structures/admin.xml", function() {
                    tabbar.setTabActive("t1");
                    tabbar.setContent('t1', 'usersGrid');
                    tabbar.setContent('t2', 'coursesGrid');
                    tabbar.setContent('t3', 'newsItemsGrid');
                });
            </script>
        </c:if>
        <c:if test="${loggedInIsTeacher == true}">
            <script>
                tabbar = new dhtmlXTabBar("tabbar", "top");
                tabbar.setSkin('dhx_terrace');
                tabbar.setImagePath("resources/dhtmlx/dhtmlxTabbar/codebase/imgs/");

                //we load our tabbar from an xml file (because it works best)
                tabbar.loadXML("resources/dhtmlx/dhtmlxTabbar/structures/teacher.xml", function() {
                    tabbar.setTabActive("t1");
                    tabbar.setContent('t1', 'coursesGrid');
                });
            </script>
        </c:if>
        <c:if test="${loggedInIsManager == true}">
            <script>
                tabbar = new dhtmlXTabBar("tabbar", "top");
                tabbar.setSkin('dhx_terrace');
                tabbar.setImagePath("resources/dhtmlx/dhtmlxTabbar/codebase/imgs/");

                //we load our tabbar from an xml file (because it works best)
                tabbar.loadXML("resources/dhtmlx/dhtmlxTabbar/structures/manager.xml", function() {
                    tabbar.setTabActive("t1");
                    tabbar.setContent('t1', 'coursesGrid');
                    tabbar.setContent('t2', 'newsItemsGrid');
                });
            </script>
        </c:if>
    </body>
</html>