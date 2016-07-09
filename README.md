permi is a script to correct permissions of Linux/Unix users. Primarily created to correct permissions in enviroments that use suPHP/FastCGI in cPanel, but adapted to allow other permission sets that target generic users rather than focusing on cPanel (or Apache/PHP for that matter).

---

 PHP-DSO
____
```
755 (owner:owner)  - 
751 (owner:owner)  -
750 (owner:owner)  - 
750 (owner:nobody) - 
750 (owner:mail)   - 
711 (owner:owner)  - 
700 (owner:owner)  - 
644 (owner:owner)  -
640 (owner:owner)  - 
600 (owner:owner)  - 
444 (owner:owner)  -
400 (owner:owner)  -
```

 PHP suPHP
____
```
755 (owner:owner)  - (all unlisted directories)
751 (owner:owner)  - mail
750 (owner:owner)  - .htpasswds .ssh etc public_ftp
750 (owner:nobody) - .htpasswds public_html
750 (owner:mail)   - etc
711 (owner:owner)  - .softaculous softaculous_backups
700 (owner:owner)  - .cpanel .cphorde .ssh .trash logs
644 (owner:owner)  - (all unlisted files)
640 (owner:owner)  - cpbackup-exclude.conf
600 (owner:owner)  - .*_history .contactemail .lastlogin .viminfo
444 (owner:owner)  -
400 (owner:owner)  -
```
