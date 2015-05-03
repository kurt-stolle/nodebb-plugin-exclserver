<div class="jumbotron">
  <h1>Hello, future donator.</h1>
  <p>On this page you can make a donation to Casual Bananas. For each 1 USD you donate we will reward you 1000 in-game bananas that can be used to buy various items and effects through ExclServer.</p>
</div>
<div class="container-fluid">
  <div class="row">
    <div class="col col-sm-7">
      <h3>Donation Terms and Conditions</h3>
      <div class="well" style="overflow-y: scroll; height:500px;">
        <ol>
          <li>
            <p>
              <strong>Refund Policy</strong>
              <br /> Casual Bananas will not provide refunds under any circumstances. If you are banned, you will not get a refund. If you do not favor the service, you will not get a refund. If you unexpecedtly did not receive your donation award, and don't
              have any proof of your donation, you will not get a refund. If you do not receive your donation award, you may appeal it on the forums. If you're not ready to take these minute risks, please refrain from donation to Casual Bananas. It's
              not integral for you to donate, it's completely optional and at your own risk.
            </p>
          </li>
          <li>
            <p>
              <strong>Donation Exchange</strong>
              <br /> If you are unhappy with the donation option you chose, you can submit a request on the forums for an exchange for an award, otherwise known as a package, of equal or lesser value and your request will be reviewed and changed if deemed viable
              by Casual Bananas and/or it's staff. We maintain the right to turn down any exchange request, with or without reason.
            </p>
          </li>
          <li>
            <p>
              <strong>Donation Rewards</strong>
              <br /> When you donate to Casual Bananas, it is understood that you're actually donating at your own risk. Donation items are exclusively rewards for your consideration into donating to Casual Bananas. You're not paying for any service, you're
              donating to keep our servers up. We're not selling virtual items or commands, when you donate, you take the risk(s) involved in donating as listed in the 'Refund Policy'. Your donations go toward maintenance and upgrades of the server and
              website. Excess donations may be by the staff to purchase upgrades that will allow them to better do their jobs.
            </p>
          </li>
          <li>
            <p>
              <strong>Disclaimer of warranties</strong>
              <br /> YOU UNDERSTAND AND AGREE THAT YOUR USE OF THIS WEB SITE AND ANY SERVICES OR CONTENT PROVIDED (THE SERVICE) IS MADE AVAILABLE AND PROVIDED TO YOU AT YOUR OWN RISK. IT IS PROVIDED TO YOU AS IS AND WE EXPRESSLY DISCLAIM ALL WARRANTIES OF ANY
              KIND, IMPLIED OR EXPRESS, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTY, IMPLIED OR EXPRESS, THAT ANY PART OF THE SERVICE WILL BE UNINTERRUPTED,
              ERROR-FREE, TIMELY, SECURE, ACCURATE, RELIABLE, OF ANY QUALITY, NOR THAT ANY CONTENT IS SAFE IN ANY MANNER FOR DOWNLOAD. YOU UNDERSTAND AND AGREE THAT NEITHER US NOR ANY PARTICIPANT IN THE SERVICE PROVIDES PROFESSIONAL ADVICE OF ANY KIND
              AND THAT USE OF SUCH ADVICE OR ANY OTHER INFORMATION IS SOLELY AT YOUR OWN RISK AND WITHOUT OUR LIABILITY OF ANY KIND. Some jurisdictions may not allow disclaimers of implied warranties and the above disclaimer may not apply to you only
              as it relates to implied warranties.
            </p>
          </li>
          <li>
            <p>
              <strong>Limitation of liabilities</strong>
              <br /> You agree to give up all legal rights towards Casual Bananas when donating.</p>
            </p>
          </li>
        </ol>
      </div>
    </div>
    <div class="col col-sm-5 pull-right">
      <h3>Payment Details</h3>
      <div class="well">
        <div class="row">
          <p>
            <strong>Full name:</strong>
          </p>
          <div class="input-group">
            <input type="text" class="form-control">
          </div>
        </div>
        <br>
        <div class="row">
          <p>
            <strong>Email address:</strong>
          </p>
          <div class="input">
            <input type="text" class="form-control">
          </div>
        </div>
        <br />
        <div class="row">
          <p>
            <strong>SteamID:</strong> (<a href="http://steamidfinder.com/">?</a>)</p>
          <div class="input-group">
            <span id="in-steam" class="input-group-addon">STEAM_0:</span>
            <input type="text" class="form-control">
          </div>
        </div>
        <br />
        <div class="row">
          <p>
            <strong>Donation amount (USD):</strong>
          </p>
          <div class="input-group">
            <span class="input-group-addon">$</span>
            <input id="in-amount" type="text" class="form-control" aria-label="Amount (to the nearest dollar)">
            <span class="input-group-addon">.00</span>
          </div>
        </div>
        <br />
        <div class="row">
          <p>By clicking the button below you agree to the Donation Terms and Conditions document presented left of this panel</p>
          <button id="in-submit" onclick="prepareDonation()" class="btn btn-default btn-lg btn-block" type="submit">Donate through PayPal</button>
        </div>
      </div>
    </div>
  </div>

  <script>
    'use strict';

    (function() {
      function prepareDonation() {
        var sid = String($('#in-steam').val());
        var amt = Number($('#in-amount').val());

        if (isNaN(amt)) {
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
        }, function(err, data) {
          if (err) throw err

          if (!data || !data.url) {
            return;
          }

          window.location.replace(data.url);
        })
      }
    })();
  </script>
