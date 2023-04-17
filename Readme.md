# Youtube Archive Project

I have made attempt to preserve youtube videos i like. This script downloads
them for me. I realised that if these videos are banned or copyright stricken
they are lost forever.

### Procedure

The todo.txt file should contain the following format.

```
youtube_link name of the file
```

Remember that this file name is only for reference.
for example,

```
https://youtu.be/nU0vgZOSC4U the strange case of dr.jafari
https://youtu.be/pjTZoKj3gEE sseth origin story
https://youtu.be/vrGf4nJWVOU the gentleman pirate
https://youtu.be/Qh9KBwqGxTI the cost of concordia
```

Script goes through todo.txt one by one from top to bottom.  
download succefully >> done.txt  
download failed >> failed.txt

```
├── archiver.sh
├── backup
├── done.txt
├── failed.txt
└── todo.txt

```

If you messed up, copies of done.txt, failed.txt and todo.txt form the previous
iteration of script can be found in backup/
