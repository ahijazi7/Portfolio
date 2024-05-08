// Abdu Hijazi
/*
Sorting Playing Cards

This program reads a list of playing cards from the input file,
creates an array of Card type objects, then sorts them with the help
of a custom comparison function.

*/

#include <string>
#include <iostream>
#include <fstream>
#include <sstream>
#include <cctype>
#include <algorithm>
#include <vector>
#include <list>
#include <tuple>

using namespace std;

// Utility functions
void loadFile(string fname, fstream& file)
{
    file.open(fname.c_str());
    if (file.fail())
    {
        cout << "Cannot open file " << fname << endl;
    }
}

// converts string to lowercase
string lowercase(string s)
{
    for (unsigned int i = 0; i < s.length(); i++)
    {
        s[i] = std::tolower(s[i]);
    }
    return s;
}


// Class representing a playing card
class Card
{
public:
    string value; // 2, 3, 4, ..., Queen, King, Ace
    string suit; // Clubs, Diamonds, Hearts, Spades
    // constructor
    // no input validation here!
    Card(string v, string s) : value(v), suit(s) {}

    bool operator < (Card& c) const;
    void print() const;

    int cardFaceInt() const;
    int cardSuitInt() const;
};

// helper functions for comparison
int
Card::cardFaceInt() const
{
    int result = 0;
    if (this->value == "2")
    {
        result = 0;
    }
    if (this->value == "3")
    {
        result = 1;
    }
    if (this->value == "4")
    {
        result = 2;
    }
    if (this->value == "5")
    {
        result = 3;
    }
    if (this->value == "6")
    {
        result = 4;
    }
    if (this->value == "7")
    {
        result = 5;
    }
    if (this->value == "8")
    {
        result = 6;
    }
    if (this->value == "9")
    {
        result = 7;
    }
    if (this->value == "10")
    {
        result = 8;
    }
    if (this->value == "Jack")
    {
        result = 9;
    }
    if (this->value == "Queen")
    {
        result = 10;
    }
    if (this->value == "King")
    {
        result = 11;
    }
    if (this->value == "Ace")
    {
        result = 12;
    }

    return result;
}
int
Card::cardSuitInt() const
{
    int result = 0;
    if (this->suit == "Clubs")
    {
        result = 0;
    }
    if (this->suit == "Diamonds")
    {
        result = 1;
    }
    if (this->suit == "Hearts")
    {
        result = 2;
    }
    if (this->suit == "Spades")
    {
        result = 3;
    }
    return result;

}

// Less than comparison operator overload
// INPUT: a Card c
// OUTPUT: True if 'this' Card is less than Card c, False otherwise
bool
Card::operator < (Card& c) const
{
    // Your code here

    if (cardFaceInt() < c.cardFaceInt()) // if card is greater automatically return true, else false
        return true;

    else if (cardFaceInt() > c.cardFaceInt())
        return false;

    else {
        if (cardSuitInt() < c.cardSuitInt()) // if card face values are equal check suit
            return true;

        else
            return false;
    }
}

// prints out a string representation of the Card
void
Card::print() const
{
    cout << this->value << " " << this->suit << endl;
}



// INPUT: a list of Cards
// OUTPUT: a sorted list of Cards (descending order)
list<Card>
mergeSort(list<Card> cards)
{
    // Your code here

    list<Card> sequence;
    
    if (cards.size() == 1)
        return cards;

    if (cards.size() > 1) {

        list <Card> sequenceOne; 
        list <Card> sequenceTwo;

        int x = cards.size() / 2;

        while (sequenceOne.size() < x) { // partioning first half of sequence
            sequenceOne.push_back(cards.front());
            cards.pop_front();
        }
        while (!cards.empty()) { // partioning second half of sequence
            sequenceTwo.push_back(cards.front());
            cards.pop_front();
        }

        sequenceOne = mergeSort(sequenceOne);
        sequenceTwo = mergeSort(sequenceTwo); 

        while (!sequenceOne.empty() && !sequenceTwo.empty()) { //merge sort comparator for if both non-empty
            if (sequenceTwo.front() < sequenceOne.front()) {
                sequence.push_back(sequenceOne.front());
                sequenceOne.pop_front();
            }
            else {
                sequence.push_back(sequenceTwo.front()); 
                sequenceTwo.pop_front();
            }
        }
        while (!sequenceOne.empty()) { // if one sequences is empty, the other sequences' element gets pushed
            sequence.push_back(sequenceOne.front());
            sequenceOne.pop_front();
        }
        while (!sequenceTwo.empty()) {
            sequence.push_back(sequenceTwo.front());
            sequenceTwo.pop_front();
        }

    }
    return sequence;
}


// INPUT: a list of (int, Card) tuples
// OUTPUT: a sorted list of (int, Card) tuples in descending order
list<tuple<int, Card> >
bucketSort(list<tuple<int, Card> > cards, int numBuckets)
{
    // Your code here
    vector <vector<tuple<int, Card>>> bucketCollection(numBuckets); //creates bucketCollection
    list<tuple<int, Card> > final; //creates final list

    while (!cards.empty()) { // while list of cards isnt empty, push the front of the cards into the bucket collection
        tuple<int, Card> temp = cards.front();
        cards.pop_front();
        bucketCollection.at(get<0>(temp)).push_back(temp); // pushing cards into vector of vector of matching tuple int value
    }

    for (int i = 0; i <= numBuckets-1; i++) { // removing from the vector into the final list while using a stable sort
        while (!bucketCollection.at(i).empty()) {
            tuple<int, Card> temp1 = bucketCollection.at(i).front();
            bucketCollection.at(i).erase(bucketCollection.at(i).begin());
            final.push_back(temp1);

        }
    }
    return final;
}

// INPUT: a list of Cards
// OUTPUT: a sorted list of Cards (descending order)
list<Card> 
lexSort(list<Card> cards)
{
    // Your code here
    list<tuple<int, Card> > cards2; // list for int  value = 0
    list<tuple<int, Card> > cards3; // list for int value = suit value
    list<tuple<int, Card> > cards4; // list for int value = face value


    while(!cards.empty()) { // setting all cards in cards to have an int value of 0 initially, and moving from tuple list to list of cards
        tuple<int, Card> temp(0, cards.front());
        cards.pop_front();
        cards2.push_back(temp);
        
    }

    while(!cards2.empty()) {
        tuple<int, Card> temp1(get<1>(cards2.front()).cardSuitInt(), get<1>(cards2.front())); // then setting all cards in cards 2 to have an int value of the suit
        cards2.pop_front();
        cards3.push_back(temp1); 
     }
    cards3 = bucketSort(cards3, 4); // bucket sort for suit

    while (!cards3.empty()) { // setting all cards in card 3 to have int value for face value
        tuple<int, Card> temp2(get<1>(cards3.front()).cardFaceInt(), get<1>(cards3.front()));
        cards3.pop_front();
        cards4.push_back(temp2);
    }

    cards4 = bucketSort(cards4, 13); // bucket sort for face value

    list<Card> finalCards;

    while(!cards4.empty()) { // moving the solution from a tuple list to just a slist of cards
        finalCards.push_front(get<1>(cards4.front()));
        cards4.pop_front();
    }

    return finalCards;


}

int main()
{
    string inputFilename = "input.txt";
    string line;
    bool echo = true;

    list<Card> cards = list<Card>();
    // open input file
    fstream inputFile;
    loadFile(inputFilename, inputFile);
    while (getline(inputFile, line))
    {
        // echo input
        if (echo) cout << line << endl;
        // parse input using a stringstream
        stringstream lineSS(line);
        string token;
        string command;
        // store tokens in a vector
        vector<string> tokens;
        while (getline(lineSS, token, ' '))
        {
            // trim whitespace
            token.erase(token.find_last_not_of(" \n\r\t") + 1);
            tokens.push_back(token);
        }

        if (tokens.size() > 0)
        {
            command = tokens[0]; // first token is the command
        }
        else
        {
            command = "";
        }

        if (command == "card")
        {
            cards.push_back(Card(tokens[1], tokens[2]));
        }
        if (command == "merge_sort")
        {
            cards = mergeSort(cards);
        }
        if (command == "lex_sort")
        {
            cards = lexSort(cards);
        }
        if (command == "print")
        {
            for (Card c : cards)
            {
                c.print();
            }
        }
        if (command == "noecho")
        {
            echo = false;
        }


    }
    inputFile.close();
    return EXIT_SUCCESS;
}