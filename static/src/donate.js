'use strict';

$(function () {
	$("#in-submit").click(function () {
		var sid = String($('#in-steam').val());
		var amt = Number($('#in-amount').val());

		if (isNaN(amt) || sid.length < 4) {
			return;
		}

		amt = Math.floor(amt);

		sid.replace("STEAM_0:", "")

		sid = "STEAM_0:" + sid;

		$('#in-submit').attr('disabled', 'disabled');
		$('#in-submit').html("Processing...");

		socket.emit('modules.exclserver.donate.prepare', {
			steamid: sid,
			amt: amt
		}, function (err, data) {
			if (err) throw err
			if (!data || !data.url) {
				return;
			}
			window.location.replace(data.url);
		})
	});
});
