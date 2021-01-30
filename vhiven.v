// vhiven is a hiven bot and api interaction library
module vhiven

import src.client
import eventbus
import x.json2

// HivenClient the hiven client
pub struct HivenClient {
pub mut:
	bot bool = true
	init_data string
	cl client.Client
}

// new_client create a new HivenClient
pub fn new_client() HivenClient {
	mut hcl := HivenClient{}
	return hcl
}

fn get_hcl() &HivenClient {
	return &HivenClient{}
}

// login to the client
pub fn (mut hcl HivenClient) login(token string) {
	mut cl := client.new_client()
	hcl.cl = cl

	hcl.cl.on('init', on_init)

	hcl.cl.login(hcl.bot, token)
}

fn on_init(recvr voidptr, data map[string]json2.Any, cl &client.Client) ? {
	mut hcl := get_hcl()
	hcl.init_data = data.str()
	hcl.cl.bus.publish('ready', cl, none)
}

// on for events
pub fn (mut hcl HivenClient) on(etype string, evthandler eventbus.EventHandlerFn) {
	hcl.cl.get_subscriber().subscribe(etype, evthandler)
}
