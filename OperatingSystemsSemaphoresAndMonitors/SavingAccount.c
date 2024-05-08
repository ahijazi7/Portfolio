#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

void deposit(int value, int id);
void withdraw(int value, int id);

int balance = 0;
pthread_cond_t okToWithdraw;
pthread_mutex_t mutex;
int SIZE;
int randomBalance;

struct CustomerStruct{ //creating struct to pass in both a customer ID and the balance
    long idStrcut;
    int customerBalance;
};




void *OneCustomer(void *custParam) {

    struct CustomerStruct *customer;
    customer = (struct CustomerStruct *) custParam; //casting void ptr to struct

    int Pid = (long) customer->idStrcut + 1;
    int amount = (long)customer->customerBalance;

    int random = 0;


    // how I chose to create my test cases. If the id is divisible by 3, deposit the amount directly. If it has a remainder of one, deposit only a third of the amount
    // This is because I don't want the balance to be too high where customers never have to wait to withdraw
    // Otherwise, attempt to withdraw


     if(Pid % 3 == 0) 
        deposit(amount, Pid);

    else if(Pid % 3 == 1)
        deposit(amount/3, Pid);

    else
        withdraw(amount, Pid);

        
    
}

int main(int argc, char *argv[]) {
    srand ( time(NULL) );
    SIZE = atoi(argv[1]);
    if (argc < 2) {
    printf("Usage: SavingsAccount <Number of Customers>\n");
    }


    

    pthread_t customers[SIZE];       // creating array for customers, then creating the threads
        for(long i = 0; i<SIZE; i++){

            struct CustomerStruct* customer = malloc(sizeof(struct CustomerStruct)); //creating memory for the struct
            
            customer->customerBalance =(rand() % 999) + 1; //assigning balance to be between 1 and 1000
            customer->idStrcut = i;

            pthread_create(&customers[i], NULL, OneCustomer, (void*)customer);
        }
        deposit(5000, 999); //this is a final deposit incase the last thread attempts to withdraw and there are no further deposits. This deposit is done manually so the program doesn't run infinitely.
                            // it's also used to test that the withdraw  works


        for(int x=0; x< SIZE; x++) { //joining the threads after
            
       pthread_join(customers[x], NULL);
   }

        pthread_exit(0);
    
}

void deposit(int value, int id){

    pthread_mutex_lock(&mutex); //lock for one customer at a time

    
    printf("Customer id: %d, DEPOSIT, current balance: %d, customer amount: %d\n", id, balance, value);
    
    balance = balance + value;
    pthread_cond_broadcast(&okToWithdraw); //once value is deposited, wake up all sleeping threads so that they can attempt to withdraw now (since new money is added)

    pthread_mutex_unlock(&mutex); //unlock
    sched_yield();

}

void withdraw(int value, int id){
        pthread_mutex_lock(&mutex); //lock for one customer
        

    while(value > balance){
        printf("Customer id: %d, TRIED TO WITHDRAW, current balance: %d, customer amount: %d\n", id, balance, value);        
        pthread_cond_wait(&okToWithdraw, &mutex); //if the balance would go negative, put the thread to sleep
    }
        printf("Customer id: %d, WITHDRAW, current balance: %d, customer amount: %d\n", id, balance, value);

        balance = balance - value;  //once thread wakes up, withdraw
        pthread_mutex_unlock(&mutex);  //unlock

sched_yield();
}