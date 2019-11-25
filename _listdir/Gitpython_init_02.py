# Gitpython_init_00
import sys, os

from git import Repo

from pathlib import Path

exec(open('listdir_miners_list.py').read())

### os.environ
home = os.environ.get('HOMEPATH')
path_join_root = os.path.join(home, 'Documents\\GitHub\\TurtleHTTP\\')
root_turtlehttp = os.listdir(path_join_root)

path_join_subf = os.path.join(home, 'Documents\\GitHub\\TurtleHTTP\\_listdir\\')
subf_turtlehttp = os.listdir(path_join_subf)

repo_turtle_path = path_join_root

print('path_join_root:',path_join_root)
print('path_join_subf:',path_join_subf)

print('root_turtlehttp:',root_turtlehttp)
print('subf_turtlehttp:',subf_turtlehttp)

repo = Repo(repo_turtle_path)

print()
print('Is this repo dirty?')
print(repo.is_dirty())
print()
if repo.is_dirty():
    print('repo.untracked_files:')
    print(repo.untracked_files)
    print()
    print('repo.index.diff items:')
    for item in repo.index.diff(None):
        #print(item)
        print(item.a_path)
print()
print('.')
print('..')
print('...')
print()

### ADD NEW UNTRACKED FILES.
### This works with repo.index.add no problem.
print('for file in repo.untracked_files:')
for file in repo.untracked_files:             ## for each file in the subdir, compose a new_file_path by os.path.join-ing the repo's working_tree_directory and the file name
     if file != '.git':
         print('file:', file)
         new_file_path = (os.path.join(repo.working_tree_dir, file))
         print('new_file_path:', new_file_path)
         print('repo.index:', repo.index)
         #open(file,'w').close
         repo.index.add([new_file_path])             ## Add the file located at new_file_path to the repo's index
print()



### ADD DIFFED FILES.
print('for file in repo.index.diff:')
for file in repo.index.diff(None):             ## for each file in the subdir, compose a new_file_path by os.path.join-ing the repo's working_tree_directory and the file name
    print('file.a_path:', file.a_path)
    new_file_path = os.path.join(repo.working_tree_dir, file.a_path)
    print('new_file_path:', new_file_path)
    print('repo.index:', repo.index)
    #open(new_file_path,'w').close
    repo.index.add([new_file_path])             ## Add the file located at new_file_path to the repo's index
    print()
print()

from pathlib import Path
print('list_subf:', subf_turtlehttp)
print()



dirs = os.listdir()                     ## parent dir of this code, I believe
subdir = os.listdir(path_join_subf)     ##
print('os.getcwd()')
print(os.getcwd())

cwd = os.getcwd()

print('dirs:', dirs)
print('subdir:', subdir)
print()

#print('for file in subdir:')
#for file in subdir:             ## for each file in the subdir, compose a new_file_path by os.path.join-ing the repo's working_tree_directory and the file name
#    if file != '.git':
#        print('file:', file)
#        #print('repo.working_tree_dir:', repo.working_tree_dir)
#        path_join1 = os.path.join(cwd, file)
#        print('type path_join1:', type(path_join1))
#        print('path_join1:', path_join1)
#        print('repo.index:', repo.index)
#        #open(file,'w').close
#        repo.index.add([path_join1])             ## Add the file located at path_join1 to the repo's index
#print()





from git import Actor
author = Actor("OT", "OT@example.com")
committer = Actor("OT", "OT@example.com")
# commit by commit message and author and committer
print('index.commit:')
commit_message = 'tidying...'
repo.index.commit(commit_message, author=author, committer=committer)            ## Commit the index changes
print()

print('repo.remotes:', repo.remotes)
origin = repo.remotes[0]

print('origin.push()')
origin.push()

###
