# Angular Proxy Reverse Example

This is a simple project on how you can do a proxy reverse in a Angular application using angular server or apache server in docker.

## Fetch example

```javascript
    fetch("/api/posts/1")
    .then(response => response.json())
    .then(json => console.log(json));
```

## See the result

When running the app open the browser console, the result is as below:

```json
{
    "id": 6717,
    "uid": "faab987f-f04b-4551-bfa0-4d5b48e84ef2",
    "city": "Lake Sherrellstad",
    "street_name": "Marvin Groves",
    "street_address": "19800 Sheridan Unions",
    "secondary_address": "Apt. 150",
    "building_number": "5859",
    "mail_box": "PO Box 72",
    "community": "Willow Court",
    "zip_code": "88189-6445",
    "zip": "83235",
    "postcode": "04526-9826",
    "time_zone": "Europe/Ljubljana",
    "street_suffix": "Summit",
    "city_suffix": "borough",
    "city_prefix": "Lake",
    "state": "Indiana",
    "state_abbr": "MN",
    "country": "Montenegro",
    "country_code": "RO",
    "latitude": 52.375725592197995,
    "longitude": 165.53318797576276,
    "full_address": "Apt. 590 840 Clark Path, Samualville, OR 67165"
}
```


## Angular Server

### Angular proxy config

```json
{
    "/api": {
        "target": "https://random-data-api.com/api",
        "secure": false,
        "changeOrigin": true,
        "logLevel": "debug",
        "pathRewrite": {
            "^/api": ""
        }
    }
}
```
### Angular start serve using proxy

```json
...
  "scripts": {
    "start": "ng serve --host 0.0.0.0 --proxy-config src/proxy.conf.json",
...
```

## Apache Server

### httpd.conf

Enable commented lines:

* LoadModule deflate_module modules/mod_deflate.so
* LoadModule proxy_html_module modules/mod_proxy_html.so
* LoadModule proxy_module modules/mod_proxy.so
* LoadModule proxy_http_module modules/mod_proxy_http.so
* LoadModule ssl_module modules/mod_ssl.so
* LoadModule rewrite_module modules/mod_rewrite.so

Change directory permissions

```
<Directory "/usr/local/apache2/htdocs">
    Require all granted
    Options All
    AllowOverride All
    Order allow,deny
    Allow from all
</Directory>
```
Configure proxy:

```
<IfModule mod_rewrite.c>
    ProxyPreserveHost On
    SSLProxyEngine ON
    SSLProxyVerify NONE 
    SSLProxyCheckPeerCN OFF
    SSLProxyCheckPeerName OFF
    SSLProxyCheckPeerExpire OFF


    ProxyPass /api https://random-data-api.com/api/
    ProxyPassReverse /api https://random-data-api.com/api/
</IfModule>
```