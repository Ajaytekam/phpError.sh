# phpError.sh 

shell script used to enable/disable php Errors/Warnings in Lamp stack.   

It basically edits the `/etc/php/ver7.x/apache2/php.ini` file (also create a backup in case of any error to restore it) and sets the `display errors = On\Off`.   

**Usage :**    

> Note : run it with sudo   

```shell  
$ ./phpErr.sh 

Usages :
	./phpErr.sh -e/-d
"-e" - Enable Display_Error
"-d" - Disable Display_Error
 Exiting....
```   
**Enabling Error/Warning**   
```shell  
$ ./phpErr.sh -e

[+] Creating backup file
[-] Backup file already exists.
[+] display_error Enabled : Success
[+] Restarting apache server
Exiting.... 
```   
**Disabling Error/Warning**   
```shell  
$ ./phpErr.sh -d 

[+] Creating backup file
[-] Backup file already exists.
[+] display_error Disabled : Success
[+] Restarting apache server
Exiting....
```   
