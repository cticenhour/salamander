# Contributing to SALAMANDER

SALAMANDER is a collaborative software project, and all contributions to the code are welcome! Because
multiple developers and groups are working on and using SALAMANDER, we have various standards, procedures,
and testing processes to maintain the software quality of this project. Below, contribution guidelines
and development best practices for SALAMANDER are outlined.

## Follow the SALAMANDER code standards

!style halign=left
When modifying SALAMANDER, the development team requests that all [Code Standards](salamander_scs.md) be
followed. These guidelines make sure that the repository code follows a consistent look and feel to
make development easier.

## Creating and Referencing Issues

!style halign=left
When finding an issue with the code, or developing/suggesting a new feature or enhancement, an issue
should be created. This can be done ahead of time when developing code, or anytime before pushing
your changes. In any case, you will need to list an issue number in one of your commits! To get started:

1. Select “New issue” on this page: [https://github.com/idaholab/salamander/issues](https://github.com/idaholab/salamander/issues)
1. Select either “bug report” or “feature request” (most should be feature requests)
1. Provide issue descriptions of a couple of sentences (or as much as you see fit) following the prompts.
1. Create issue

You will now have an issue number next to the title. We will use it to link the pull request (PR) to the issue.

## Work in a GitHub fork

!style halign=left
SALAMANDER development follows a "Fork & Pull" development process. See more information on
[forking repositories in the GitHub documentation](https://guides.github.com/activities/forking).

### Fork SALAMANDER and clone

1. Navigate to [the SALAMANDER repository](https://github.com/idaholab/salamander)
1. Click the "Fork" button on the upper right of the code file tree to have a copy of SALAMANDER in your own account
1. Clone your new fork to your local machine using the following command (this assumes you
   [have SSH set up on your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account))):

   ```
   cd ~/projects
   git clone git@github.com:<your_user_name>/salamander.git
   ```

   In your local copy, this clone URL is given the shorthand name "origin". This will become relevant
   later in this document.

### Add an upstream git remote

!style halign=left
Add the main SALAMANDER repository as an "upstream" git remote, so that you can
[git fetch](https://git-scm.org/docs/git-fetch) updates from the main repository:

```
cd ~/projects/salamander
git remote add upstream git@github.com:idaholab/salamander.git
```

To fetch changes, run:

```
git fetch upstream
```

## Creating a new branch

Before make any changes locally (which would require having a working version of the application),
we will need to create a new branch.

1. In your terminal, go to your application:

   ```
   cd ~/projects/salamander
   ```

1. It is usually best to make sure your changes are based on devel:

   ```
   git checkout devel
   ```

1. Fetch and reset devel to get it up to date (make sure you do not have any changes on devel, because you would lose that):

   ```
   git fetch upstream && git reset --hard upstream/devel && git submodule update --init
   ```

1. Create new branch:

   ```
   git checkout -b <BRANCH_NAME>
   ```

## Make modifications and commit (the regular development workflow)

At this point, you have a local branch that is up to date with the upstream remote. You’re now ready
to make your changes. Remember, **small, consistent changes** are much better than dumping massive,
unrelated changes all at once.

1. Make your changes locally to address the issue (partly or fully) - using
   [VSCode is recommended](help/development/VSCode.md).
1. In your terminal, go to your application:

   ```
   cd ~/projects/salamander
   ```

1. Make sure that the app still compiles and that the tests run:

   ```
   make -j6 && ./run_tests -j6
   ```

   If you modified the documentation, you can then build and test it locally:

   ```
   cd ~/projects/salamander/doc && ./moosedocs.py build --serve
   ```

1. Type `git status` to see the status of your branch. That should show you the changed files and
   give you some commands to stage them.
1. Once you are ready, perform

   ```
   git add <FILE_NAME_1> <FILE_NAME_2> <FILE_NAME_3> ...
   ```

   to stage your updated files.
1. At that point, it is usually good practice to run

   ```
   git clang-format HEAD~1
   ```

   to fix the formatting of the files based on the `.clang-format` file in the root of the repository.
   If files are changed, run

   ```
   git add <...>
   ```

   for these files.
1. Now you’re ready to commit. Run

   ```
   git commit
   ```

1. A file editor will appear. Press the `i` key, and you’ll be able to type a short description of
   the commit. It is good practice to have a short title, and then a list of items describing the
   changes in more detail. At the bottom, you should add `(Ref. #<ISSUE_NUMBER>)`. It will look
   something like this:

   ```
   Updating this to enable that:
   - Update this file to do this
   - Update documentation to reflect that change
   - Create new test for new capability
   - Update existing gold files to reflect change

   (Ref. #1234)
   ```

1. To exit and save, press `esc`, then type `:wq`. The commit file will close.
1. You might have to do several commits to capture all your changes.

## Generating new documentation pages using MooseDocs

During the course of development, especially during the creation of new SALAMANDER objects (e.g., kernels,
boundary conditions, interface conditions, etc.), it is important to create documentation outlining
any new capabilities. Templates for object documents can be generated using the [MooseDocs system](MooseDocs/index.md)
using the "generate" sub-command. To generate templates for new objects, run:

```
cd ~/projects/salamander
./moosedocs.py generate app_types SalamanderApp
```

For example, with a new object called `SalamanderDiffusion` without documentation, the following output will be seen:

```
% ./moosedocs.py generate app_types SalamanderApp
Creating/updating stub page: /Users/username/projects/salamander/doc/content/source/kernels/SalamanderDiffusion.md
CRITICAL:0 ERROR:0 WARNING:0
```

And the following template would be created:

```markdown
# SalamanderDiffusion

!alert construction title=Undocumented Class
The SalamanderDiffusion has not been documented. The content listed below should be used as a starting point for
documenting the class, which includes the typical automatic documentation associated with a
MooseObject; however, what is contained is ultimately determined by what is necessary to make the
documentation clear for users.

!syntax description /Kernels/SalamanderDiffusion

## Overview

!! Replace these lines with information regarding the SalamanderDiffusion object.

## Example Input File Syntax

!! Describe and include an example of how to use the SalamanderDiffusion object.

!syntax parameters /Kernels/SalamanderDiffusion

!syntax inputs /Kernels/SalamanderDiffusion

!syntax children /Kernels/SalamanderDiffusion
```

Note that certain items, such as the source code description, object parameters, inputs in which the
object is used, and child objects are filled in automatically using the [MooseDocs/extensions/appsyntax.md].
The lines leading with `!!` as well as the `!alert` extension command should be removed and replaced
with relevant documentation regarding how to use the object.

!alert! note title=Use good documentation practices!
When creating documentation, it is particularly important to note any design limitations or assumptions
as well as best practices to apply when using the object.
!alert-end!

Again, make sure to commit these changes using the instructions above before pushing your branch.

## Pushing and submitting SALAMANDER changes

At some point, you'll be ready to push your work to your fork and submit the changes as a pull request
(PR). To do this follow the following steps.

1. To push your work to your fork (remember, it has the remote name `origin`) run:

   ```
   git push origin <BRANCH_NAME>
   ```

1. A link will be printed in the terminal; visit that page.
1. There, you’ll find instructions to create your PR. Fill out the form (one can simply copy what is
   in the commit messages, or write a custom summary of your own) and submit your PR!
1. To notify others (or the SALAMANDER development team), you can also tag people in your PR to get their
   attention.
