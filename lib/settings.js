var Settings = require.main.require('./src/settings');

var MySettings = new Settings('exclserver', '0.0.5', {
	url: 'http://localhost:3000'
});

module.exports = MySettings
