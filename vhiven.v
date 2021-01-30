// vhiven is a hiven bot and api interaction library
module vhiven

import src.structs as s

// HivenClient the hiven client
pub struct HivenClient {
pub mut:
	bot       bool = true
	init_data string
	cl        Client
}

// new_client create a new HivenClient
pub fn new_client() HivenClient {
	return HivenClient{}
}

// login to the client
pub fn (mut hcl HivenClient) login(token string) {
	println('hcl login')
	mut cl := new_ws_client()
	hcl.cl = cl

	cl.on('ready', on_ready_state)

	login(mut cl, hcl.bot, token)
}

fn on_ready_state(recvr voidptr, data &s.ReadyState, cl &Client) ? {
	// println(data)
	// hcl.init_data = data.str()
	cl.eb.publish('onready', cl, none)
}

/*
// on for events
pub fn (mut hcl HivenClient) on(etype string, evthandler eventbus.EventHandlerFn) {
	get_subscriber().subscribe(etype, evthandler)
}
*/
