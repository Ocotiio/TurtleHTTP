import os
import json

### os.environ
home = os.environ.get('HOMEPATH')
path_join = os.path.join(home, 'Documents\GitHub\TurtleHTTP\computercraft_dir\miners')
dir_list = os.listdir(path_join)

#print('dir_list:', dir_list)

### Create list/dict
append_dict = {}

count = 0
for each in dir_list:
    print('each:', each)
    if each[0] is not '.' and each[0] is not '_':             ## Throw out .git and _
        append_dict[count] = each
        count += 1
        #print('Appended; append_dict:', append_dict)

### Create json
json_store = json.dumps(append_dict)
#print('json_store:')
#print(json_store)

### Export/write 'cc_dir_miners_list.json' from json_store
cc_dir_miners_list = open('cc_dir_miners_list.json', mode='w')
cc_dir_miners_list.write(json_store)
cc_dir_miners_list.close()
