require_relative './testing.rb'


arr = Marshal.load(File.read('txt.dump'))

arr[0].user = "Pasha"
File.open('txt.dump', 'w') { |f| f.write(Marshal.dump(arr)) }
# puts arr[0].user




### Example for serializing/saving data
# m = [
#     [
#      [0, 0, 0],
#      [0, 0, 0],
#      [0, 0, 0]
#     ],
#     [
#      [0, 0, 0],
#      [0, 0, 0],
#      [0, 0, 0]
#     ]
#    ]

# # Quick way of opening the file, writing it and closing it
# File.open('yaml.dump', 'w') { |f| f.write(YAML.dump(m)) }
# File.open('marshal.dump', 'wb') { |f| f.write(Marshal.dump(m)) }

# # Now to read from file and de-serialize it:
# YAML.load(File.read('yaml.dump'))
# arr = Marshal.load(File.read('/path/to/marshal.dump'))
