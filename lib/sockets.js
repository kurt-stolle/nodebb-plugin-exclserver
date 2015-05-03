'use strict';

var events = {};

events.testEvent = function (socket, data, callback) {
	console.log('Dun test event');

	callback();
}

module.exports = events;
