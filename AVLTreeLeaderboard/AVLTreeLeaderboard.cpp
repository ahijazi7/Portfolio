

#include <iostream>
#include <cstdlib>
#include <cstring>
#include <string>
#include <fstream>
#include <cstddef>
#include <vector>
#include <sstream>
#include <algorithm>
#include <math.h>

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

// simple data structure used to create nodes for (linked-list) BST-based implementation of an ordered map ADT
// from integer keys to string values
struct Node {
    int key;
    int ht;
    string value;
    int gap; // should be in a derived class
    Node* left;
    Node* right;
    Node* parent;
    // constructors
    Node(int k, string v) :
        key(k), value(v), ht(0), gap(0), left(NULL), right(NULL), parent(NULL) { }
    Node(int k, string v, Node* l, Node* r, Node* p) :
        key(k), value(v), ht(0), gap(0), left(l), right(r), parent(p) { }
};

/*
 *Purpose: Class definition of a simple implementation of an ordered map ADT,
 mapping integers keys to string values, using a binary search tree (BST)
 *NOTE: only basic methods of the ordered map ADT (i.e., put, erase, find, size, empty), and some auxiliary functions (e.g., successor and predecessor) implemented
 *NOTE: For simplicity, and consistency with implementation in other programming languages (e.g., Java and Python), the documentation below refers to variables that are actually pointers to a node in the tree simply as a node in the tree, without the pointer qualification, whenever the distinction is clear from the context
 *NOTE: For consistency with implementation in other programming languages, this implementation does not overload the ++ operator to implement the successor function; similarly for the -- and the predecessor function
*/

class BSTMap
{
public:
    Node* root;
private:
    void deleteNode(Node* w);
    void deleteAll();

    Node* removeNode(Node* w);
    int n;
protected:
    void printAux(const Node* w) const;  // print utility
public:
    BSTMap() : root(NULL), n(0) { };
    ~BSTMap();
    Node** find(int k) const;
    Node* put(int k, string v);
    Node* erase(int k);
    Node* eraseNode(Node* w);
    Node* successor(Node* w) const;
    Node* predecessor(Node* w) const;
    int size() const;
    bool empty() const;
    void print() const;   // print as parenthetic string
    void printTree(Node* s, int space) const;
};

/*
 *Purpose: Implement member functions/methods of BSTMap class
*/

// utility/aux function to print out a parenthetic string representation of the BST
// INPUT: a node w in the BST whose subtree is to be printed out; or NULL
void
BSTMap::printAux(const Node* w) const {
    if (w) {
        cout << "[" << w->key << ":" << w->value << "]";
        cout << "(";
        printAux(w->left);
        cout << "),(";
        printAux(w->right);
        cout << ")";
    }
}

// print out a parenthetic string representation of the whole BST
void
BSTMap::print() const {
    printAux(root);
    cout << endl;
}

// prints out a string representation of the whole BST using a reverse inorder traversal
void
BSTMap::printTree(Node* s, int space) const {
    int addSpace = 8;
    // base case
    if (!s)
    {
        return;
    }
    // add more whitespace
    space = space + addSpace;
    // print right
    this->printTree(s->right, space);

    cout << endl;
    for (int i = addSpace; i < space; i++)
        cout << " ";
    cout << s->key << ":" << s->value << endl;

    // print left
    this->printTree(s->left, space);
}

// POSTCONDITION: The subtree rooted at node w, if any, is properly removed from the BST
void
BSTMap::deleteNode(Node* w)
{
    if (w) {
        Node* z = w->parent;
        // recursively delete children
        deleteNode(w->left);
        deleteNode(w->right);
        if (z) {
            if (z->left == w) z->left = NULL;
            else z->right = NULL;
        }
        delete w;
        n--;
    }
}

// POSTCONDITION: The BST is empty
void
BSTMap::deleteAll()
{
    Node* w = root;
    while (w) {
        if (!(w->left || w->right)) {
            Node* x = w;
            w = w->parent;
            if (w) {
                if (w->left == x) w->left = NULL;
                else w->right = NULL;
            }
            delete x;
            n--;
            continue;
        }
        w = (w->left) ? w->left : w->right;
    }
}

// Destructor
// POSTCONDITION: The BST is empty
BSTMap::~BSTMap() {
    deleteAll();
}

// INPUT: a node w in the BST
// OUTPUT: the parent of w, which may be NULL if w is the root of the BST
// PRECONDITION: w is external (i.e., the left or right subtree, or both, are empty)
// POSTCONDITION: the size of the BST is reduced by 1, and w is properly removed from the BST
Node*
BSTMap::removeNode(Node* w) {
    Node* z = w->parent;
    // identify child if it exists
    Node* x = (w->left) ? w->left : w->right;
    if (x) x->parent = z;
    if (z) {
        // connect w's child
        if (z->left == w) z->left = x;
        else z->right = x;
    }
    else root = x;
    delete w;
    n--;
    return z;
}

// INPUT: a key k, as an integer
// OUTPUT: a 2-element array, where
// element 0 is w, the node with key k, if k is already in the ordered map, or NULL otherwise; and
// element 1 is z, the parent of node w, or NULL if w is NULL or the root
// or the last node visited while trying to find a node with key k in the BST
Node**
BSTMap::find(int k) const {
    Node* w = root;
    Node* z = NULL;
    // while current node is not null and we haven't found the key...
    while (w && (w->key != k)) {
        z = w;
        // check left or right child depending on input
        w = (w->key > k) ? w->left : w->right;
    }
    Node** wAndZ = new Node * [2];
    wAndZ[0] = w;
    wAndZ[1] = z;
    return wAndZ;
}

// INPUT: a key-value pair k and v (integer and string, respectively)
// OUTPUT: if k is already in the ordered map, then output the node containing k, with v replacing the previous map value for k;
// otherwise, output the new node in the tree with the corresponding key-value pair k and v.
// POSTCONDITION: if key k is already in the ordered map, then the node containing k in the BST has v as its new map value;
// otherwise, the size of the BST is increased by 1, and a new node with key-value pair k and v is properly added as a leaf to the BST;
// if the BST was empty, then the new node becomes the root of the BST (and thus its only node)
Node*
BSTMap::put(int k, string v) {
    Node** wAndZ = find(k);
    Node* w = wAndZ[0];
    Node* z = wAndZ[1];
    delete wAndZ;
    // if key already exists, just update value
    if (w) {
        w->value = v;
        return w;
    }
    // otherwise create new node and make it a child of the last searched node
    Node* x = new Node(k, v, NULL, NULL, z);
    if (z) {
        if (z->key > k) z->left = x;
        else z->right = x;
    }
    n++;
    if (n == 1) root = x;
    return x;
}

// INPUT: a node w in the tree, or NULL
// OUTPUT: NULL if w is NULL; otherwise, the parent of w or
// its successor if w is internal (i.e., has both non-empty left and right subtrees)
// POSTCONDITION: if w is NULL, the BST remains the same; otherwise, the size of the BST is reduced by 1,
// and w, or its sucessor if w is internal, is properly removed from the BST;
// also, if w is internal, then the (key,value) pair of the successor node is copied to w before the successor node is removed
Node*
BSTMap::eraseNode(Node* w) {
    if (!w) return NULL;
    if (w->left && w->right) {
        Node* x = successor(w);
        w->key = x->key;
        w->value = x->value;
        w->gap = x->gap;
        w = x;
    }
    Node* z = removeNode(w);
    return z;
}

// INPUT: a key k (as an integer)
// OUTPUT: the node in the tree corresponding to the parent of the node actually removed from the BST during the operation removing the key k from the ordered map; or, if k is not a key in the ordered map, then output the node in the tree last visited during the search for key k, or NULL if the tree is empty
// POSTCONDITION: no node in the BST has key k: that is, if the BST had a node with key k, then it is properly removed; otherwise, the BST remains intact
Node*
BSTMap::erase(int k) {
    Node** wAndZ = find(k);
    Node* w = wAndZ[0];
    Node* z = wAndZ[1];
    delete wAndZ;
    return ((w) ? eraseNode(w) : z);
}

// INPUT: a node w in the tree; or NULL
// OUTPUT: the successor node of w,
// which is the node in the tree with the key immediately following the key of w in the inorder sequence of keys in the ordered map; or
// NULL if w is NULL or w has no successor node in the tree
Node*
BSTMap::successor(Node* w) const {
    if (!w) return NULL;
    // if there is a right child, then sucessor must be in right subtree
    if (w->right) {
        w = w->right;
        while (w->left) w = w->left;
    }
    // otherwise the successor is an ancestor
    else {
        Node* z = w;
        w = w->parent;
        while (w != NULL && w->right == z) {
            z = w;
            w = w->parent;
        }
    }
    return w;
}

// INPUT: a node w in the tree; or NULL
// OUTPUT: the predecessor node of w,
// which is the node in the tree with the key immediately preceding the key of w in the inorder sequence of keys in the ordered map; or
// NULL if w is NULL or w has no predecessor node in the tree
Node*
BSTMap::predecessor(Node* w) const {
    if (!w) return NULL;
    // if there is a left child, then predecessor must be in left subtree
    if (w->left) {
        w = w->left;
        while (w->right) w = w->right;
    }
    // otherwise the predecessor is an ancestor
    else {
        Node* z = w;
        w = w->parent;
        while (w != NULL && w->left == z) {
            z = w;
            w = w->parent;
        }
    }
    return w;
}

// OUTPUT: size of the tree
int
BSTMap::size() const {
    return n;
}

// OUTPUT: true if the tree is empty; false otherwise
bool
BSTMap::empty() const {
    return (!root);
}

/*
 *Purpose: Class definition of a simple implementation of an ordered map ADT,
 mapping integers keys to string values, using an AVL tree, based on the BSTMap class
 *NOTE: only basic methods (i.e., put, erase, and find), including those inherited from BSTMap (i.e., size and empty), and some auxiliary functions (e.g., successor and predecessor) implemented
*/
class AVLTreeMap : public BSTMap {
private:
    int height(Node* w);
    void resetHeight(Node* w);
    bool balanced(Node* w);
    void rebalance(Node* w);
    void makeChild(Node* p, Node* c, bool isLeft);
    void singleRotation(Node* y, Node* z);
    void doubleRotation(Node* x, Node* y, Node* z);
    void gapCalculator(Node* z);
public:
    AVLTreeMap() { };  // default constructor
    Node* put(int k, string v);
    Node* erase(int k);
};


// INPUT: pointer z to a node in the AVL Tree
// PRECONDITION: Node Z is unbalanced
// POSTCONDITION: Node Z is balanced, either through a single or double rotation

void
AVLTreeMap::rebalance(Node* z) {
    // Your code here
    bool d = 0;
    Node* y = NULL;
    Node* x = NULL;


    if (height(z->left) > height(z->right)) //figuring out which child is taller
        y = z->left;
    else {
        y = z->right;
    }
    d = height(y->left) > height(y->right); // checking for which child the X node will be


    if (d > 0 )
        x = y->left;
    else
        x = y->right;

    if (((y == z->left) && (x == y->left)) || ((y == z->right) && (x == y->right))) { // deciding whether it will be a single rotation or double rotation
        singleRotation(y, z);
    }

    else
        doubleRotation(x, y, z);
     
    gapCalculator(x); //recalculating the gap after the balancing
    gapCalculator(y);
    gapCalculator(z);


}

// INPUT: pointers p, c, nodes in the AVL Tree, and isLeft as a predicate
// PRECONDITION: p is not the parent of node c, c not null and p not null
// POSTCONDITION: p is the parent of c and c is the child of p
void
AVLTreeMap::makeChild(Node* p, Node* c, bool isLeft) {
    // Your code here
    if (isLeft)
        p->left = c; 
    else
        p->right = c;

    if (c != NULL) { 
        c->parent = p;
    }
}

// INPUT: pointers y and z, to nodes in the AVL Tree
// PRECONDITION: Node Y and Z not null
// POSTCONDITION: A single rotation will be completed, and another call of this method may be required to be completely balanced
void
AVLTreeMap::singleRotation(Node* y, Node* z) {
    // Your code here

    Node* w = z->parent;
 
    Node* x = NULL;
    bool isLeft = (y == z->left); // checking  if y is the left chlid of z to know what to assign x
    if (isLeft)
        x = y->left;
    else
        x = y->right;

    

    if (z == root) { // condition if there are only three nodes (x,y,z). W is null here
        bool flag = false;

        Node* temp; // Node to keep track of the y child, in case the pointers mess up
        if (isLeft)
            temp = y->right;
        else
            temp = y->left;

        if (y->left && y->right) //if y has two children, a subtree exists and more pointers need to be adjusted to stay safe
            flag = true;

        makeChild(y, z, !isLeft); 

        
        if (isLeft && flag) //the y child sometimes points to its parent, and calls its parent a left child. It's a looping node, and to fix this I'm making temp the child y.right or y.left
            makeChild(y->right, temp, isLeft);
        else if (!isLeft && flag)
            makeChild(y->left, temp, isLeft);
        

    
        
 //       makeChild(y, x, isLeft);

        y->parent = NULL; // Setting the root equal to y, since there are only three nodes
        if (z->left == z->parent) //if the  child still points to the parent, fixing that here
            z->left = NULL;
        else if (z->right == z->parent)
                    z->right = NULL;

         root = y;
                          
    }

    if (w!= NULL) { // if w is not null, meaning more than three nodes
        bool test1 = false;
        bool test2 = false;

        Node* temp = y->right; // doing the same thing with temp as we did before, to not lose a child/subtree when balancing happens

        if (y->left && (y->left != x)) {
            temp = y->left;
            test2 = true;
        }


        makeChild(w, y, w->left == z);
        makeChild(y, z, !isLeft);

        if (z->left == z->parent) // if parent and child point to each other, fixing that here
            makeChild(z, temp, isLeft);

        if (test2)          // subtree reassignment
            makeChild(z, temp, isLeft);

        
        //makeChild(y, x, !isLeft);
        if (z->left == z->parent)
            z->left = NULL;
        else if (z->right == z->parent)
            z->right = NULL;

        resetHeight(z);
        resetHeight(y); //resetting height
        resetHeight(w);


    }
        

    
    else {
        resetHeight(y);
        resetHeight(z);
    }

    /* Node* x;
     if (height(y->left) > height(y->right))
         x = y->left;
     else
        x = y->right;

     Node* w = z->parent;
     x->parent = y;
     z->parent = y;
     y->parent = w;
     if (y == z->left) {
         z->left = y->right;
         y->right = z;
     }
     else {
         z->right = y->left;
         y->left = z;
     }

     if (z == w->left)
         w->left = y;
     else
         w->right = y;

     resetHeight(z);
     resetHeight(w);
     resetHeight(y);
     */

}



// INPUT: pointers x, y, and z, to nodes in the AVL Tree
// PRECONDITION: Two rotations are needed
// POSTCONDITION: The tree is completely balanced
void AVLTreeMap::doubleRotation(Node* x, Node* y, Node* z) {
    // Your code here
    /*Node* w = z->parent;
    y->parent = z;
    z->parent = x;
    x->parent = w;
    if (y == z->left) {
        z->left = x->right;
        y->right = x->left;
    }
    else {
        z->right = x->left;
        y->left = x->right;
    }

    if (z == w->left) {
        w->left = x;
    }
    else
        w->right = x;

    resetHeight(z);
    resetHeight(y);
    resetHeight(x);
    resetHeight(w);
    */
    singleRotation(x, y);
    singleRotation(x, z);
   

}

// INPUT: a key-value pair k and v (integer and string, respectively)
// OUTPUT: if k is already in the ordered map, then output a pointer to the node containing k, with v replacing the previous map value for k;
// otherwise, output a pointer to a new node with the corresponding key-value pair k and v.
// PRECONDITION: A new node with key value pair k,v is not null
// POSTCONDITION: a new node is inserted, or replaced if it already existed
Node* AVLTreeMap::put(int k, string v) {
    Node* z = BSTMap::put(k, v);

    Node* x = successor(z); //calculating gap

    if (x)
    z->gap =  x->key - z->key;
    // Your code here
    
    Node* w = z;
    while (w != NULL && balanced(w)) //going up the tree to check if any unbalancing occurred
    {

        gapCalculator(x); //calculating gap before rebalance
        gapCalculator(w);
        gapCalculator(z);

        resetHeight(w);
        w = w->parent;
    }
    if (w != NULL) //if unbalanced, rebalance
        rebalance(w);
      
    gapCalculator(x); // calculating gap after rebalance
    gapCalculator(w);
    gapCalculator(z);

    
    return z;
}

// INPUT: a pointer w to a node in the tree, or NULL
// OUTPUT: NULL if w is NULL; otherwise, a pointer to the parent of (the node pointed to by) w or
// its successor if (the node pointed to by) w is internal (i.e., has both non-empty left and right subtrees)
// POSTCONDITION: if w is NULL, the AVL tree remains the same; otherwise, the size of the AVL tree is reduced by 1,
// and (the node pointed to by) w, or its sucessor if w is internal, is properly removed from the AVL tree;
// also, if w is internal, then the (key,value) pair of the successor node is copied to (the node pointed to by) w before the successor node is removed; also, if the AVL tree decreases in size, then the AVL tree may have been restructured to restore its balance property
Node*
AVLTreeMap::erase(int k) {
    // first erase like in a BST
    Node* z = BSTMap::erase(k);
    Node* w = z;
    if (w) resetHeight(w);
    // check ancestors and rebalance if necessary
    while (w) {
        Node* x = w->parent;
        if (!balanced(w))
        {
            rebalance(w);

        }
        w = x;
    }
    gapCalculator(z);
    return z;
}

// INPUT: pointer w to a node in the AVL tree
// OUTPUT: the height of the node pointed to by w in the AVL tree
int
AVLTreeMap::height(Node* w) {
    return ((w) ? w->ht : 0);
}

// INPUT: pointer w to a node in the AVL tree
// PRECONDITION: w is not NULL and the height of its children in the AVL tree have been properly set
// POSTCONDITION: the height of the node pointed to by w is properly set (to 1 plus the height of its tallest child)
void
AVLTreeMap::resetHeight(Node* w) {
    w->ht = std::max(height(w->left), height(w->right)) + 1;
}

// INPUT: pointer w to a node in the AVL tree
// OUTPUT: true if the node pointed to by w is balanced; false otherwise
// PRECONDITION: w is not NULL
bool
AVLTreeMap::balanced(Node* w) {
    return (abs(height(w->left) - height(w->right)) <= 1);
}
//calculates gap
void AVLTreeMap::gapCalculator(Node* z) {
    Node* x = successor(z);

    if (x)
        z->gap = x->key - z->key;

}
/*
 *Purpose: Class definition of a simple leaderboard data structure utilizing
 *      an AVL tree to store entries
 */
class AVLTreeLeaderboard {
private:
    AVLTreeMap* avlmap;
    int maxSize;
    int printLeaderboardHelper(Node* s, int r);
public:
    void setMaxSize(int n);
    void add(int key, string value);
    void remove(int key);
    void printLeaderboard();
    void printTree();
    void print();
    // constructor
    AVLTreeLeaderboard() : avlmap(new AVLTreeMap()), maxSize(0) {}

};

void
AVLTreeLeaderboard::setMaxSize(int n) {
    this->maxSize = n;
}

// INPUT: integer key and string value
// PRECONDITION: new node to be added
// POSTCONDITION: Node is added
void
AVLTreeLeaderboard::add(int key, string value) {
    // your code here

    Node* z = avlmap->put(key, value);
   

    if (avlmap->size() > maxSize) { // if the size exceeds max size, find the parent node
        Node* w = z;
        while (w->parent) {

            w = w->parent;
        }
    

        
        while (w->left) //once parent node is found, find the left most node and remove it
            w = w->left;
       
       /* while (w->left || w->right) {
            if (w->left && w->right) {
                if (w->left > w->right)
                    w = w->right;
                else
                    w = w->left;
            }
            else if (w->left && !w->right)
                w= w->left;
            else 
                w= w->right;

        }*/
        
        //cout << "\t\t\tLOLOL" << z->key;
        remove(w->key);



    }




}

// INPUT: integer key
// PRECONDITION: A node is to be removed with key key
// POSTCONDITION:  A node is removed with key key
void
AVLTreeLeaderboard::remove(int key) {
    // your code here
    avlmap->erase(key);
}

// helper function to print the leaderboard
// uses reverse in order traversal
int
AVLTreeLeaderboard::printLeaderboardHelper(Node* s, int r) {
    if (s == NULL)
    {
        return r;
    }
    r = this->printLeaderboardHelper(s->right, r);
    cout << r << "\t" << s->key << "\t" << s->gap << "\t" << s->value << endl;
    r++;
    r = this->printLeaderboardHelper(s->left, r);
    return r;
}

// prints string representation of the AVL tree representing the leaderboard
void
AVLTreeLeaderboard::printLeaderboard() {
    int r = 1;
    cout << "Rank\t" << "Points\t" << "Gap\t" << "Name" << endl;
    this->printLeaderboardHelper(this->avlmap->root, r);
}

// prints out a string representation of the whole BST using a reverse inorder traversal
void
AVLTreeLeaderboard::printTree() {
    this->avlmap->printTree(this->avlmap->root, 0);
    cout << endl;
}

// print out a parenthetic string representation of the whole BST
void
AVLTreeLeaderboard::print() {
    this->avlmap->print();
}

int main() {
    string inputFilename = "input.txt";
    string line;
    bool echo = true;

    AVLTreeLeaderboard L;
    // open input file
    fstream inputFile;
    loadFile(inputFilename, inputFile);
    while (getline(inputFile, line))
    {
        // trim whitespace
        // echo input
        if (echo) cout << line << endl;
        // parse input using a stringstream
        stringstream lineSS(line);
        string token;
        string command = "";
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

        if (tokens.size() > 1)
        {
            if (command == "add")
            {
                L.add(stoi(tokens[1]), tokens[2]);
                
                
            }
            if (command == "remove")
            {
                L.remove(stoi(tokens[1]));
            }
            if (command == "size")
            {
                L.setMaxSize(stoi(tokens[1]));
            }
        }
        if (command == "print")
        {
            L.print();
        }
        if (command == "print_tree")
        {
            L.printTree();
        }
        if (command == "print_leader")
        {
            L.printLeaderboard();
        }
        if (command == "noecho")
        {
            echo = false;
        }
    }
    return EXIT_SUCCESS;
}

