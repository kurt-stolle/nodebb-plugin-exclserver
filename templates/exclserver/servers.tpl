<h1>Server list</h1>
<p>This is a work in progress feature. Click connect to connect to a server via Steam.</p>
<table class="table table-bordered">
  <thead>
    <tr>
      <th>Server</th>
      <th>DNS name</th>
      <th>Steam link</th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN servers -->
    <tr>
      <td>{servers.name}</td>
      <td>{servers.dns}</td>
      <td><a class="btn btn-sm btn-block" href='steam://connect/{servers.dns}'>Connect</a></td>
    </tr>
    <!-- END servers -->
  </tbody>
</table>
