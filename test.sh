GCC=$ARCH-elf-gcc
BIN=$ARCH-elf-binutils
GDB=$ARCH-elf-gdb

brew audit $BIN
brew audit $GCC
brew audit $GDB
brew install -v $BIN
brew install -v $GCC
brew install -v $GDB
brew test $BIN
brew test $GCC
brew test $GDB
