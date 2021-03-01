# robocopyme

This tool is designed to simplify backup with robocopy by setting a config file.

### Before start

You must find the UUID of the disk you want to use as destination.
There are many ways to find it, but you can open a cmd window and type:

`mountvol`

### Instalation

Just copy the project file to wherever you want.

### Configuration

You can configure the tool by editing the `config.ini` file.

    [Option]
    options=/MIR /XJD /R:0 /W:0 /ETA /NDL /NFL
    log=true

options = robocopy options that can be found [here](https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/robocopy "here").
log = enable/disable log to a file.

    [Destination]
    uuid=27e8ea5c-7e12-4f2a-ab83-22af3f4f2403
    folder=FolderXYZ

uuid = the UUID found with the command `mountvol`.
folder = some folder you want to specify in destination drive:

left blank = will copy direct to drive root
"somefolder" = will create "somefolder" in root and copy  backup inside.
"somefolder\anotherfolder =  will create "somefolder" in root and "anotherfolder" inside "somefolder", and the backup inside.

use \ only to separate folders.

    [Source]
    c:\bin
    c:\games
    c:\docs\only_important_docs
    d:\downloads
    d:\more_games
    e:\music

List to the paths of folders you wan to backup.

- Note that this tool will get the drive letter of source folders make the backup inside these folders. So by this example you wil get this structure in the root of the destination drive:

```
c
	bin
	games
	docs\only_important_docs
d
	downloads
	more_games
e
	music
```

### End