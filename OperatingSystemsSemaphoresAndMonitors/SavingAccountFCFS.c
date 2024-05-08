#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

void FCFSDeposit(int value, int id);
void FCFSWithdraw(int value, int id);

int balance = 0;
pthread_cond_t okToWithdraw;
pthread_mutex_t mutex;
 int SIZE;
int randomBalance;

int numberOfWithdrawl = 0;
pthread_cond_t okToBank;

struct CustomerStruct{ //struct so that ID and balance can be passed through
    long idStrcut;
    int customerBalance;
};




void *OneCustomer(void *custParam) {

    struct CustomerStruct *customer; //casting void ptr to struct
    customer = (struct CustomerStruct *) custParam;

    int Pid = (long) customer->idStrcut + 1;
    int amount = (long)customer->customerBalance;

    int random = 0;

      // how I chose to create my test cases. If the id is divisible by 3, deposit 66% of the amount. This is to better test FCFS. If it has a remainder of one, deposit only a third of the amount
    // This is because I don't want the balance to be too high where customers never have to wait to withdraw
    // Otherwise, attempt to withdraw


//lower deposits to better test FCFS

     if(Pid % 3 == 0)
        FCFSDeposit(amount/1.5, Pid);

    else if(Pid % 3 == 1)
        FCFSDeposit(amount/3, Pid);

    else
        FCFSWithdraw(amount, Pid);

        
    
}

int main(int argc, char *argv[]) {
    srand ( time(NULL) );
    SIZE = atoi(argv[1]);
    if (argc < 2) {
    printf("Usage: SavingsAccount <Number of Customers>\n");
    }

    

    pthread_t customers[SIZE];       // creating array for customers, then creating the threads
        for(long i = 0; i<SIZE; i++){

            struct CustomerStruct* customer = malloc(sizeof(struct CustomerStruct));//creating memory for the struct
            
            
            customer->customerBalance =(rand() % 999) + 1;
            customer->idStrcut = i;

            pthread_create(&customers[i], NULL, OneCustomer, (void*)customer);
        }
//this is a final deposit incase the last thread attempts to withdraw and there are no further deposits. This deposit is done manually so the program doesn't run infinitely.
// it's also used to test that the withdraw  works

        FCFSDeposit(5000, 999);


        for(int x=0; x< SIZE; x++) { //joining the threads after
            
       pthread_join(customers[x], NULL);
   }

        pthread_exit(0);
    
}

void FCFSDeposit(int value, int id){

    pthread_mutex_lock(&mutex);//lock for one customer at a time

    
    printf("Customer id: %d, DEPOSIT, current balance: %d, customer amount: %d\n", id, balance, value);
    
    balance = balance + value;
    pthread_cond_broadcast(&okToWithdraw); //once value is deposited, wake up all sleeping threads so that they can attempt to withdraw now (since new money is added)

    pthread_mutex_unlock(&mutex);//unlock
    sched_yield();

}

void FCFSWithdraw(int value, int id){
        pthread_mutex_lock(&mutex);//lock for one customer at a time
        
        numberOfWithdrawl++; //increment number of people currently withdrawing
        if(numberOfWithdrawl > 1){
            printf("Customer id: %d, TRIED TO WITHDRAW, current balance: %d, customer amount: %d\n", id, balance, value); 
        pthread_cond_wait(&okToBank, &mutex); //if the value is greater than 1, sleep because its FCFS
        }
    while(value > balance){
        printf("Customer id: %d, TRIED TO WITHDRAW, current balance: %d, customer amount: %d\n", id, balance, value);        
        pthread_cond_wait(&okToWithdraw, &mutex); //if the balance would go negative, put the thread to sleep
    }
        printf("Customer id: %d, WITHDRAW, current balance: %d, customer amount: %d\n", id, balance, value);
        numberOfWithdrawl--; //once the withdraw is successful, decrement so that the next person in queue can withdraw
        pthread_cond_signal(&okToBank); //signal threads sleeping in queue
        balance = balance - value;
        pthread_mutex_unlock(&mutex);//unlock

sched_yield();
}