"use strict";

// SCOPE VARIABLES
var
	plugin = {},
	request = require('request');

// SETTINGS
var defaultSettings = {
  api : 'http://localhost:3000'
};

var Settings = new (module.parent.require('./settings'))('exclserver', '0.0.1', defaultSettings);

// PAGE RENDERING
function renderAdmin(req, res, next) {
	res.render('admin/exclserver', {'api' : Settings.get().api});
}

function renderServers(req, res, next) {
	request(Settings.get().api + '/servers/all', function(error,response,body) {
	  if (!error && response.statusCode == 200) {
	    res.render('exclserver/servers', {servers : JSON.parse(body)});
	  } else {
			next(new Error("Invalid ExclServer API response."))
		}
	})
}

function renderDonate(req, res, next) {
	res.render('exclserver/donate', {});
}

// SOCKET

// HOOKS
plugin.addAdminNavigation = function(header, callback) {
	header.plugins.push({
		route: '/exclserver',
		icon: 'fa-mobile',
		name: 'ExclServer'
	});

	callback(null, header);
};

plugin.init = function(params, callback) {
  var app = params.router,
    middleware = params.middleware,
    controllers = params.controllers;

  app.get('/admin/excls	erver', middleware.admin.buildHeader, renderAdmin);
  app.get('/api/admin/exclserver',renderAdmin);

  app.get('/exclserver/servers',middleware.buildHeader,renderServers);
  app.get('/api/exclserver/servers',renderServers);

	app.get('/exclserver/donate',middleware.buildHeader,renderDonate);
  app.get('/api/exclserver/donate',renderDonate);

	var SocketAdmin = module.parent.require('./socket.io/admin');
	SocketAdmin.settings.saveExclServer = function(socket, data, callback) {
		Settings.set('api',data.api);
		Settings.persist();
	}

	callback();
}

// EXPORT
module.exports = plugin;