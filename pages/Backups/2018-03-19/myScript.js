var loggedIn = false;

function logIn() {
    if (!loggedIn) {
        var urlBeginning = "https://login.eveonline.com/oauth/authorize/";
        var response = "?response_type=code&";
        var redirectUri = "redirect_uri=http://192.168.42.123:8080/ete_4.0.html&";
        var clientId = "client_id=66c2e9a0e1164a9ab88006abe1e8c7ab&";
        var scope = "scope=characterContactsRead%20characterContactsWrite&";
        var state = "state=uniquestate123";
        var URL = urlBeginning + response + redirectUri + clientId + scope + state;
        window.location.replace(URL);
        var status = document.getElementById("status").innerHTML;
        status = "Logging in..."
    } else {
        status = "You are already logged in."
    }
}

function getToken() {
    var authCode = readUrlQuery("code");
    document.getElementById("authStatus").innerHTML = "Grabbed key " + authCode;
}

function readUrlQuery(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split('&');
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split('=');
        document.getElementById("authStatus").innerHTML = "pair [0] = " + pair[0];
        if (decodeURIComponent(pair[0]) == variable) {
            return decodeURIComponent(pair[1]);
        }
    }
    console.log('Query variable %s not found', variable);
}