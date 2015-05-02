<h1>ExclServer</h1>
<hr />

<div class="well">
  <label>API URL
  <input type="text" id="input-api" class="form-control" name="api" value="{api}" />
  </label>
</div>

<button class="btn btn-lg btn-primary" id="save">Save</button>

<script>

'use strict';

$('#save').on('click', function(ev) {
    var api = $('#input-api').val();

    socket.emit('admin.settings.saveExclServer', {'api' : api}, function() {
        app.alertSuccess('Saved ExclServer configuration. Please reload your forum to push the changes that you have made.');
    });
});

</script>
