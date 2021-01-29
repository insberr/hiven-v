module structs

import x.json2
import x.websocket

pub struct WSMessage {
pub mut:
	seq int
	op int
	e string
	d map[string]json2.Any
}

fn makeopcode(opcode int, data map[string]json2.Any) string { // Creates the json to send to server
	mut inst := map[string]json2.Any
	inst['op'] = opcode
	inst['d'] = data
	return inst.str()
}

// Parses websocket message into a string
pub fn socket_msg_parse(msg &websocket.Message) ?&WSMessage {
	/*
	println('socket_msg_parse')
	
	test := json2.raw_decode(msg.payload.bytestr())?

	mut jdata := test.as_map()
    mut opcode := jdata['op'].int()
	mut data := jdata['d'].str()
    
	println(' $test , $jdata , $opcode $data ')
	*/
	mut new_msg := &WSMessage{}

	mut obj := json2.raw_decode(string(msg.payload))?
	mut obj_map := obj.as_map()

	new_msg.seq = obj_map["seq"].int()
	new_msg.op = obj_map["op"].int()
	new_msg.e = obj_map["e"].str()
	new_msg.d = obj_map["d"].as_map()
	
	return new_msg
}

pub fn socket_msg_create(opcode int, data string) string {
	mut new_msg := map[string]json2.Any
	new_msg['op'] = opcode
	new_msg['d'] = data

	return new_msg.str()
}

pub fn message_create_parse(data map[string]json2.Any) &Message {
	message := &Message{
		timestamp: data["timestamp"].str(),
		room_id: data["room_id"].str(),
		mentions: [&Mention{}],
		member: &Member{
			user: &User{},
			roles: [&Role{}]
		},
		id: data["id"].str(),
		house_id: data["house_id"].str(),
		exploding_age: 0,
		exploding: data["exploding"].bool(),
		device_id: data["device_id"].str(),
		content: data["content"].str(),
		bucket: data["bucket"].int(),
		author_id: data["author_id"].str(),
		author: &Author{}
	}

	return message
}

pub fn login(token string) string {
	mut data := map[string]json2.Any
	data["token"] = token
	return makeopcode(2,data)
} // calling opcodes.login(token) will create a login opcode

