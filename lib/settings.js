var Settings = require.main.require('./src/settings');

var MySettings = new Settings('exclserver', '0.0.1', {
	api: 'http://localhost:3000'
});

module.exports = MySettings
