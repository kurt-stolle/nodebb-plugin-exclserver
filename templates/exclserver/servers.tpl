<p>Click connect to connect to a server via Steam.</p>
<table class="table table-striped table-hover table-bordered">
  <thead>
    <tr>
      <th>Server</th>
      <th>Map</th>
      <th>Players</th>
      <th>DNS name</th>
    </tr>
  </thead>
  <tbody id="serverlist"></tbody>
</table>

<script>
  'use strict';

  (function() {
      socket.on('connect', function() {
        socket.emit('modules.exclserver.servers.get', {}, function(err, data) {
          if (err) throw err;

          if (!data) {
            return;
          }

          $("#serverlist").html("");
          for (var i = 0; i < data.length; i++) {
            (function(i) {
              var server = data[i];

              if (!server) return;

              $("#serverlist").append('<tr><td>' + server.name + '</td></td><td id="srv-' + server.id + '-map"><i>loading...</i></td><td id="srv-' + server.id +
                '-players"><i>loading...</i><td><a data-toggle="tooltip" data-placement="top" title="Connect via Steam" href="steam://connect/' + server.dns + '">' + server.dns + '</a></td></tr>');

              socket.emit('modules.exclserver.servers.info', {
                dns: server.dns
              }, function(err, info) {
                if (err) throw err;

                $('#srv-' + server.id + '-map').html(info.map);
                $('#srv-' + server.id + '-players').html(info.players.current + ' / ' + info.players.max);
              })
            })(i);
          }
          $('[data-toggle="tooltip"]').tooltip()
        });
      });
    )();
</script>
