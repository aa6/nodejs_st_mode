# This class was created for educational purposes and is not meant to be used in production.
# The file mode, stored in the st_mode field of the file attributes, contains two kinds of information:
# the filetype code, and the access permission bits.
# @see http://man7.org/linux/man-pages/man2/stat.2.html
# @see http://www.gnu.org/software/libc/manual/html_node/Testing-File-Type.html
# @see /usr/src/linux-headers-X.X.X-X/include/uapi/linux/stat.h
# @see http://stackoverflow.com/questions/36541663/s-isvtx-sticky-bit-constant-name-explanation
# @todo see http://james.padolsey.com/cool-stuff/double-bitwise-not/

S_IFMT  = 0b1111000000000000 # Bitmask for the filetype bitfield. (mask for filetype)
S_IFSCK = 0b1100000000000000 # Filetype constant of a socket. (S_IFSOCK)
S_IFLNK = 0b1010000000000000 # Filetype constant of a symbolic link.
S_IFREG = 0b1000000000000000 # Filetype constant of a regular file.
S_IFBLK = 0b0110000000000000 # Filetype constant of a block device.
S_IFDIR = 0b0100000000000000 # Filetype constant of a directory.
S_IFCHR = 0b0010000000000000 # Filetype constant of a character device.
S_IFIFO = 0b0001000000000000 # Filetype constant of a FIFO named pipe.
S_ISUID = 0b0000100000000000 # SUID (set-user-ID on execution) bitmask.
S_ISGID = 0b0000010000000000 # SGID (set-group-ID on execution) bitmask.
S_ISVTX = 0b0000001000000000 # Sticky bit bitmask.
S_IRWXU = 0b0000000111000000 # Owner permissions bitmask.
S_IRUSR = 0b0000000100000000 # Owner permission to read bitmask.
S_IWUSR = 0b0000000010000000 # Owner permission to write bitmask.
S_IXUSR = 0b0000000001000000 # Owner permission to execute bitmask.
S_IRWXG = 0b0000000000111000 # Group permissions bitmask.
S_IRGRP = 0b0000000000100000 # Group permission to read bitmask.
S_IWGRP = 0b0000000000010000 # Group permission to write bitmask.
S_IXGRP = 0b0000000000001000 # Group permission to execute bitmask.
S_IRWXO = 0b0000000000000111 # Others permissions bitmask.
S_IROTH = 0b0000000000000100 # Others permission to read bitmask.
S_IWOTH = 0b0000000000000010 # Others permission to write bitmask.
S_IXOTH = 0b0000000000000001 # Others permission to execute bitmask.

cast2bool = (value) ->
  switch
    when value is 1, value is true
      return true
    when value is 0, value is false, value is undefined, value is null
      return false
    when typeof value is "number" && !isNaN(value)
      return value isnt 0
    when value.toBoolean?
      return value.toBoolean() is true
    when value.toString? && ["true","yes","on"].indexOf(value.toString().toLowerCase().trim()) != -1
      return true
    else
      value = parseFloat(value)
      return !isNaN(value) && value isnt 0

st_mode = (-> __class = (-> __args = Array.prototype.slice.call(arguments); if @ instanceof __class then (__class.prototype.constructor?.apply(@,__args) if __class isnt __class.prototype.constructor);@ else new (Function.prototype.bind.apply(__class,[null].concat(__args)))); (__class.prototype = if typeof @prototype is 'function' then Object.create(@prototype.prototype) else if @prototype? then @prototype else @); __class.prototype[__prop] = @[__prop] for __prop of @ unless __class.prototype is @; __class).apply

  constructor: (val) ->
    @val(val)

  val: (bitfield) -> # Gets/sets mode value.
    if bitfield is undefined
      return @val
    else
      @val = bitfield & 0b1111111111111111
    return @

  issocket: (bit) -> # Returns if mode has a socket filetype or sets it / unsets if yes.
    switch
      when bit is undefined
        return (@val & S_IFMT) == S_IFSCK
      when cast2bool(bit)
        @val = (@val & ~S_IFMT) | S_IFSCK
      else
        @val = (@val & ~S_IFMT) if @issocket()
    return @

  islink: (bit) -> # Returns if mode has a symbolic link filetype or sets it / unsets if yes.
    switch
      when bit is undefined
        return (@val & S_IFMT) == S_IFLNK
      when cast2bool(bit)
        @val = (@val & ~S_IFMT) | S_IFLNK
      else
        @val = (@val & ~S_IFMT) if @islink()
    return @

  isfile: (bit) -> # Returns if mode has a regular file filetype or sets it / unsets if yes.
    switch
      when bit is undefined
        return (@val & S_IFMT) == S_IFREG
      when cast2bool(bit)
        @val = (@val & ~S_IFMT) | S_IFREG
      else
        @val = (@val & ~S_IFMT) if @isfile()
    return @

  isblkdev: (bit) -> # Returns if mode has a block device filetype or sets it / unsets if yes.
    switch
      when bit is undefined
        return (@val & S_IFMT) == S_IFBLK
      when cast2bool(bit)
        @val = (@val & ~S_IFMT) | S_IFBLK
      else
        @val = (@val & ~S_IFMT) if @isblkd()
    return @

  isdir: (bit) -> # Returns if mode has a directory filetype or sets it / unsets if yes.
    switch
      when bit is undefined
        return (@val & S_IFMT) == S_IFDIR
      when cast2bool(bit)
        @val = (@val & ~S_IFMT) | S_IFDIR
      else
        @val = (@val & ~S_IFMT) if @isdir()
    return @

  ischrdev: (bit) -> # Returns if mode has a character device filetype or sets it / unsets if yes.
    switch
      when bit is undefined
        return (@val & S_IFMT) == S_IFCHR
      when cast2bool(bit)
        @val = (@val & ~S_IFMT) | S_IFCHR
      else
        @val = (@val & ~S_IFMT) if @ischrdev()
    return @

  isfifo: (bit) -> # Returns if mode has a FIFO pipe filetype or sets it / unsets if yes.
    switch
      when bit is undefined
        return (@val & S_IFMT) == S_IFIFO
      when cast2bool(bit)
        @val = (@val & ~S_IFMT) | S_IFIFO
      else
        @val = (@val & ~S_IFMT) if @isfifo()
    return @

  suid: (bit) -> # Gets/sets the SUID (set-user-ID on execution) bit.
    switch
      when bit is undefined
        return (@val & S_ISUID) == S_ISUID
      when cast2bool(bit)
        @val = @val | S_ISUID
      else
        @val = @val & (~S_ISUID)
    return @

  sgid: (bit) -> # Gets/sets the SGID (set-group-ID on execution) bit.
    switch
      when bit is undefined
        return (@val & S_ISGID) == S_ISGID
      when cast2bool(bit)
        @val = @val | S_ISGID
      else
        @val = @val & (~S_ISGID)
    return @

  stickybit: (bit) -> # Gets/sets the sticky bit (set-group-ID on execution) bit.
    switch
      when bit is undefined
        return (@val & S_ISVTX) == S_ISVTX
      when cast2bool(bit)
        @val = @val | S_ISVTX
      else
        @val = @val & (~S_ISVTX)
    return @

  ownerperms: (bitfield) ->
    if bitfield is undefined
      return (@val & S_IRWXU) >> 6
    else
      @val = (@val & ~S_IRWXU) | (bitfield << 6) & S_IRWXU
    return @

  groupperms: (bitfield) ->
    if bitfield is undefined
      return (@val & S_IRWXG) >> 6
    else
      @val = (@val & ~S_IRWXG) | (bitfield << 6) & S_IRWXG
    return @

  otherperms: (bitfield) ->
    if bitfield is undefined
      return (@val & S_IRWXO) >> 6
    else
      @val = (@val & ~S_IRWXO) | (bitfield << 6) & S_IRWXO
    return @

  ownercanread: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IRUSR) == S_IRUSR
      when cast2bool(bit)
        @val = @val | S_IRUSR
      else
        @val = @val & (~S_IRUSR)
    return @

  ownercanwrite: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IWUSR) == S_IWUSR
      when cast2bool(bit)
        @val = @val | S_IWUSR
      else
        @val = @val & (~S_IWUSR)
    return @

  ownercanexecute: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IXUSR) == S_IXUSR
      when cast2bool(bit)
        @val = @val | S_IXUSR
      else
        @val = @val & (~S_IXUSR)
    return @

  groupcanread: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IRGRP) == S_IRGRP
      when cast2bool(bit)
        @val = @val | S_IRGRP
      else
        @val = @val & (~S_IRGRP)
    return @

  groupcanwrite: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IWGRP) == S_IWGRP
      when cast2bool(bit)
        @val = @val | S_IWGRP
      else
        @val = @val & (~S_IWGRP)
    return @

  groupcanexecute: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IXGRP) == S_IXGRP
      when cast2bool(bit)
        @val = @val | S_IXGRP
      else
        @val = @val & (~S_IXGRP)
    return @

  othercanread: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IROTH) == S_IROTH
      when cast2bool(bit)
        @val = @val | S_IROTH
      else
        @val = @val & (~S_IROTH)
    return @

  othercanwrite: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IWOTH) == S_IWOTH
      when cast2bool(bit)
        @val = @val | S_IWOTH
      else
        @val = @val & (~S_IWOTH)
    return @

  othercanexecute: (bit) ->
    switch
      when bit is undefined
        return (@val & S_IXOTH) == S_IXOTH
      when cast2bool(bit)
        @val = @val | S_IXOTH
      else
        @val = @val & (~S_IXOTH)
    return @

  toString: (radix = 2) ->
    return ("0".repeat(32/radix) + @st_mode.toString(radix)).substr(-32/radix,32/radix)
