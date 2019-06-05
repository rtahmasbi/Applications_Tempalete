
# date and time
```
my_date=`date +%Y%m%d`
echo $my_date

date +'%Y/%m/%d %T %Z'
```


```
date
SECONDS=0
#
# do some work
#
date
duration=$SECONDS
echo "elapsed_time = $(($duration / 3600)):$((($duration / 60) % 60)):$(($duration % 60))"
```


```
# cd /home/user/bin
cat > ~/bin/ras_time_st.sh << 'EOF'
echo "------------------------------------------------------------------"
echo "hostname: $(hostname)"
echo "date_st: $(date +'%Y/%m/%d %T %Z')"
SECONDS=0
echo "------------------------------------------------------------------"
EOF
cat > ~/bin/ras_time_en.sh << 'EOF'
echo "------------------------------------------------------------------"
echo "date_en: $(date +'%Y/%m/%d %T %Z')"
duration=$SECONDS
echo "elapsed_time = $(($duration / 3600)):$((($duration / 60) % 60)):$(($duration % 60))"
echo "hostname: $(hostname)"
echo "------------------------------------------------------------------"
EOF

source ras_time_st.sh
#
# do some work
#
source ras_time_en.sh

###########
date_st=$(date +"%s")
date_en=$(date +"%s")
date -d "$date_en sec $date_st sec" +"%s"


###
alias ras_time_st='echo "=================== $(date)";SECONDS=0'
alias ras_time_en='echo "=================== $(date)";duration=$SECONDS;echo "elapsed_time = $(($duration / 3600)):$((($duration / 60) % 60)):$(($duration % 60))"'
```




# du
```
my_date=`date +%Y%m%d`
echo $my_date
du -ah . --max-depth=1 > du.$my_date.txt &
du -ah . --max-depth=2 > du.$my_date.depth2.txt
```


# find and touch
```
find . -exec touch {} \;


cat > run_touch.sh << EOF
#!/bin/bash
#SBATCH --mem=10gb
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --qos normal
#SBATCH --time=5:0:00
#SBATCH --output=slurm_touch_%j.out


date
find . -exec touch {} \;
date

EOF


##############################
sbatch run_touch.sh
##############################
```



# find big files and removing them
```
find PRJ003_h2 -type f -size +200M -exec du -h {} \;

find PRJ011_Simulation -type f -size +500M -exec du -h {} \;
find PRJ011_Simulation -type f -size +500M -exec rm {} \;

du -h PRJ011_Simulation
# 3.6T	PRJ011_Simulation


find . -type f -size +100M -exec rm {} \;


find . -name tecmint . txt
find / home -iname tecmint . txt # capital and small letters
find / -type d -name Tecmint # type = directory
find / -mtime 50 # modified 50 days back
find / -mtime +50 ? mtime -100
find / -cmin -60 # in last 1 hour
find / -size +50M -size -100M
find ./ test -maxdepth 2 -name "*. php"
find ./ test -not -name "*. php"
find . -type f -exec rm {} \;
```




# Inode
```
cd /
stat . .. bin sbin | grep Inode
```


# ln
```
ln -s ../DATA_UKBIOBANK/BioBank.rtf
```

# readlink
```
readlink [linked_file] # to see the actual contents of a symlink
```


# sed
```
sed -i 's/old/new/g' file # i=in-place , s = the substitute command , g = global (i.e. replace all and not just the first occurrence )
sed -i 's/foo/bar/g; s/baz/zab/g; s/ Alice / Joan /g' file # multiple replace
sed 's/MA/,Massa ' file
[] maths any one of the class
^ reverts the match ; e.g., [^ aeiou ] not vowel
- range of characters
```


# see the actual contents of a directory
https://unix.stackexchange.com/questions/216644/simple-way-to-see-the-content-of-directories-in-linux-unix-file-systems
```
# example, check the contents of /dev/sda1
ls -lid src
# 664488 drwxrwxrwx 2 vagrant vagrant 4096 Jul 15 13:24 src

debugfs /dev/sda1
#debugfs: imap <664488>
#Inode 664488 is part of block group 81
#located at block 2622042, offset 0x0700
#debugfs: dump src src.out
#debugfs: quit


od -c src.out
```

http://www.grymoire.com/Unix/Inodes.html




# more
```
source ~/.my.bash_profile

whereis plink
which plink
who

uniq -c filename


chmod + x file
chmod -R UGO+rw
du -ah / work / KellerLab / --max - depth =1
env

id

kill -9 PID

mpstat -P ALL

# display current BASH prompt :
echo $PS1 --> [\\ u@\h \\W]\\ $

# change the prompt 's color to green
export PS1="\e [0;32 m[\ u@\h \W]\$ \e[m "

```


# Identify Your Linux File System Type (Ext2 or Ext3 or Ext4, xfs, hfs)
https://en.wikipedia.org/wiki/Comparison_of_file_systems
```
mount | grep "^/dev"
```


# grep and zgrep
```
grep -c 'rs ' file # counts
grep -n --color 'rs ' file
grep " logL "$ '\t' res. N5000 .r* # TAB
```


# config file in /home/userid/.ssh/config
```
IdentityFile ~/.ssh/curc
StrictHostKeyChecking no

Host login.rc.colorado.edu
ServerAliveInterval 60

Host *
ForwardX11 yes
```


# bash_profile

```
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad

# to chnage the prompt color
export PS1="\e[0;32m[\u@\h \W]\$ \e[m"

module load R

c () { echo -e '\e[1;31m'`\$1`; echo -en '\e[0m';}
alias l="c pwd; ls -lh"
alias ls="ls --color=auto"

alias ncol="awk '{print NF; exit}'"

PATH=/home/userid/bin:/work/KellerLab/opt/bin:$PATH
module load slurm/summit
```

# ls -l file types:

- d (directory)
- c (character device)
- l (symlink)
- p (named pipe)
- s (socket)
- b (block device)
- D (door, not common on Linux systems, but has been ported)


# parallel and `sbatch`
```
sinfo

sacct --starttime 2018-05-01 -u rata --format=User,JobID,Jobname,partition,state,time,start,end,elapsed,MaxRss,MaxVMSize,nnodes,ncpus,nodelist


sacct --starttime 2018-05-01 -u userid --format=User,elapsed | grep "userid"


seq 1 99 | parallel sbatch --qos janus test .sh {}
parallel -a hosts.txt --colsep ' ' ping -c {1} {2}


scontrol show job 202720
scontrol update jobid =1507118 TimeLimit =24:0:0

module avail
module list


```



