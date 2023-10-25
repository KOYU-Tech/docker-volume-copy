# Docker Volume Copy

**Last time test: Docker version 23.0.0 (build e92dd87) 25/03/2023**

Bash script that allows to make a copy of exists volume to new one with a new name.

**Step 1**

Copy script to where you want use it

```
curl https://raw.githubusercontent.com/KOYU-Tech/docker-volume-copy/main/dvc.sh -o dvc.sh && chmod +x dvc.sh
```

**Step 2**

Check the correct name of exists volume by

```
docker volume ls
```

**Step 3**

Come up with a new volume name and use it with the script:

```
./dvc.sh old-volume-name new-volume-name-that-better-than-previous
```

Press "Enter" and wait.

**Step 4**

Go back to Github and give us a star 😅

BTW! I do recommend to check out this tool as well: https://github.com/BretFisher/docker-vackup
It's very useful for backup and restore whole docker volume or migrate it to another webserver.
