![OpenIPC logo][logo]

## OSD

An all-in-one daemon that exposes an HTTP frontend to
- adjust settings ;
- manage OSD regions ;
- stream AV content on supported IP cameras

### Examples

Parameters for each region can be passed in one or many calls:
```
curl "192.168.1.17:9000/api/osd/0?font=comic&size=32.0&text=Frontdoor"
curl 192.168.1.17:9000/api/osd/0?posy=72
```

Supported fonts (sourced from /usr/share/fonts/truetype/) can render Unicode characters:
```
curl 192.168.1.17:9000/api/osd/0?text=Entrée
```

Empty strings are used to clear the regions:
```
curl 192.168.1.17:9000/api/osd/1?text=
```

Specifiers starting with a dollar sign are used to represent real-time statistics:
```
curl "192.168.1.17:9000/api/osd/1?text=$B%20C:$C%20M:$M"
```
N.B. Spaces have to be escaped with %20 in URL syntaxes

Showing the time and customizing the time format is done this way:
```
curl 192.168.1.17:9000/api/time?fmt=%25Y/%25m/%25d%20%25H:%25M:%25S
curl 192.168.1.17:9000/api/osd/2?text=$t&posy=120
```

UTC date and time can be set using Unix timestamps:
```
curl 192.168.1.17:9000/api/time?ts=1712320920
```

### Technical support and donations

Please **_[support our project](https://openipc.org/support-open-source)_** with donations or orders for development or maintenance. Thank you!

[logo]: https://openipc.org/assets/openipc-logo-black.svg

