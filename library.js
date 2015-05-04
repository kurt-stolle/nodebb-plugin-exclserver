"use strict";

// SCOPE VARIABLES
var plugin = {},
	request = require('request'),
	Settings = require('./lib/settings');

// ROUTING / RENDERING

function renderAdmin(req, res, next) {
	res.render('admin/exclserver', {
		'api': Settings.get().api
	});
}
function renderServers(req, res, next) {
	res.render('servers', {});
}
function renderDonate(req, res, next) {
	res.render('donate', {});
}

// HOOKS
plugin.addAdminNavigation = function (header, callback) {
	header.plugins.push({
		route: '/plugins/exclserver',
		icon: 'fa-mobile',
		name: 'ExclServer'
	});

	callback(null, header);
}

plugin.getScripts = function(scripts, callback) {
	console.log("These scripts will load: ");
	console.log(scripts);
	callback(null, scripts);
}

plugin.init = function (params, callback) {
	var app = params.router,
		middleware = params.middleware,
		controllers = params.controllers;

	app.get('/admin/plugins/exclserver', middleware.admin.buildHeader, renderAdmin);
	app.get('/api/admin/plugins/exclserver', renderAdmin);

	app.get('/exclserver/servers', middleware.buildHeader, renderServers);
	app.get('/api/exclserver/servers', renderServers);

	app.get('/exclserver/donate', middleware.buildHeader, renderDonate);
	app.get('/api/exclserver/donate', renderDonate);

	var SocketAdmin = require.main.require('./src/socket.io/admin');
	SocketAdmin.settings.saveExclServer = function (socket, data, callback) {
		Settings.set('api', data.api);
		Settings.persist();

		callback();
	}

	var SocketPlugins = require.main.require('./src/socket.io/modules');
	SocketPlugins.exclserver = require('./lib/sockets');

	callback();
}

// EXPORT
module.exports = plugin;
