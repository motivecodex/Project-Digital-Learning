var app = require('http').createServer(handler)
        , io = require('socket.io').listen(app)
        , fs = require('fs')
        , mongoose = require('mongoose');

app.listen(5001);

//-- START MONGODB --
//connect to mongodb (database) where all the chats are saved
mongoose.connect('mongodb://localhost/chat', function(err) {
    if (err) {
        console.log('error on connecting to mongodb');
    }
    else {
        console.log('successfully connected to mongodb');
    }
});

//here we define the structure for our chat layout in the database
var chatSchema = mongoose.Schema({
    from: String,
    msg: String,
    room: String,
    timeSent: {type: Date, default: Date.now}
});
var lastSeenSchema = mongoose.Schema({
   user: String,
   room: String,
   timeLastSeen: {type: Date, default: Date.now}
});

//our model
var Chat = mongoose.model('Message', chatSchema);
var lastSeen = mongoose.model('LastSeen', lastSeenSchema);

//-- END MONGODB --

function handler(req, res) {
    fs.readFile(__dirname + '/index.html',
            function(err, data) {
                if (err) {
                    res.writeHead(500);
                    return res.end('Error loading index.html');
                }

                res.writeHead(200);
                res.end(data);
            });
}
//CUSTOM CODE
// here come all the methods
io.sockets.on('connection', function(socket) {
    //join the room and save the room name
    socket.on('join room', function(room) {
        socket.set('room', room, function() {
            console.log('room ' + room + ' saved');
            socket.join(room);
        });
    });

    //when user joined
    socket.on('userJoined', function(data) {
        console.log('User joined: ' + data);
        //set the nickname for the user
        socket.nickname = data;

        //lookup room and broadcast to that room
        socket.get('room', function(err, room) {
            console.log('dispatching message');
            socket.broadcast.to(room).emit('userJoined', data); //emit to 'room' except this socket
//send list with all connected clients in this room
            var clients = io.sockets.clients(room);
            //      socket.to(room).emit('userList', clients); //emit to 'room' except this socket
            //because of a circular structure we need to push every client on an array and sent that out
            var temp = new Array();
            clients.forEach(function(client) {
                temp.push(client.nickname);
            });
            socket.broadcast.to(room).emit('userList', temp);
            socket.to(room).emit('userList', temp);
            console.log('active clients: ' + clients);

            //send the messages that were already sent
            Chat.find({room: room}, function(err, docs) {
                if (err)
                    throw err;
                console.log('sending offline messages');
                socket.emit('offline_messages', docs);
            });
        });
    });

    //when message is received
    socket.on('message', function(data) {
        console.log('Message received: ' + data);

        //lookup room and broadcast to that room
        socket.get('room', function(err, room) {
            console.log('dispatching message');
            //first save the message to the db
            var newMsg = new Chat({msg: data, room: room, from: socket.nickname});
            newMsg.save(function(err) {
                if (err)
                    throw err;
            });
            socket.broadcast.to(room).emit('message', data); //emit to 'room' except this socket
        });
    });

    //when user left the chatroom
    socket.on('disconnect', function(data) {
        
        //lookup room and broadcast to that room
        socket.get('room', function(err, room) {
        if (room !== null){
        //update the lastseen object for this user and room
        lastSeen.find({room: room, user: socket.nickname}, function(err, docs){
        console.log('updating lastseen');
	        if (err)
	        	throw err;
		    //create new object if there is'nt an already
		    lastSeen.update(
				{ user : socket.nickname, room: room },
				{ timeLastSeen: new Date() },
				{ upsert: true, multi: false } //upsert creates new if not exist, multiple updates only 1
				, function(erro, updated){
					if (erro)throw erro;	
				});
		    console.log('lastseen should be updated');
		    
        });
        
        
            socket.leave(room);
            console.log('user disconnected; resending userlist');
            //send list with all connected clients in this room
            var clients = io.sockets.clients(room);
            //because of a circular structure we need to push every client on an array and sent that out
            var temp = new Array();
            clients.forEach(function(client) {
                temp.push(client.nickname);
            });
            socket.broadcast.to(room).emit('userList', temp);
            socket.to(room).emit('userList', temp);
            console.log('active clients: ' + clients);
}
        });
    });

    //when latest message is requested
    socket.on('getLatestMessage', function(data) {
        Chat.find({room: data}, function(err, docs) {
            if (err)
                throw err;
            console.log('sending offline messages');
            socket.emit('latestMessage', docs);
            console.log('sending latest message: ' + data);

        });  
    });
    
        //when request for unread messages is done
    socket.on('getUnreadNotifications', function(data) {
    console.log('===================unread notifications===========================' + data);
        lastSeen.find({user: data}, function(err, docs) {
            if (err)
                throw err;
            console.log('sending unread notifications');
            socket.emit('unreadNotifications', docs);

        });  
    });
    
    
});
