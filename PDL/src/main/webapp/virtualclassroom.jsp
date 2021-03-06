<%-- 
    Document   : virtualclassroom
    Created on : 2-dec-2013, 10:56:56
    Author     : Joshua
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="index" />

<!DOCTYPE html>
<html  lang="${language}">
    <head>
        <!--Company Style-->
        <link rel="stylesheet" type="text/css" href="../resources/css/virtualclassroom.css">
        <link rel="icon" href="../resources/images/favicon.ico" type="image/x-icon"></link>
        <!-- Bootstrap-->
        <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="../resources/bootstrap/dist/css/bootstrap.min.css">
        <script src="../resources/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="../resources/bootstrap/dist/js/alert.js"></script>
        <!-- Chat -->
        <script src="http://31.186.175.82:5001/socket.io/socket.io.js"></script>
        <!-- Moment JS-->
        <script src="../resources/moment/moment-m.js" type="text/javascript"></script>
        <!-- Player -->
        <link href="http://vjs.zencdn.net/4.3/video-js.css" rel="stylesheet">
        <script src="http://vjs.zencdn.net/4.3/video.js"></script>
        <style type="text/css">
            .vjs-default-skin .vjs-play-progress,
            .vjs-default-skin .vjs-volume-level { background-color: #596063 }
            .vjs-default-skin .vjs-control-bar,
            .vjs-default-skin .vjs-big-play-button { background: rgba(8,7,7,0.7) }
            .vjs-default-skin .vjs-slider { background: rgba(8,7,7,0.2333333333333333) }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Virtual Classroom - Info Support</title>

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
                <a class="navbar-brand" href="/PDL/homepage"><img src="../resources/images/Logo.png"></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1" style="margin-top:12px">
                <ul class="nav navbar-nav">
                    <li><a href="/PDL/homepage">Home</a></li>
                    <li class="active"><a href="/PDL/courses"><fmt:message key="navbar.course"/></a></li>
                        <c:if test="${loggedInIsAdmin || loggedInIsTeacher || loggedInIsManager == true}">
                        <li class="dropdown" class="active">
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
                        <c:if test="${courseOwner.username == loggedInUsername}">
                        <li><a href="/PDL/courses/tutorial?courseId=${courseId}">Help</a></li>
                        </c:if>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><fmt:message key="navbar.settings"/> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/PDL/index.jsp"><fmt:message key="navbar.logout"/></a></li>
                            <li class="divider"></li>
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
                <form class="navbar-form navbar-right" role="search" id="searchUser" action="searchUser">
                    <div class="form-group">
                        <input type="text" name="searchQuery" id="searchQuery" class="form-control" placeholder="<fmt:message key="searchbar.search.user"/>">
                    </div>
                    <button type="submit" class="btn btn-default"><fmt:message key="navbar.search"/></button>
                </form>
            </div>
        </nav>
        <c:if test="${courseOwner.username == loggedInUsername}">
            <p style="text-align: center;">
                <fmt:message key="virtual.help.tut"/>
            </p>
        </c:if>
        <div id="main">
            <script>
                function hideStream()
                {
                    document.getElementById("hide").style.display = "none";
                    document.getElementById("showButton").style.display = "inline";
                }
                function showStream()
                {
                    document.getElementById("hide").style.display = "inline";
                    document.getElementById("showButton").style.display = "none";
                }
            </script>
        </head>
        <body>
            <div id="main_top">
                <input id="showButton" class="btn btn-default" type="button" onclick="showStream()" value="Show" style="display:none;">
                <div id="hide">
                    <input type="button" class="btn btn-default" onclick="hideStream()" value="Hide">
                    <div id="stream">
                        <embed width="100%" height="500px" src="http://www.focusonthefamily.com/family/JWPlayer/mediaplayer.swf" flashvars="allowfullscreen=true&allowscriptaccess=always&autostart=true&shownavigation=true&enablejs=true&volume=50&file=${courseKey}.flv&streamer=rtmp://31.186.175.82/live" />
                    </div>
                </div>
            </div>
            <div id="main_left">
                <div class="panel panel-default chatOutputStyle">
                    <div class="panel-body" style="width:106%;margin-left:-15px;margin-top:-16px;">
                        <table class="table" id="chatOutput" name="chatOutput">
                        </table>
                    </div>
                </div>
            </div>
            <div id="main_right">
                <div class="panel panel-default users">
                    <table class="table table-condensed" id="userList" style="width:100%;margin-top:-2px;">
                    </table>
                </div>
            </div>
            <div id="maint_bot">
                
                    <div class="" id="formGroupChatInput">
                        <div class="chatInput">
                            <input type="text" class="form-control" id="chatInput" name="chatInput" autocomplete="off" onkeyup="toggleSentButton()" placeholder="Enter a message">
                        </div>
                        <div class="chatSend">
                            <button type="button" style="width: 190px;" class="btn btn-default" disabled id="buttonSent" name="buttonSent" onClick="sentMessage()">Send</button>
                        </div>
                    </div>
                
            </div>
    </div>
    <script>
        try {
            var socket = io.connect('http://31.186.175.82:5001');
        }
        catch (error) {
            // this error states that a connection cannot be established
            // disable the chatInput to show this
            if (error.toString() === 'ReferenceError: io is not defined') {
                document.getElementById('chatInput').disabled = true;
                document.getElementById('chatInput').placeholder = 'Cannot establish connection to the chat server';
            }
        }
        // join the room on connect
        socket.on('connect', function(data) {
            var courseId = ${courseId};
            console.log('welcome to chatroom: ' + courseId);

            socket.emit('join room', 'room ' + courseId);
            socket.emit('userJoined', '${loggedInUsername}');

            console.log('room joined');
        });

        socket.on('userList', function(data) {
            console.log('users ' + data);

            //add users to the userlist
            for (var i = 0; i < data.length; i++) {
                addRowUserList(data[i], i);
            }


            console.log('userList received: ');
        });

        // receiving a join
        socket.on('userJoined', function(data) {
            //update the output box
            //$("#chatOutput").append(data + ' joined the chat\n');

            //play a sound
            var userJoinedSound = new Audio('../resources/sounds/01_-_Warm_Interface_Sound_1.wav');
            userJoinedSound.play();
        });

        // receiving a message
        socket.on('message', function(data) {
            //update the output box
            addRowChatOutput(data);

            console.log('message received');
        });

        //receiving the offline messages
        socket.on('offline_messages', function(docs) {
            console.log('received offline message');
            for (var i = 0; i < docs.length; i++) {
                //update the output box
                addRowChatOutput(docs[i].msg);
            }
            if (docs.length === 0) {
                    //alway emit a first message in the room so we can display the latest message
                    var message = 'Chat created on ' + moment().format('MMMM Do YYYY, HH:mm');
                    socket.emit('message', message);
                    addRowChatOutput(message);
                    console.log('room joined');
                }
        });

        $("#chatInput").keypress(function(event) {                
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode === 13 && document.getElementById('chatInput').value.replace(/^\s\s*/, '').replace(/\s\s*$/, '').length > 0) {
                    sentMessage();
                }
            });

        function sentMessage() {
            var date = new Date();
            var message = '${loggedInUsername}' + '||' + date + '||' + document.getElementById('chatInput').value;
            // emit the message
            socket.emit('message', message);

            // update the output and input boxes
            addRowChatOutput(message);
            document.getElementById('chatInput').value = '';
            toggleSentButton();
            console.log('message sent');
        }
        
// add a row to the table which contains the messages
        function addRowChatOutput(data) {
            var table = document.getElementById('chatOutput');
            var row;
            var rowCount = table.rows.length;
            var rowPrecedingCount = rowCount - 1;
            var rowPreceding = table.rows[rowPrecedingCount];
            var rowPrecedingClass;
            //data
            var from = '<b>' + data.substring(0, data.indexOf('||')) + '</b>';
            var date;

            //first message doesnt have a user from which its sent
            var message = '';
            if (rowCount === 0) {
                message = data;
            }
            else {
                data = data.substring(data.indexOf('||') + 2, data.length);
                date = new Date(data.substring(0, data.indexOf('||')));
                message = data.substring(data.indexOf('||') + 2, data.length);
            }

            //add newlines to large messages so they will fit in the row
            if (message.length > 60) {
                var result = '';
                while (message.length > 0) {
                    result += message.substring(0, 60) + '\n';
                    message = message.substring(60);
                }
                message = result;
            }

            //create row blocks
            var newRowBlock = false;
            if (rowPrecedingCount !== -1) {
                var precedingUser = rowPreceding.getAttribute('name');
                var precedingDate = new Date(rowPreceding.getAttribute('received'));
                var currentDate = new Date();

                //add to existing block if was sent within on hour by the same user
                if ((precedingUser === from) && (moment(precedingDate).add('hours', 1) > date)) {
                    console.log('samedate');
                    row = rowPreceding;
                    row.cells[0].innerHTML = row.cells[0].innerHTML + '</br>' + message;
                }
                //message from other user then preceding user or time sent is larger than one hour
                //create new 'block'
                else {
                    row = table.insertRow(rowCount);
                    row.setAttribute('name', from);
                    row.setAttribute('received', date);
                    var cell1 = row.insertCell(0);
                    cell1.innerHTML = from + '</br>' + message;
                    cell1.style.width = '93%';
                    newRowBlock = true;
                    var cell2 = row.insertCell(1);
                    cell2.innerHTML = '<small class="text-muted">' + moment(date).format('HH:mm') + '</small>';
                    cell2.style.width = '7%';
                }
            }
            //first occurence
            else {
                //create new block if it's the first row
                row = table.insertRow(rowCount);
                var cell1 = row.insertCell(0);
                cell1.innerHTML = message;
            }

            //create new date block
            var dateBlockAdded = false;
            if (rowCount > 1 && (moment(precedingDate).add('days', 1) < date)) {//check if it's a new day since a message was sent
                console.log('should create new block');
                //create new tr with date of today
                var row2 = table.insertRow(rowCount);
                var cell1 = row2.insertCell(0);
                cell1.setAttribute('align', 'center');
                cell1.setAttribute('colSpan', '2');
                row2.setAttribute('received', date);
                cell1.innerHTML = '<div class="text-info">' + moment(date).format('ll') + '</div>';
                dateBlockAdded = true;
            }

            //set row styling
            if (newRowBlock) {
                if (rowCount === 0) {//base case
                    row.className = 'active';
                }
                else {

                    rowPrecedingClass = rowPreceding.className;
                    if (rowPrecedingClass === 'active') {
                        row.className = '';
                    }
                    else {
                        row.className = 'active';
                    }
                }
            }
            $('div').scrollTop(1000000); // scroll to end of table
        }

        // add a row to the table which contains the users
        function addRowUserList(data, i) {
            var table = document.getElementById('userList');
            var rowCount = table.rows.length;
            //reset the userlist if we received a new one
            if (i === 0) {
                for (var j = 0; j < rowCount; j++) {
                    table.deleteRow(0);
                }
                rowCount = 0;
            }

            var row = table.insertRow(rowCount);
            row.className = "success"; // make the row green
            var cell1 = row.insertCell(0);
            cell1.innerHTML = data;
        }
        // block the sent button if there is no input in the chatInput box
        function toggleSentButton() {
            if (document.getElementById('chatInput').value.length > 0) {
                document.getElementById('buttonSent').disabled = false;
            }
            else {
                document.getElementById('buttonSent').disabled = true;
            }
        }
    </script>
</body>
</html>
