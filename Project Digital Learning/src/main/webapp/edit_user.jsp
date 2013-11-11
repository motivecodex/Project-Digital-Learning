<%-- 
    Document   : edit_user
    Created on : Nov 10, 2013, 9:40:25 PM
    Author     : wesley
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>${update == true ? 'Edit' : 'Create'} User</title>

            <!-- DHTMLX Form -->
            <link rel="stylesheet" type="text/css" href="/PDL/resources/dhtmlxForm/codebase/skins/dhtmlxform_dhx_terrace.css">
                <script src="/PDL/resources/dhtmlx/dhtmlxForm/codebase/dhtmlxcommon.js"></script>
                <script src="/PDL/resources/dhtmlx/dhtmlxForm/codebase/dhtmlxform.js"></script>
                </head>
                <body>
                    <h1>
                        ${update == true ? 'Edit' : 'Create'} User
                        <hr width="50%" align="left"/>
                    </h1>

                    <c:choose>
                        <c:when test="${empty userId}">
                            <!-- Without userId mean a new user -->
                            <form id="newUser" action="new" method="post">
                            </c:when>
                            <c:otherwise>
                                <!-- Otherwise you are editing -->
                                <form id="editUser" action="edit" method="post">
                                </c:otherwise>
                            </c:choose> 

                            <c:if test="${errors != null}">
                                <!-- Mochten er foutmeldingen zijn, dan worden ze hier getoond -->
                                <c:forEach var="error" items="${errors}">
                                    <p><font color="red">"${error}"</font></p>
                                </c:forEach>
                            </c:if>

                            <div id="form_container" style="width:300px;height:200px;"></div>

                            <script>
                                var userForm, formData;

                                //json format structure: we use this to initialize our form
                                formStructure = [
                                    {type: "settings", position: "label-top"},
                                    {type: "block", width: 500, list: [
                                            {type: "hidden", name: 'userId'},
                                            {type: "input", name: 'username', label: 'Username', width: 200, required: true},
                                            {type: "input", name: "firstname", label: "First Name", width: 200, offsetTop: 10, required: true},
                                            {type: "input", name: "lastname", label: "Last Name", width: 200, offsetTop: 10, required: true},
                                            {type: "button", name: "save", value: "Save", offsetTop: 20},
                                            {type: "newcolumn", offset: 50},
                                            {type: "input", name: "emailAddress", label: "E-mail address", width: 200, validate: "ValidEmail", required: true},
                                            {type: "input", name: "position", label: "Position", width: 200, offsetTop: 10, required: true},
                                            {type: "checkbox", name: "isAdmin", label: "Administrator", checked: true, offsetTop: 10, position: "label-right"}
                                        ]}
                                ];

                                userForm = new dhtmlXForm("form_container", formStructure);
                                userForm.enableLiveValidation(true);
                                userForm.attachEvent("onButtonClick", function(id) {
                                    switch (id) {
                                        case 'save':
                                            if (userForm.validate()) {
                                                document.forms[0].submit();
                                            }
                                            break;
                                    }
                                });
                                //initialize the form with input if we are updating the user
                                if ('${update}') {
                                    userForm.setItemValue("userId", '${userId}');
                                    userForm.setItemValue("username", '${username}');
                                    userForm.setItemValue("firstname", '${firstName}');
                                    userForm.setItemValue("lastname", '${lastName}');
                                    userForm.setItemValue("emailAddress", '${emailAddress}');
                                    userForm.setItemValue("position", '${position}');
                                    userForm.setItemValue("isAdmin", ${isAdmin == true ? true : false});
                                }
                            </script>
                            </form>
                </body>
                </html>