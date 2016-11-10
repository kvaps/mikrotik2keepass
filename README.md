mikrotik2keepass
================

Script for exporting DHCP Leases from Mikrotik into Generic CSV format fit for importing to Keepass2

Usage
-----

```bash
mikrotik2keepass.sh [user@]hostname [vnc-password] [notes] > file.csv
```

Example usage:
--------------

```bash
$ ./mikrotik2keepass.sh admin@192.168.100.1 "P@ssw0rD" "some text note" > file.csv
admin@192.168.100.1's password:

$ cat file.csv 
 "FreddyKrueger-PC","ws01","P@ssw0rD","vnc://192.168.100.123","some text note"
 "PetrIvanov-laptop","ws02","P@ssw0rD","vnc://192.168.100.104","some text note"
 "LeoTolstoi-laptop","ws03","P@ssw0rD","vnc://192.168.100.111","some text note"
 ```
