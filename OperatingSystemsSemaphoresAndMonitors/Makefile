CFLAGS= -g
LDFLAGS= -pthread
CC=gcc

all: boundedBuffer bridge SavingAccount SavingAccountFCFS

# To make an executable
boundedBuffer: boundedBuffer.o 
	$(CC) $(LDFLAGS) -o boundedBuffer boundedBuffer.o

bridge: bridge.o 
	$(CC) $(LDFLAGS) -o bridge bridge.o

SavingAccount: SavingAccount.o 
	$(CC) $(LDFLAGS) -o SavingAccount SavingAccount.o

SavingAccountFCFS: SavingAccountFCFS.o 
	$(CC) $(LDFLAGS) -o SavingAccountFCFS SavingAccountFCFS.o
 
# To make an object from source
.c.o:
	$(CC) $(CFLAGS) -c $*.c

# clean out the dross
clean:
	-rm boundedBuffer bridge SavingAccount SavingAccountFCFS *.o 

