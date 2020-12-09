module vhiven
import src.client as ws_client
import x.websocket

pub struct HivenClient {
pub mut:
  user string 
	ws &websocket.Client = ws.new_websocket()
	bot bool = true
}

pub fn new_client() HivenClient {
	ws.new_websocket()
	c := HivenClient{user: 'insbott'}
	return c

pub fn (c HivenClient) login(token string) {
	if c.bot == true {
		ws.login("Bot $token")
	} else {
		ws.login(token)
	}
}
