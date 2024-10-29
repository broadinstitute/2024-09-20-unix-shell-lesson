---
title: Refresher for Unix 101, part 2
teaching: 30
exercises: 20
---

::::::::::::::::::::::::::::::::::::::: objectives

- Review Unix 101, part 1 material

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What are the basic Unix commands we covered in Unix 101, part 1?

::::::::::::::::::::::::::::::::::::::::::::::::::

# Unix review



## Log onto the Broad login server

If you are on-site, connect to the **Broad-Internal** wireless network. If you are off-site, [connect](https://intranet.broadinstitute.org/bits/service-catalog/networking/vpn) to the Broad VPN.

::: tab

### Mac

1. Open Terminal from `/Applications/Utilities` or Spotlight Search.
1. Type <kbd>ssh \<username\>@login.broadinstitute.org</kbd> [Example: ssh jcase@login.broadinstitute.org ]
1. Enter your Broad password when prompted.

### Linux

1. Most Linux systems use Ctrl-Alt-T to start a Linux Terminal session.
1. On the command line, type <kbd>ssh \<username\>@login.broadinstitute.org</kbd> [Example: ssh jcase@login.broadinstitute.org ]
1. Enter your Broad password when prompted.

### Windows - WSL

1. Open WSL from the start menu item or by typing <kbd>wsl</kbd> from a command prompt or PowerShell.
1. Type <kbd>ssh \<username\>@login.broadinstitute.org</kbd> [Example: ssh jcase@login.broadinstitute.org ]
1. Enter your Broad password when prompted.

### Windows - SecureCRT

1. Launch [SecureCRT](https://broad.service-now.com/sp?sys_kb_id=072a3dc613eb0f80449fb86f3244b0e8&id=kb_article_view&sysparm_rank=1&sysparm_tsqueryId=f5b28afe47714e50a5d9a8ba216d43e9) from the Start menu 
1. Go to the File menu and select "Connect". Select the "New Session"" button.
1. Within the New Session Wizard window, select SSH2 at the Protocol toggle and click Next.
1. Within the Hostname field, enter login.broadinstitute.org. Leave the Port and Firewall fields set to their defaults. Within the username field, enter your Broad username and click Next.
1. Leave the SecureFX protocol field as is (eg. SFTP), click Next.
1. Leave the session name field as it is, or rename it to something shorter. Click the Finish button.
1. X11 setup (for future reference, not needed for this workshop): Select the newly created connection entry and click the Properties icon button. The Session Options window will appear. Select Remote/X11 from the menu on the left, check Forward X11 packets. Click the OK button to close the window.
1. Finally, select your session and click the Connect button. Enter your password to log on.

:::

:::::::::::::::::::::::::::::::::::::::::: spoiler

## Setup instructions if not continuing from Episode 1

Download `cb_unix_shell.tgz` to your home directory and unpack it.

```bash
$ cd
$ wget https://github.com/jlchang/cb-unix-shell-lesson-template/raw/main/learners/files/cb_unix_shell.tgz
$ tar -xzf cb_unix_shell.tgz
```

::::::::::::::::::::::::::::::::::::::::::

In Unix 101, part 1 we learned how to use `pwd` to find our current location within our file system.
We also learned how to use `cd` to change locations and `ls` to list the contents
of a directory.

Let's use these commands to navigate to the `cb_unix_shell` directory.

```bash
$ cd                       # change directory to your home directory
$ ls                       # list the contents in the directory
$ cd cb_unix_shell         # change to a subdirectory within your home directory
```

```output
-bash:login01:~ 123 $ cd
-bash:login01:~ 124 $ ls
cb_unix_shell/	cb_unix_shell.tgz
-bash:login01:~ 125 $ cd cb_unix_shell 
-bash:login01:~/cb_unix_shell 126 $
```

Let's have a look around and then navigate to the `Dahl/James_and_the_Giant_Peach/` directory

```bash
$ pwd                      # print working directory
$ ls -l                    # list directory contents using the long format
$ cd ..                    # use a _relative path_ to go "up" a directory
$ cd c<tab>/D<tab>/J<tab>  # use tab completion for efficiency and less typing
```
```output
-bash:login01:~/cb_unix_shell 126 $ pwd
/home/unix/jlchang/cb_unix_shell
-bash:login01:~/cb_unix_shell 127 $ ls -l  
total 515
drwxr-sr-x   4 jlchang sequence    94 May  8 01:53 Dahl/
drwxr-sr-x   4 jlchang sequence    68 May  8 01:56 Seuss/
-rw-r--r--   1 jlchang sequence   155 Mar 14  2013 authors.txt
-rw-r--r--   1 jlchang sequence 19085 Mar 14  2013 data
drwxr-sr-x 268 jlchang sequence 19483 May  8 01:55 prodinfo454/
-bash:login01:~/cb_unix_shell 128 $ cd ..
-bash:login01:~ 129 $ cd cb_unix_shell/Dahl/James_and_the_Giant_Peach/
-bash:login01:~/cb_unix_shell/Dahl/James_and_the_Giant_Peach/ 130 $
```
Do you remember the special character tilde (~)? You can use it to help navigate directly to the `cb_unix_shell/prodinfo454` directory.

```bash
$ cd ~/c<tab>/p<tab>       # ~ is a special shortcut for your home directory
```
```output
-bash:login01:~/cb_unix_shell/Dahl/James_and_the_Giant_Peach/  130 $ cd ~/cb_unix_shell/prodinfo454/
-bash:login01:~/cb_unix_shell/prodinfo454 131 $
```

`prodinfo454` is the directory where we had a ton of stuff. You can get a list of everything with `ls` but you can also be selective by using a wildcard. `*` matches zero or more characters while `?` matches exactly one character (or the end of line character).

```bash
$ ls                           # output skipped in the block below - too much!
$ ls -d *snap*                 # list run folders from the snap machine
$ ls -d R_2009_?2_*crinkle*    # list run folders from February or December for crinkle runs
```
```output
-bash:login01:~/cb_unix_shell/prodinfo454 132 $ ls -d *crinkle*
R_2009_01_16_11_50_39_snap_levesque_TresFusoUnoColiRUN647204/
R_2009_01_30_12_11_52_snap_jdiaz_HMProchloroRUN702823/
R_2009_06_19_11_34_42_snap_aholling_0619TFSnapRun646641/
R_2009_07_09_11_24_35_snap_krizzolo_krizzolo070909RUN715150/
R_2009_07_15_11_57_04_snap_krizzolo_15julydosjdcRun713445/
R_2009_07_31_10_57_24_snap_jdiaz_31julyjdcRun718215/
R_2009_09_14_16_33_10_snap_aholling_HossBDayRun718349/
R_2009_09_16_14_13_24_snap_krizzolo_091609KRRun718211/
R_2009_10_02_11_21_01_snap_krizzolo_100209Run718213/
R_2009_11_12_13_13_37_snap_krizzolo_111209_16s2_KRRun715342/
-bash:login01:~/cb_unix_shell/prodinfo454 133 $ ls -d R_2009_?2_*crinkle*
R_2009_02_18_13_14_30_crinkle_pfrere_TICycleReduxRUN705472/
R_2009_12_04_11_12_45_crinkle_krizzolo_elgranvaronblastoRun720551/
R_2009_12_08_13_19_52_crinkle_krizzolo_8regionKRRun720565/
R_2009_12_14_11_22_09_crinkle_krizzolo_2regionKRRun722286/
```

Now that we've reviewed how to move around, let's play with some files! Let's look in one of these directories and see what's in them. (Note: run folders hold a lot of information, we've removed the majority of the data, leaving only the log files.)

```bash
$ ls *Tues* 
$ cd *Tues*             # if your wildcard matches more than one, cd will take the first          
$ cat aaLog.txt         # output skipped in the block below - too long!
$ head aaLog.txt        # show the first 10 lines
$ tail aaLog.txt        # show the last 10 lines
```

```output
-bash:login01:~/cb_unix_shell/prodinfo454 134 $ ls -d *Tues* 
R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071/
-bash:login01:~/cb_unix_shell/prodinfo454 135 $ cd *Tues* 
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 136 $ cat aaLog.txt
<output skipped>
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 137 $ head aaLog.txt
nPixelsUnderDCOffset = 11849 (0.070626 %)
adjusting dc offset
found 4 regions
region 0: center = 520, width = 794
region 1: center = 1544, width = 788
region 2: center = 2584, width = 792
region 3: center = 3598, width = 782
range 0: start = 259, end = 781
range 1: start = 1283, end = 1805
range 2: start = 2323, end = 2845
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 138 $ tail aaLog.txt
newApyraseWashPulseWidth = 202.298
adjusted pulse width is 202
changing micro's pulse width to 202
process image block...
apyrase adjust done
MsgType = 108, Index = 27, Pulse = 202
SCRIPT_PULSE_WIDTH_NOTIFY msg received
MsgType = 204, Index = 27, Pulse = 202
Run Complete Msg received
run log ends
```

You can use a paging file viewer to control your view of the file content.
```bash
$ less aaLog.txt        # use a paging file viewer; <space> to proceed, q to quit
```

Make a copy of a file, in your current working directory, your home directory, 

```bash
$ cp aaLog.txt copy.txt        # make a copy with a different name
$ ls                           # see your copy
$ ls ~                         # what's in your home directory?
$ cp aaLog.txt ~/copy2.txt     # make a copy in your home directory
$ ls                           # what's in your current directory *Use up arrow 3x*
$ ls ~                         # what's in your home directory now? *Use up arrow 3x*
```
```output
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 139 $ cp aaLog.txt copy.txt  
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 140 $ ls
aaLog.txt  copy.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 141 $ ls ~
cb_unix_shell/	cb_unix_shell.tar 
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 142 $ cp aaLog.txt ~/copy2.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 143 $ ls
aaLog.txt  copy.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 144 $ ls ~
cb_unix_shell/	cb_unix_shell.tar  copy2.txt
```

Moving and renaming files is very similar but watch carefully! The differences are important

```bash
$ mv aaLog.txt copy3.txt       # if the second argument for "mv" isn't a directory, you're renaming
$ ls                           # notice aaLog.txt is gone, you renamed it!
$ ls ~                         # what's in your home directory?
$ mv copy.txt ~                # tilde (~) shortcut for your home directory => moving, not renaming
$ ls                           # what's in your current directory *Use up arrow 3x*
$ ls ~                         # what's in your home directory now? *Use up arrow 3x*
$ mv copy.txt aaLog.txt        # rename one of the copies to restore aaLog.txt
$ ls                           # what's in your current directory now? *Use up arrow 3x*
```

```output
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 145 $ mv aaLog.txt copy.txt  
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 146 $ ls
copy.txt  copy3.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 147 $ ls ~
cb_unix_shell/	cb_unix_shell.tar  copy2.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 148 $ mv copy3.txt ~
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 149 $ ls
copy.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 150 $ ls ~
cb_unix_shell/	cb_unix_shell.tar  copy2.txt  copy3.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 151 $ mv copy.txt aaLog.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 152 $ ls
aaLog.txt
```

Create a directory

```bash
$ mkdir test                   # make a directory
$ ls                           # see your new directory
$ cp aaLog.txt test            # copy a file into the directory
$ ls                           # what's in your current directory
$ ls test                      # what's in your new directory?
$ ls -R                        # recursively show what's in your current directory
$ rmdir test                   # try to remove the test directory
$ rm -rf test                  # force remove the test directory, recursively (include contents)
$ ls 
```

```output
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 153 $ mkdir test 
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 154 $ ls
aaLog.txt  test/
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 155 $ cp aaLog.txt test   
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 156 $ ls
aaLog.txt  test/
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 157 $ ls test
aaLog.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 158 $ ls -R .:
aaLog.txt  test/

./test:
aaLog.txt
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 159 $ rmdir test
rmdir: failed to remove 'test': Directory not empty
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 160 $ rmdir -rf test
-bash:login01:~/cb_unix_shell/prodinfo454/R_2010_07_27_11_06_59_pop_jdiaz_dmTuesrun738071 161 $ ls
aaLog.txt
```
:::::::::::::::::::::::::::::::::::::::: keypoints

- We've reviewed navigation, file content viewing, file manipulation. 
- We're ready to learn about how you can use these Unix command line techniques and deploy them to perform tasks in a repeatable, effort-saving manner!

::::::::::::::::::::::::::::::::::::::::::::::::::
