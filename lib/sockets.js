'use strict';

var request = require('request'),
	Settings = require('./settings'),
	query = require('game-server-query'),
	Events = {};

Events.servers = {}
Events.servers.get = function (socket, data, callback) {
	request(Settings.get().url + 'api/servers/all', function (error, response, body) {
		if (!error && response.statusCode == 200 && typeof body == "string") {
			callback(null, JSON.parse(body));
		} else {
			callback(null, {});
		}
	});
}
Events.servers.info = function (socket, data, callback) {
	if (!data.dns && !data.ip) {
		callback(null, {
			'players': {
				'min': 0,
				'max': 0,
			},
			'map': 'ERROR'
		});
		return;
	}

	var loc = data.dns || data.ip;

	query({
			'type': 'garrysmod',
			'host': loc
		},
		function (state) {
			if (state.error) {
				console.log(state)
				callback(null, {
					'players': {
						'min': 0,
						'max': 0,
					},
					'map': 'unknown'
				});
			} else {
				callback(null, {
					'players': {
						'current': state.players.length,
						'max': state.maxplayers,
					},
					'map': state.map
				});
			}
		}
	);

}

Events.donate = {}
Events.donate.prepare = function (socket, data, callback) {
	if (!data || !data.steamid || !data.amt) {
		callback("Invalid data", {});
		return;
	}
	request({
		'method': 'GET',
		'uri': Settings.get().url + 'api/donate?sid=' + data.steamid + '&amt=' + data.amt,
		'followRedirect': false
	}, function (error, response, body) {
		if (!error && (response.statusCode == 302 || response.statusCode == 301) && typeof body == "string") {
			callback(null, {
				'url': response.headers.location
			});
		} else {
			callback("No response from API", {});
		}
	});
}

module.exports = Events;
