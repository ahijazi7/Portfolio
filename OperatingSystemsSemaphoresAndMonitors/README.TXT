I've implemented four programs: boundedBuffer, Bridge, SavingsAccount, and SavingsAccountFCFS. 
For the first two programs, the main things that I implemented were just mutex locks to solve the critical section


Program 1

For the bounded buffer, I made it so that the buffer was circular using an array and a count variable
I implemented locks to make sure that only one consumer/producer could be in at once



Program 2

For the bridge program, I implemented a similar lock so that only one car was handled at one time. 
I implemented a condition wait when the isSafe function returned false, meaning the direction was wrong or there were more than
3 cars

I created an array of 50 car threads, and passed in the ID to better keep track




Program 3 Part A

For the SavingsAccount problems, the implementation is pretty simple. 
For both parts I only created one test case, but I thought it was thorough enough
I passed a struct into the pthread, so that I could have both an ID and a balance, which made it really easy to keep track

For the test cases, I made it so that if the customer ID was divisible by three they would deposit directly
If the remainder was 1 they would only deposit a third of the amount
This was to ensure that the balance would never constantly be overflowing so that the withdraws would never have to wait

Otherwise, the customers would just withdraw

The algorithm was straightforward. One customer in at once, which was ensured by a mutex lock
If the customer deposited, the balance would be added and all sleeping threads (threads who are waiting on balance to withdraw) would wake up using a broadcast

If the customer was withdrawing, which was one at a time handled by a mutex, the program would first check if there was enough balance.
if there was, the customer would just withdraw
Otherwise, the customer thread would be put to sleep using the wait signal. 

Then, as described above, when money is deposited all sleeping threads are woken up.

I included an additional manual deposit statement of a large number to ensure that all threads would be able to withdraw. Otherwise the program would run infinitely if the last thread was a withdraw and there wasnt enough balance.

I made it really large as the number of customer threads is determined at run time, and so if you wanted a large number of threads you might need a larger deposit to account.

Program 3 Part B

Almost everything was identical to Part A. The only thing that really changed was an additional condition called OkToBank. I also modified the algorithm so that there would be deposits of less money so that there would be more withdraws, to better test FCFS.
This condition was used to keep a queue in line, so that FCFS would be implemented

There was a new variable, numberOfWithdrawl. This was used to keep track of how many people were currently withdrawing
If someone was withdrawing, everything would work as the previous program.

However, if a second person attempted to withdraw while the first person was still waiting, the condition OkToBank was set to wait (sleep)

Then, when there was finally enough money for the customer to withdraw, the next thread was woken up at the end of FCFWWithdraw


Running and Sample Outputs


Since the program was created in C, gcc was used to compile. To run the programs, follow these steps:

1. gcc FILENAME.c -c 
2. gcc FILENAME.o
3. ./a.out 

For the boundedBuffer, its important to specify the parameters at runtime. Heres the sample output for that:

ubuntu@Ubuntu22:~/shared$ ./a.out 100 100
the total is 4950
the total is 4950
the total is 4950

and another:

ubuntu@Ubuntu22:~/shared$ ./a.out 100 10
the total is 3701
the total is 5303
the total is 5846


All the other programs run the same way, excluding run time arguments

For bridge.c sample output:

ubuntu@Ubuntu22:~/shared$ gcc bridge.c -c
ubuntu@Ubuntu22:~/shared$ gcc bridge.o
ubuntu@Ubuntu22:~/shared$ ./a.out 
car 1 dir 1 arrives at bridge.
car 1 dir 1 crossing the bridge. Current dir: 1  #cars: 1
car 1 dir 1 exits the bridge.
car 2 dir 0 arrives at bridge.
car 2 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 2 dir 0 exits the bridge.
car 3 dir 1 arrives at bridge.
car 3 dir 1 crossing the bridge. Current dir: 1  #cars: 1
car 3 dir 1 exits the bridge.
car 4 dir 1 arrives at bridge.
car 5 dir 1 arrives at bridge.
car 5 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 5 dir 1 exits the bridge.
car 6 dir 1 arrives at bridge.
car 7 dir 0 arrives at bridge.
car 6 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 6 dir 1 exits the bridge.
car 9 dir 0 arrives at bridge.
car 8 dir 1 arrives at bridge.
car 4 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 4 dir 1 exits the bridge.
car 8 dir 1 crossing the bridge. Current dir: 1  #cars: 1
car 8 dir 1 exits the bridge.
car 10 dir 1 arrives at bridge.
car 10 dir 1 crossing the bridge. Current dir: 1  #cars: 1
car 10 dir 1 exits the bridge.
car 11 dir 0 arrives at bridge.
car 13 dir 1 arrives at bridge.
car 11 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 11 dir 0 exits the bridge.
car 12 dir 0 arrives at bridge.
car 12 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 12 dir 0 exits the bridge.
car 14 dir 1 arrives at bridge.
car 15 dir 1 arrives at bridge.
car 14 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 14 dir 1 exits the bridge.
car 15 dir 1 crossing the bridge. Current dir: 1  #cars: 1
car 16 dir 0 arrives at bridge.
car 17 dir 0 arrives at bridge.
car 18 dir 0 arrives at bridge.
car 19 dir 0 arrives at bridge.
car 20 dir 0 arrives at bridge.
car 22 dir 1 arrives at bridge.
car 22 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 22 dir 1 exits the bridge.
car 21 dir 0 arrives at bridge.
car 23 dir 1 arrives at bridge.
car 23 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 23 dir 1 exits the bridge.
car 24 dir 1 arrives at bridge.
car 24 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 24 dir 1 exits the bridge.
car 25 dir 0 arrives at bridge.
car 26 dir 0 arrives at bridge.
car 27 dir 0 arrives at bridge.
car 28 dir 1 arrives at bridge.
car 28 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 28 dir 1 exits the bridge.
car 29 dir 1 arrives at bridge.
car 29 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 29 dir 1 exits the bridge.
car 30 dir 1 arrives at bridge.
car 30 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 30 dir 1 exits the bridge.
car 32 dir 0 arrives at bridge.
car 33 dir 0 arrives at bridge.
car 34 dir 0 arrives at bridge.
car 35 dir 1 arrives at bridge.
car 35 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 35 dir 1 exits the bridge.
car 36 dir 1 arrives at bridge.
car 36 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 36 dir 1 exits the bridge.
car 37 dir 1 arrives at bridge.
car 37 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 37 dir 1 exits the bridge.
car 38 dir 0 arrives at bridge.
car 39 dir 1 arrives at bridge.
car 39 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 39 dir 1 exits the bridge.
car 40 dir 0 arrives at bridge.
car 41 dir 1 arrives at bridge.
car 41 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 41 dir 1 exits the bridge.
car 42 dir 1 arrives at bridge.
car 42 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 43 dir 1 arrives at bridge.
car 43 dir 1 crossing the bridge. Current dir: 1  #cars: 3
car 43 dir 1 exits the bridge.
car 44 dir 1 arrives at bridge.
car 44 dir 1 crossing the bridge. Current dir: 1  #cars: 3
car 44 dir 1 exits the bridge.
car 45 dir 0 arrives at bridge.
car 46 dir 1 arrives at bridge.
car 46 dir 1 crossing the bridge. Current dir: 1  #cars: 3
car 46 dir 1 exits the bridge.
car 47 dir 0 arrives at bridge.
car 48 dir 0 arrives at bridge.
car 49 dir 1 arrives at bridge.
car 49 dir 1 crossing the bridge. Current dir: 1  #cars: 3
car 49 dir 1 exits the bridge.
car 50 dir 0 arrives at bridge.
car 13 dir 1 crossing the bridge. Current dir: 1  #cars: 3
car 13 dir 1 exits the bridge.
car 15 dir 1 exits the bridge.
car 31 dir 1 arrives at bridge.
car 31 dir 1 crossing the bridge. Current dir: 1  #cars: 2
car 31 dir 1 exits the bridge.
car 42 dir 1 exits the bridge.
car 26 dir 0 crossing the bridge. Current dir: 0  #cars: 3
car 26 dir 0 exits the bridge.
car 45 dir 0 crossing the bridge. Current dir: 0  #cars: 3
car 45 dir 0 exits the bridge.
car 7 dir 0 crossing the bridge. Current dir: 0  #cars: 3
car 7 dir 0 exits the bridge.
car 40 dir 0 crossing the bridge. Current dir: 0  #cars: 3
car 40 dir 0 exits the bridge.
car 48 dir 0 crossing the bridge. Current dir: 0  #cars: 2
car 48 dir 0 exits the bridge.
car 47 dir 0 crossing the bridge. Current dir: 0  #cars: 2
car 47 dir 0 exits the bridge.
car 9 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 9 dir 0 exits the bridge.
car 50 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 50 dir 0 exits the bridge.
car 34 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 34 dir 0 exits the bridge.
car 21 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 21 dir 0 exits the bridge.
car 20 dir 0 crossing the bridge. Current dir: 0  #cars: 2
car 20 dir 0 exits the bridge.
car 18 dir 0 crossing the bridge. Current dir: 0  #cars: 2
car 18 dir 0 exits the bridge.
car 19 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 19 dir 0 exits the bridge.
car 17 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 27 dir 0 crossing the bridge. Current dir: 0  #cars: 3
car 32 dir 0 crossing the bridge. Current dir: 0  #cars: 3
car 17 dir 0 exits the bridge.
car 33 dir 0 crossing the bridge. Current dir: 0  #cars: 3
car 33 dir 0 exits the bridge.
car 27 dir 0 exits the bridge.
car 32 dir 0 exits the bridge.
car 25 dir 0 crossing the bridge. Current dir: 0  #cars: 2
car 25 dir 0 exits the bridge.
car 16 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 16 dir 0 exits the bridge.
car 38 dir 0 crossing the bridge. Current dir: 0  #cars: 1
car 38 dir 0 exits the bridge.


and for SavingAccount.c, the number of threads was determined at runtime. This output is with a sample of 20 customers.


ubuntu@Ubuntu22:~/shared$ gcc SavingAccount.c -c
ubuntu@Ubuntu22:~/shared$ gcc SavingAccount.o
ubuntu@Ubuntu22:~/shared$ ./a.out 20
Customer id: 1, DEPOSIT, current balance: 0, customer amount: 80
Customer id: 2, TRIED TO WITHDRAW, current balance: 80, customer amount: 463
Customer id: 3, DEPOSIT, current balance: 80, customer amount: 13
Customer id: 2, TRIED TO WITHDRAW, current balance: 93, customer amount: 463
Customer id: 5, TRIED TO WITHDRAW, current balance: 93, customer amount: 279
Customer id: 4, DEPOSIT, current balance: 93, customer amount: 162
Customer id: 5, TRIED TO WITHDRAW, current balance: 255, customer amount: 279
Customer id: 2, TRIED TO WITHDRAW, current balance: 255, customer amount: 463
Customer id: 6, DEPOSIT, current balance: 255, customer amount: 72
Customer id: 5, WITHDRAW, current balance: 327, customer amount: 279
Customer id: 2, TRIED TO WITHDRAW, current balance: 48, customer amount: 463
Customer id: 7, DEPOSIT, current balance: 48, customer amount: 258
Customer id: 2, TRIED TO WITHDRAW, current balance: 306, customer amount: 463
Customer id: 9, DEPOSIT, current balance: 306, customer amount: 739
Customer id: 8, WITHDRAW, current balance: 1045, customer amount: 120
Customer id: 2, WITHDRAW, current balance: 925, customer amount: 463
Customer id: 10, DEPOSIT, current balance: 462, customer amount: 252
Customer id: 11, WITHDRAW, current balance: 714, customer amount: 257
Customer id: 12, DEPOSIT, current balance: 457, customer amount: 986
Customer id: 14, WITHDRAW, current balance: 1443, customer amount: 701
Customer id: 15, DEPOSIT, current balance: 742, customer amount: 879
Customer id: 17, WITHDRAW, current balance: 1621, customer amount: 430
Customer id: 18, DEPOSIT, current balance: 1191, customer amount: 695
Customer id: 19, DEPOSIT, current balance: 1886, customer amount: 231
Customer id: 999, DEPOSIT, current balance: 2117, customer amount: 5000
Customer id: 20, WITHDRAW, current balance: 7117, customer amount: 980
Customer id: 16, DEPOSIT, current balance: 6137, customer amount: 247
Customer id: 13, DEPOSIT, current balance: 6384, customer amount: 111

notice while this is only one test case, the output is very clear in what is happening. You are able to tell when each thread is waiting to withdraw, and when their withdraw finally happens thanks to the ID



Sample output for the FCFS implementation:
Reminder, the deposits are slightly smaller in amount

ubuntu@Ubuntu22:~/shared$ gcc SavingAccountFCFS.c -c
ubuntu@Ubuntu22:~/shared$ gcc SavingAccountFCFS.o
ubuntu@Ubuntu22:~/shared$ ./a.out 20
Customer id: 1, DEPOSIT, current balance: 0, customer amount: 243
Customer id: 3, DEPOSIT, current balance: 243, customer amount: 560
Customer id: 2, WITHDRAW, current balance: 803, customer amount: 705
Customer id: 6, DEPOSIT, current balance: 98, customer amount: 32
Customer id: 4, DEPOSIT, current balance: 130, customer amount: 53
Customer id: 7, DEPOSIT, current balance: 183, customer amount: 227
Customer id: 10, DEPOSIT, current balance: 410, customer amount: 249
Customer id: 9, DEPOSIT, current balance: 659, customer amount: 460
Customer id: 5, WITHDRAW, current balance: 1119, customer amount: 374
Customer id: 8, TRIED TO WITHDRAW, current balance: 745, customer amount: 786
Customer id: 11, TRIED TO WITHDRAW, current balance: 745, customer amount: 190
Customer id: 12, DEPOSIT, current balance: 745, customer amount: 479
Customer id: 8, WITHDRAW, current balance: 1224, customer amount: 786
Customer id: 11, WITHDRAW, current balance: 438, customer amount: 190
Customer id: 13, DEPOSIT, current balance: 248, customer amount: 127
Customer id: 16, DEPOSIT, current balance: 375, customer amount: 33
Customer id: 17, TRIED TO WITHDRAW, current balance: 408, customer amount: 520
Customer id: 18, DEPOSIT, current balance: 408, customer amount: 170
Customer id: 19, DEPOSIT, current balance: 578, customer amount: 274
Customer id: 999, DEPOSIT, current balance: 852, customer amount: 5000
Customer id: 17, WITHDRAW, current balance: 5852, customer amount: 520
Customer id: 20, WITHDRAW, current balance: 5332, customer amount: 470
Customer id: 15, DEPOSIT, current balance: 4862, customer amount: 96
Customer id: 14, WITHDRAW, current balance: 4958, customer amount: 850



Here, customer 8 can not withdraw as they are 41 dollars short. Customer 11 comes after and only wants to withdraw 190 dollars of the available 745. 
This should be reasonable, however customer 8 is currently in queue so customer 11 is unable to withdraw until customer 8 does. 

Customer 8 finally withdraws on line 301, and customer 11 follows on line 302. 













