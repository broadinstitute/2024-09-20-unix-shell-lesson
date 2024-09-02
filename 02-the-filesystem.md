---
title: Navigating Files and Directories
teaching: 30
exercises: 20
---

::::::::::::::::::::::::::::::::::::::: objectives

- Use a single command to navigate multiple steps in your directory structure, including moving backwards (one level up).
- Perform operations on files in directories outside your working directory.
- Work with hidden directories and hidden files.
- Interconvert between absolute and relative paths.
- Employ navigational shortcuts to move around your file system.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I perform operations on files outside of my working directory?
- What are some navigational shortcuts I can use to make my work more efficient?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Moving around the file system

:::::::::::::::::::::::::::::::::::::::::: spoiler

## Setup instructions if not continuing from Episode 1

Download `cb_unix_shell.tgz` to your home directory and unpack it.

```bash
$ cd
$ wget https://github.com/jlchang/2024-05-09-Unix_Shell_pilot/raw/main/learners/files/cb_unix_shell.tgz
$ tar -xzf cb_unix_shell.tgz
```

::::::::::::::::::::::::::::::::::::::::::

We've learned how to use `pwd` to find our current location within our file system.
We've also learned how to use `cd` to change locations and `ls` to list the contents
of a directory. Now we're going to learn some additional commands for moving around
within our file system.

Use the commands we've learned so far to navigate to the `cb_unix_shell/Dahl` directory, if
you're not already there.

```bash
$ cd
$ cd cb_unix_shell
$ cd Dahl
```

What if we want to move back up and out of this directory and to our top level
directory? Can we type `cd cb_unix_shell`? Try it and see what happens.

```bash
$ cd cb_unix_shell
```

```output
-bash: cd: cb_unix_shell: No such file or directory
```

Your computer looked for a directory or file called `cb_unix_shell` within the
directory you were already in. It didn't know you wanted to look at a directory level
above the one you were located in.

We have a special command to tell the computer to move us back or up one directory level.

```bash
$ cd ..
```

Now we can use `pwd` to make sure that we are in the directory we intended to navigate
to, and `ls` to check that the contents of the directory are correct.

```bash
$ pwd
```

```output
/home/unix/jlchang/cb_unix_shell
```

Note: your output will show your username where you see `jlchang` above.

```bash
$ ls
```

```output
Dahl  Seuss  authors.txt  data  prodinfo454
```

From this output, we can see that `..` did indeed take us back one level in our file system.

You can chain these together like so:

```bash
$ ls ../../
```

prints the contents of `/home/unix`.

:::::::::::::::::::::::::::::::::::::::  challenge

## Finding hidden directories

First navigate to the `cb_unix_shell` directory. There is a hidden directory within this directory. Explore the options for `ls` to
find out how to see hidden directories. List the contents of the directory and
identify the name of the text file in that directory.

Hint: hidden files and folders in Unix start with `.`, for example `.my_hidden_directory`

:::::::::::::::  solution

## Solution

First use the `man` command to look at the options for `ls`.

```bash
$ man ls
```

The `-a` option is short for `all` and says that it causes `ls` to "not ignore
entries starting with ." This is the option we want.

```bash
$ ls -a
```

```output
.  ..  .hidden  Dahl  Seuss  authors.txt  data  prodinfo454
```

The name of the hidden directory is `.hidden`. We can navigate to that directory
using `cd`.

```bash
$ cd .hidden
```

And then list the contents of the directory using `ls`.

```bash
$ ls
```

```output
youfoundit.txt
```

The name of the text file is `youfoundit.txt`.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

In most commands the flags can be combined together in no particular order to obtain the desired results/output.

```
ls -Fa
ls -laF
```

## Examining the contents of other directories

By default, the `ls` commands lists the contents of the working
directory (i.e. the directory you are in). You can always find the
directory you are in using the `pwd` command. However, you can also
give `ls` the names of other directories to view. Navigate to your
home directory if you are not already there.

```bash
$ cd
```

Then enter the command:

```bash
$ ls cb_unix_shell
```

```output
Dahl  Seuss  authors.txt  data  prodinfo454
```

This will list the contents of the `cb_unix_shell` directory without
you needing to navigate there.

The `cd` command works in a similar way.

Try entering:

```bash
$ cd
$ cd cb_unix_shell/Seuss
```

This will take you to the `Seuss` directory without having to go through
the intermediate directory.

:::::::::::::::::::::::::::::::::::::::  challenge

## Navigating practice

Navigate to your home directory. From there, list the contents of the `Seuss`
directory.

:::::::::::::::  solution

## Solution

```bash
$ cd
$ ls cb_unix_shell/Seuss
```

```output
Cat_in_the_Hat  Green_Eggs_and_Ham
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## Full vs. Relative Paths

The `cd` command takes an argument which is a directory
name. Directories can be specified using either a *relative* path or a
full *absolute* path. The directories on the computer are arranged into a
hierarchy. The full path tells you where a directory is in that
hierarchy. Navigate to the home directory, then enter the `pwd`
command.

```bash
$ cd
$ pwd
```

You will see:

```output
/home/unix/jlchang
```

Note: your output will show your username where you see `jlchang` above.

This is the full name of your home directory. This tells you that you
are in a directory named with your username, which sits inside a directory
called `unix` which is found in a directory called
`home` which sits inside the very top directory in the hierarchy. The
very top of the hierarchy is a directory called `/` which is usually
referred to as the *root directory*. So, to summarize: your home directory is a
directory in `unix` which is a directory in `home` which is a directory
in `/`. More on `root` and `home` in the next section.

Now enter the following command:

```bash
$ cd cb_unix_shell/Seuss/Green_Eggs_and_Ham/
```

This jumps forward multiple levels to the `Green_Eggs_and_Ham` directory.
Now go back to the home directory.

```bash
$ cd
```

I can also navigate to the `Green_Eggs_and_Ham` directory using:

```bash
$ cd /home/unix/<username>/cb_unix_shell/Seuss/Green_Eggs_and_Ham
```

You'll need to substitute `<username>` with your Broad username (without angle brackets).

These two commands have the same effect, they both take us to the `Green_Eggs_and_Ham` directory.
The first uses a relative path, giving only the address from the working directory (in this case, your home directory).  The second uses the absolute path, giving the full address from the root directory. A full
path always starts with a `/`. A relative path does not.

A relative path is like getting directions from someone on the street. They tell you to
"go right at the stop sign, and then turn left on Main Street". That works great if
you're standing there together, but not so well if you're trying to tell someone how to
get there from another country. A full path is like GPS coordinates. It tells you exactly
where something is no matter where you are right now.

You can usually use either a full path or a relative path depending on what is most convenient or involves less typing.

Over time, it will become easier for you to keep a mental note of the
structure of the directories that you are using and how to quickly
navigate amongst them.

:::::::::::::::::::::::::::::::::::::::  challenge

## Relative path resolution

Using the filesystem diagram below, if `pwd` displays `/Users/thing`,
what will `ls ../backup` display?

![](fig/filesystem-challenge.svg){alt='File System for Challenge Questions'}

1. `../backup: No such file or directory`
2. `2012-12-01 2013-01-08 2013-01-27`
3. `2012-12-01/ 2013-01-08/ 2013-01-27/`
4. `original pnas_final pnas_sub`

:::::::::::::::  solution

## Solution

1. No: there *is* a directory `backup` in `/Users`.
2. No: this is the content of `Users/thing/backup`,
  but with `..` we asked for one level further up.
3. No: see previous explanation.
  Also, we did not specify `-F` to display `/` at the end of the directory names.
4. Yes: `../backup` refers to `/Users/backup`.

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

### Navigational Shortcuts

The root directory is the highest level directory in your file
system and contains files that are important for your computer
to perform its daily work. While you will be using the root (`/`)
at the beginning of your absolute paths, it is important that you
avoid working with data in these higher-level directories, as
your commands can permanently alter files that the operating
system needs to function. In many cases, trying to run commands
in `root` directories will require special permissions which are
not discussed here, so it's best to avoid them and work within your
home directory. Dealing with the `home` directory is very common.
The tilde character, `~`, is a shortcut for your home directory.
In our case, the `root` directory is **three** levels above our
`home` directory, so `cd` or `cd ~` will take you to
`/home/unix/<username>` and `cd /` will take you to `/`. Navigate to the
`cb_unix_shell` directory:

```bash
$ cd
$ cd cb_unix_shell
```

Then enter the command:

```bash
$ ls ~
```

```output
cb_unix_shell  cb_unix_shell.tgz
```

This prints the contents of your home directory, without you needing to
type the full path.

The commands `cd`, and `cd ~` are very useful for quickly navigating back to your home directory. We will be using the `~` character in later lessons to specify our home directory.

:::::::::::::::::::::::::::::::::::::::: keypoints

- The `/`, `~`, and `..` characters represent important navigational shortcuts.
- Hidden files and directories start with `.` and can be viewed using `ls -a`.
- Relative paths specify a location starting from the current location, while absolute paths specify a location from the root of the file system.

::::::::::::::::::::::::::::::::::::::::::::::::::
