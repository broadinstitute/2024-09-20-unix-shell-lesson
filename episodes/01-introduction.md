---
title: Introducing the Shell
teaching: 10
exercises: 10
---

::::::::::::::::::::::::::::::::::::::: objectives

- Describe key reasons for learning shell.
- Navigate your file system using the command line.
- Access and read help files for `bash` programs and use help files to identify useful command options.
- Demonstrate the use of tab completion, and explain its advantages.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What is a command shell and why would I use one?
- How can I move around on my computer?
- How can I see what files and directories I have?
- How can I specify the location of a file or directory on my computer?

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::: spoiler

## Before we begin

Open the collaborative doc for our workshop https://broad.io/cb-unix-20240509  

![](fig/broad_io-cb-unix-20240509.png){alt='Workshop collaborative doc'}

If you haven't already, please complete your workshop setup https://broad.io/cb-unix-setup

Feel free to browse today's lesson content
::::::::::::::::::::::::::::::::::::::::::

## What is a shell and why should I care?

A *shell* is a computer program that presents a command line interface
which allows you to control your computer using commands entered
with a keyboard instead of controlling graphical user interfaces
(GUIs) with a mouse/keyboard/touchscreen combination.

There are many reasons to learn about the shell:

- Many bioinformatics tools can only be used through a command line interface. Many more
  have features and parameter options which are not available in the GUI.
  BLAST is an example. Many of the advanced functions are only accessible
  to users who know how to use a shell.
- The shell makes your work less boring. In bioinformatics you often need to repeat tasks with a large number of files. With the shell, you can automate those repetitive tasks and leave you free to do more exciting things.
- The shell makes your work less error-prone. When humans do the same thing a hundred different times
  (or even ten times), they're likely to make a mistake. Your computer can do the same thing a thousand times
  with no mistakes.
- The shell makes your work more reproducible. When you carry out your work in the command-line
  (rather than a GUI), your computer keeps a record of every step that you've carried out, which you can use
  to re-do your work when you need to. It also gives you a way to communicate unambiguously what you've done,
  so that others can inspect or apply your process to new data.
- Many bioinformatic tasks require large amounts of computing power and can't realistically be run on your
  own machine. These tasks are best performed using remote computers or cloud computing, which can only be accessed
  through a shell.

In this lesson you will learn how to use the command line interface to move around in your file system. We will learn the basics of the shell by manipulating some data files on a remote Unix server.

## Broad login servers

All Broadies have access to Broad [login servers](https://intranet.broadinstitute.org/bits/service-catalog/scientific-computing/login-servers). These are ’remote server’s, a computer that is not the one you are working on right now.

On a Mac or Linux machine, you can reach the login servers using a program called "Terminal", which is already available
on your computer. The Terminal is a window into which we will type commands. If you're using Windows,
you'll use SecureCRT.

## How to access the remote server

1. Connect to the **Broad-Internal** wireless network.
1. Launch your preferred SSH client, such as Terminal (Mac or Unix) or SecureCRT (Windows)
1. Log in to a Broad login server using the [instructions on the Broad Intranet](https://intranet.broadinstitute.org/bits/service-catalog/scientific-computing/login-servers).

:::::::::::::::::::::::::::::::::::::::::: spoiler

## Your Broad username and Unix password

The portion of your Broad email address before the @ symbol is your Broad username.
Your Unix password is the the same one you use for your Broad-issued computer.
::::::::::::::::::::::::::::::::::::::::::

After logging in, you will see a screen showing something like this:

```output
Last login: Tue Apr 23 08:33:43 2024 from 10.75.224.147
--------------------------------------------------------------
Welcome to the host named login01
RedHat 7.9 x86_64
--------------------------------------------------------------
Puppet:        7.29.1
Facter:        4.6.1
Environment:   production
FQDN:          login01.broadinstitute.org
VLAN:          32
IP:            69.173.65.17
Born On:       2019-07-28
Uptime:        18 days
Model:         VMware Virtual Platform
CPUs:          2
Memory:        7.62 GiB
--------------------------------------------------------------
 IMPORTANT: This login host is a SHARED resource. Please limit
 your usage to editing, simple scripts, and small data transfer
 tasks. To encourage mindful use, limits have been put in place
 including memory limitations.

 To read more about this service, see https://broad.io/login.

 ################## Monthly Reboot Schedule ##################
 Since there is no convenient time to reboot login hosts we
 are establishing a monthly rotation.

 login01   - 1st Sunday of each month at 6 PM
 login02   - 2nd Sunday of each month at 6 PM
 login03   - 3rd Sunday of each month at 6 PM
 login04   - 4th Sunday of each month at 6 PM

 If starting a long session, choose the host rebooted last
--------------------------------------------------------------
This computer system is the property of the Broad Institute.

It is for authorized use only. By using this system all users
acknowledge notice of, and agree to comply with, Broad's
Acceptable Use (broad.io/AcceptableUse).

Unauthorized or improper use of this system may result in
administrative disciplinary action and/or other sanctions.

By continuing to use this system you indicate
your awareness of and consent to Broad's Acceptable Use Policy.
(broad.io/AcceptableUse).

Log off immediately if you do not agree to the conditions
stated in this warning.
--------------------------------------------------------------
```

This provides a lot of information about the login servers. Continuing means
you agree to Broad's acceptable use policy. If you disagree, please type `exit`.
Otherwise let's continue. You can clear your screen using the `clear` command.

Type the word `clear` into the terminal and press the `Enter` key.

```bash
$ clear
```

This will scroll your screen down to give you a fresh screen and will make it easier to read.
You haven't lost any of the information on your screen. If you scroll up, you can see everything that has been output to your screen
up until this point.

:::::::::::::::::::::::::::::::::::::::::  callout

## Tip

Hot-key combinations are shortcuts for performing common commands.
The hot-key combination for clearing the console is `Ctrl+L`. Feel free to try it and see for yourself.

::::::::::::::::::::::::::::::::::::::::::::::::::

## Navigating your file system

The part of the operating system that manages files and directories
is called the **file system**.
It organizes our data into files,
which hold information,
and directories (also called "folders"),
which hold files or other directories.

Several commands are frequently used to create, inspect, rename, and delete files and directories.

```bash
$
```

The dollar sign is a **prompt**, which shows us that the shell is waiting for input;
your shell may use a different character as a prompt and may add information before
the prompt. When typing commands, either from these lessons or from other sources,
do not type the prompt, only the commands that follow it.

:::::::::::::::::::::::::::::::::::::::: spoiler

## [Optional] Customizing your Unix prompt

You may have a prompt (the characters to the left of the cursor) that looks different from the `$` sign character used here.
If you would like to change your prompt to match the example prompt, first type the command:
`echo $PS1`
into your shell, followed by pressing the <kbd>Enter</kbd> key.

This will print the bash special characters that are currently defining your prompt.
To change the prompt to a `$` (followed by a space), enter the command:
`PS1='$ '`
Your window should look like our example in this lesson.

To change back to your original prompt, type in the output of the previous command `echo $PS1` (this will be different depending on the
original configuration) between the quotes in the following command:
`PS1=""`

For example, if the output of `echo $PS1` was `\u@\h:\w $`,
then type those characters between the quotes in the above command: `PS1="\u@\h:\w $ "`.
Alternatively, you can reset your original prompt by exiting the shell and opening a new session.

This isn't necessary to follow along (in fact, your prompt may have other helpful information you want to know about).  This is up to you!

::::::::::::::::::::::::::::::::::::::::::::::::

Let's find out where we are by running a command called `pwd`
(which stands for "print working directory").
At any moment, our **current working directory**
is our current default directory,
i.e.,
the directory that the computer assumes we want to run commands in,
unless we explicitly specify something else.
Here,
the computer's response is `/home/unix/<username>`, also known as your home directory.
It is a common convention to use angle brackets as a hint to substitute an appropriate value (without the brackets).

```bash
$ pwd
```

```output
/home/unix/<username>
```

Your screen will show your username where you see <username> in the output box above.

Let's look at our file system. We can see what files and subdirectories are in this directory by running `ls`,
which stands for "listing":

```bash
$ ls
```

```output

```

`ls` prints the names of the files and directories in the current directory in
alphabetical order,
arranged neatly into columns. Your output may look different if you already have files in your home directory. Let's get some example directories and files so we can practice navigating in a Unix environment.

On most Unix systems, you can grab a file over the internet using a tool called `wget`. We'll talk about `wget` in more detail later. For now, run this command:

```bash
$ wget https://github.com/jlchang/2024-05-09-Unix_Shell_pilot/raw/main/learners/files/cb_unix_shell.tgz
```
:::::::::::::::::::::::::::::::::::::::::: spoiler
## Pasting text into PowerShell (Windows)

To paste text in Windows PowerShell, right click where you want to insert (note: left click will discard what is in your clipboard). For some Windows systems you may need to use `ctrl` + `insert` instead.

::::::::::::::::::::::::::::::::::::::::::::::::::

```output
--2024-04-26 08:57:28--  https://github.com/jlchang/2024-05-09-Unix_Shell_pilot/raw/jlc_episode1_edits/learners/files/cb_unix_shell.tgz
Resolving github.com (github.com)... 140.82.113.4
Connecting to github.com (github.com)|140.82.113.4|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://raw.githubusercontent.com/jlchang/2024-05-09-Unix_Shell_pilot/jlc_episode1_edits/learners/files/cb_unix_shell.tgz [following]
--2024-04-26 08:57:28--  https://raw.githubusercontent.com/jlchang/2024-05-09-Unix_Shell_pilot/jlc_episode1_edits/learners/files/cb_unix_shell.tgz
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.109.133, 185.199.110.133, 185.199.111.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.109.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 115379 (113K) [application/octet-stream]
Saving to: ‘cb_unix_shell.tgz’

cb_unix_shell.tgz              100%[===================================================>] 112.67K  --.-KB/s    in 0.1s

2024-04-26 08:57:29 (892 KB/s) - ‘cb_unix_shell.tgz’ saved [115379/115379]

```

Now if we `ls`

```bash
$ ls
```

```output
cb_unix_shell.tgz
```

We downloaded a "tarball". It's a compressed file that can be unpacked. Let's unpack it!

```bash
$ tar -xzf cb_unix_shell.tgz
```

Now if we `ls` again

```bash
$ ls
```

```output
cb_unix_shell  cb_unix_shell.tgz
```

Let's explore the `cb_unix_shell` subdirectory.

The command to change locations in our file system is `cd`, followed by a
directory name to change our working directory.
`cd` stands for "change directory".

Let's say we want to navigate to the `cb_unix_shell` directory we saw above.  We can
use the following command to get there:

```bash
$ cd cb_unix_shell
```

Let's look at what is in this directory:

```bash
$ ls
```

```output
Dahl  Seuss  authors.txt  data  prodinfo454
```

We can tell `ls` to display more information for each item
in the directory by giving it a command line **flag**. Use the `-l` option for the `ls` command, like so:

```bash
$ ls -l
```

```output
total 515
drwxr-sr-x   4 jlchang puppet    94 May  8 01:53 Dahl
drwxr-sr-x   4 jlchang puppet    68 May  8 01:56 Seuss
-rw-r--r--   1 jlchang puppet   155 Mar 14  2013 authors.txt
-rw-r--r--   1 jlchang puppet 19085 Mar 14  2013 data
drwxr-sr-x 268 jlchang puppet 19483 May  8 01:55 prodinfo454
```

Note: your output will show your username where you see `jlchang` above.

The additional information given includes the name of the owner of the file,
when the file was last modified, and whether the current user has permission
to read and write to the file.

`ls` has lots of other options. To find out what they are, we can type:

```bash
$ man ls
```

`man` (short for manual) displays detailed documentation (also referred as man page or man file)
for `bash` commands. It is a powerful resource to explore `bash` commands, understand
their usage and flags. Some manual files are very long. You can scroll through the
file using your keyboard's down arrow or use the <kbd>Space</kbd> key to go forward one page
and the <kbd>b</kbd> key to go backwards one page. When you are done reading, hit <kbd>q</kbd>
to quit.

::::::::::::::::::::::::::::::::::::::: spoiler

## Make `ls` output more readable at-a-glance

We can make the `ls` output more comprehensible by using the **flag** `-F`,
which tells `ls` to add a trailing `/` to the names of directories:

```bash
$ ls -F
```

```output
Dahl/  Seuss/  authors.txt  data  prodinfo454/
```

Anything with a "/" after it is a directory. Things with a "\*" after them are programs. If
there are no decorations, it's a file. Broad servers use `ls -CF` by default. Knowing `ls -F` can be useful on servers that show plain `ls` output. For a color-coded option, try `ls --color=auto`.

:::::::::::::::::::::::::::::::::::::::::::::::

No one can possibly learn all of these arguments, that's what the manual page
is for. You can (and should) refer to the manual page or other help files
as needed.

Let's go into the `Dahl` directory and see what is in there.

```bash
$ cd Dahl
$ ls -F
```

```output
Charlie_and_the_Chocolate_Factory/  James_and_the_Giant_Peach/
```

This directory contains two subdirectories with long names. Unix has a great trick to minimize typing long names!

### Shortcut: Tab Completion

Typing out file or directory names can waste a
lot of time and it's easy to make typing mistakes. Instead we can use tab complete
as a shortcut. When you start typing out the name of a directory or file, then
hit the <kbd>Tab</kbd> key, the shell will try to fill in the rest of the
directory or file name.

From the `Dahl` directory:

```bash
$ cd J<tab>
```

The shell will fill in the rest of the directory name for
`James_and_the_Giant_Peach`.

Now change directories to `James_and_the_Giant_Peach` in `Dahl`

```bash
$ cd James_and_the_Giant_Peach
```

Using tab complete can be very helpful. However, it will only autocomplete
a file or directory name if you've typed enough characters to provide
a unique identifier for the file or directory you are trying to access.

For example, if we now try to list the files which names start with `Au`
by using tab complete:

```bash
$ ls Au<tab>
```

The shell auto-completes your command to `Aunt_Sp`, because there are two files in
the directory that begin with `Aunt_Sp`. When you hit
<kbd>Tab</kbd> again, the shell will list the possible choices.

```bash
$ ls Aunt_Sp<tab><tab>
```

```output
Aunt_Spiker  Aunt_Sponge
```

Tab completion can also fill in the names of programs, which can be useful if you
remember the beginning of a program name.

```bash
$ pw<tab><tab>
```

```output
pwck      pwconv    pwd       pwdx      pwunconv
```

Displays the name of every program that starts with `pw`.

## Summary

We now know how to move around our file system using the command line.
This gives us an advantage over interacting with the file system through
a GUI as it allows us to work on a remote server, carry out the same set of operations
on a large number of files quickly, and opens up many opportunities for using
bioinformatic software that is only available in command line versions.

In the next few episodes, we'll be expanding on these skills and seeing how
using the command line shell enables us to make our workflow more efficient and reproducible.

:::::::::::::::::::::::::::::::::::::::: keypoints

- The shell gives you the ability to work more efficiently by using keyboard commands rather than a GUI.
- Useful commands for navigating your file system include: `ls`, `pwd`, and `cd`.
- Most commands take options (flags) which begin with a `-`.
- Tab completion can reduce errors from mistyping and make work more efficient in the shell.

::::::::::::::::::::::::::::::::::::::::::::::::::
