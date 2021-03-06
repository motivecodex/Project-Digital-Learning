<%--
    Document   : edit_news_item
    Created on : Nov 25, 2013, 9:40:25 PM
    Author     : wesley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="index" />
<html  lang="${language}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap-->
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../resources/bootstrap/dist/css/bootstrap.min.css">
        <script src="../resources/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="../resources/bootstrap/dist/js/alert.js"></script>
        <!-- Moment JS-->
        <script src="../resources/moment/moment-m.js" type="text/javascript"></script>
        <!-- Company Style -->
        <link rel="Shortcut Icon" href="../resources/images/favicon.ico" type="image/x-icon">
        <link rel="Icon" href="../resources/images/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="../resources/css/editmode.css">

        <title><c:if test="${isUpdate == true}"><fmt:message key="edit.popup.edit"/> <fmt:message key="news.news"/> - Info Support</c:if>
                <c:if test="${isUpdate == false}"><fmt:message key="edit.popup.create"/> <fmt:message key="news.news"/> - Info Support</c:if></title>
    </head>
    <body onload="validateForm()">
        <div class="header">
            <h1>
                <c:if test="${isUpdate == true}"><fmt:message key="edit.popup.edit"/> <fmt:message key="news.news"/></c:if>
                <c:if test="${isUpdate == false}"><fmt:message key="edit.popup.create"/> <fmt:message key="news.news"/></c:if>
            </h1>
        </div>
        <c:choose>
            <c:when test="${empty newsId}">
                <!-- Without newsId means a new newsItem -->
                <form id="newNewsItem" action="new" method="post">
                </c:when>
                <c:otherwise>
                    <!-- Otherwise you are editing -->
                    <form id="editNewsItem" action="edit" method="post">
                    </c:otherwise>
                </c:choose>

                <!-- Bootstrap alerts -->
                <c:if test="${newsItemCreated == true}">
                    <div class="alert alert-success" style="margin-left:20px;margin-right:20px">
                        <a class="close" data-dismiss="alert">×</a>
                        <strong><fmt:message key="popup.done"/></strong> <fmt:message key="news.new"/>
                    </div>
                </c:if>
                <c:if test="${newsItemUpdated == true}">
                    <div class="alert alert-success" style="margin-left:20px;margin-right:20px">
                        <a class="close" data-dismiss="alert">×</a>
                        <strong>Done!</strong> <fmt:message key="news.update"/>
                    </div>
                </c:if>
                <c:if test="${errors != null}">
                    <script>
                        //concat the errors in a var
                        var errors = '<strong>Oh snap! </strong>';

                        <c:forEach var="error" items="${errors}" varStatus="count">
                        errors += '${error}';
                        </c:forEach>
                    </script>
                    <div class="alert alert-danger" style="margin-left:20px;margin-right:20px">
                        <a class="close" data-dismiss="alert">×</a>
                        <script>
                            document.write(errors);
                        </script>
                    </div>
                </c:if>
                <div id="validationAlert" style="margin-left:20px;margin-right:20px"></div>
                <!-- End of Bootstrap alerts -->

                <div id="form_container">
                    <div class="leftContainer">

                        <input type="hidden" id="newsId" name="newsId">
                        <div class="form-group" id="formGroupTitle" style="width:100%">
                            <label for="title"><fmt:message key="news.title"/></label>
                            <input type="text" class="form-control" id="title" name="title" onchange="validateForm()" placeholder="<fmt:message key="placeholder.title"/>">
                        </div>
                        <div class="form-group" id="formGroupDate" style="width:50%">
                            <label for="date"><fmt:message key="news.date"/></label>
                            <input type="date" class="form-control" id="date" name="date" onchange="validateForm()">
                        </div>
                        <div class="form-group" id="formGroupEditedBy" style="width:50%">
                            <label for="editedByValues"><fmt:message key="news.editor"/></label>
                            <select class="form-control" id="editedByValues" name="editedByValues" onchange="validateForm()">
                                <c:forEach var='user' items='${users}'>
                                    <option value="${user.userId}" ${user.userId == editedBy.userId ? 'selected' : ''}>${user.firstname} ${user.lastname}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="rightContainer">
                        <div class="form-group" id="formGroupDescription" style="width:100%">
                            <label for="description"><fmt:message key="news.description"/></label>
                            <textarea class="form-control" rows="4" id="description" name="description" onchange="validateForm()" placeholder="<fmt:message key="placeholder.description"/>"></textarea>
                        </div>

                    </div>
            </form>
        </div>
        <script>
            //initialize the form with variables if available
            document.getElementById('newsId').value = '${newsId}';
            document.getElementById('title').value = '${title}';
            document.getElementById('description').value = '${description}';
            console.log('date is: ' + moment('${date}', "YYYY-MM-DD"));
            document.getElementById('date').value = '${date}';
                    

            //close window
            function closeWindow() {
                console.log('canceling');
                $('#myModal').modal('show')
            }

            //function to refresh the parent window to reflect the updated data in the grid
            var isModified = false; // true when the form was submitted
            window.onunload = function() {
                if (isModified){ // only on save/edit
                    window.opener.location.reload();
                }
            };

            //set input color for validations
            function setValidated(id, isValidated) {
                if (isValidated) {
                    document.getElementById(id).className = 'form-group has-success';
                }
                else {
                    document.getElementById(id).className = 'form-group has-error';
                }
            }
            //use the same validations that are used on the server side
            function validateForm() {
                var regexRegular = '^.{1,100}$';

                errors = "";
                //title
                var title = document.getElementById('title').value;
                if (!title || !title.match(regexRegular)) {
                    setValidated('formGroupTitle', false);
                    errors += 'Title must be 1-100 characters in size. ';
                }
                else {
                    setValidated('formGroupTitle', true);
                }
                //description
                var description = document.getElementById('description').value;
                if (!description || !description.match(regexRegular)) {
                    setValidated('formGroupDescription', false);
                    errors += 'Description must be 1-100 characters in size. ';
                }
                else {
                    setValidated('formGroupDescription', true);
                }
                //date
                var date = document.getElementById('date').value;
                var dateMoment = moment(date);
                
                if (!date || !dateMoment.isValid()) {
                    setValidated('formGroupDate', false);
                    errors += 'Date may not be empty. ';
                }
                else {
                    setValidated('formGroupDate', true);
                }
                //editedBy
                var editedBy = document.getElementById('editedByValues').value;
                if (!editedBy) {
                    setValidated('formGroupEditedBy', false);
                    errors += 'Editor must be chosen. ';
                }
                else {
                    setValidated('formGroupEditedBy', true);
                }

                //return true if there are errors
                if (errors) {
                    return true;
                }
                else {
                    return false;
                }
            }
            //save button press
            function saveForm() {
                if (validateForm()) {
                    document.getElementById('validationAlert').innerHTML = '<div class="alert alert-danger"><a class="close" data-dismiss="alert">×</a><strong>Oh snap!</strong> ' + errors + '</div>';
                }
                else {
                    isModified = true; // set true so we have to refresh the parent when closing
                    document.getElementById('validationAlert').innerHTML = '';
                    //check to see which form we need to submit (edit or new)
                    if (!document.getElementById('newsId').value) {
                        document.getElementById('newNewsItem').submit();
                    }
                    else {
                        document.getElementById('editNewsItem').submit();
                    }
                }
            }
        </script>
        <hr style="width:100%;margin-top:370px"/>
        <div style="float:right;margin-right:20px;margin-top:-10px;margin-bottom:10px">

            <button type="button" class="btn btn-default" onclick="closeWindow()"><fmt:message key="edit.popup.cancel"/></button>
            <button type="button" class="btn btn-primary" onclick="saveForm()"><fmt:message key="edit.popup.save"/></button>
        </div>
        <!-- Modal Dialog for Canceling -->
        <div class="modal fade" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><fmt:message key="edit.popup.unsaved"/></h4>
                    </div>
                    <div class="modal-body">
                        <p><fmt:message key="edit.popup.confirmation.message"/></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal"><fmt:message key="edit.popup.continue"/></button>
                        <button type="button" class="btn btn-primary" onclick="window.close()"><fmt:message key="edit.popup.yes"/></button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
</body>
</html>