
#include "Othello.h"
#include "OthelloBoard.h"
#include "OthelloPlayer.h"
#include <cstdlib>
#include <algorithm>
#include <vector>
#include <list>
#include <cstring>

#include <climits>
#include <pthread.h>
using namespace std;
using namespace Desdemona;

#define INFINITY 100000
#define DEPTH 5

Move FinalMove(-1, -1);
Turn ourTurn;
static OthelloBoard PrevBoard;
Move PrevMove(-1, -1);
static bool strtGame = true;


class Node {
public:
	OthelloBoard nodeBoard;
	Turn nodeType;

	Node(OthelloBoard board, Turn type);
	void ModifyBoard(Move moveMade);
	~Node();
};

Node::Node(OthelloBoard board, Turn type) {
	this->nodeBoard = board;
	this->nodeType = type;
}

void Node::ModifyBoard(Move moveMade) {
	(this->nodeBoard).makeMove(other(this->nodeType), moveMade);
}

class MyBot: public OthelloPlayer
{
    public:
        MyBot( Turn turn );

        virtual Move play(const OthelloBoard& board );
      
        double alphaBeta(Node* root, Turn turn,int depth, double alpha, double beta);  
        int probabilityHeuristic (Turn turn, const OthelloBoard& board);
        int myHeuristic(Turn turn, const OthelloBoard& board);
        bool isEdgeComplete(const OthelloBoard& board, int edgeCoordinate, bool isHorizontal);
        int stableEdge(const OthelloBoard& board, Turn color, int edgeCoordinate, bool isHorizontal);
        int stableCorner(const OthelloBoard& board, Turn color, int cornerRowIndex, int cornerColumnIndex);
        int stableHeuristic(Turn turn, Turn opp, const OthelloBoard& board);
        int wHeuristic(Turn turn, Turn opp,const OthelloBoard& board);
        int actualMobility(Turn turn, Turn opp, const OthelloBoard& board);
        int potentialMobility(Turn turn, Turn opp,const OthelloBoard& board);
        int cornerHeuristics(const OthelloBoard& board, Turn turn, Turn opp);
        int getTurnHeuristic(Turn turn, Turn opp, const OthelloBoard& board);
        int conditionCheck(int variable, int value, int poitiveReturn, int negativeReturn);
        Turn getCurrentTurn(bool isHorizontal, const OthelloBoard& board, int edgeCoord, int otherCoord);

        private:
            int weighted_cell[8][8];
                int corner_x[4]; 
                int corner_y[4];

                int adjacent_points_x[12];
                int adjacent_points_y[12];

    
};

MyBot::MyBot( Turn turn )
    : OthelloPlayer( turn )
{
        
        int c_x[4] = {0,0,7,7}; 
        int c_y[4] = {0,7,0,7};

        int points_x[12] = {0,1,1, 0,1,1, 6,7,6, 6,7,6};
        int points_y[12] = {1,0,1, 6,7,6, 0,1,1, 7,6,6};


        int temp[8][8] = 
                        {
                            
                            {40, -30,  21,  8,  8,  21, -30, 40},
                            {-10, -17, -4,  1,  1,  -4, -17, -10},
                            {21,  -4,  2,  2,  2,  2,  -4,  21},
                            {8,  1,  2,  1,  1,  2,  1,  8},
                            {8,  1,  2,  1,  1,  2,  1,  8},
                            {21,  -4,  2,  2,  2,  2,  -4,  21},
                            {-10, -17, -4,  1,  1,  -4, -17, -10},
                            {40, -30,  21,  8,  8,  21, -30, 40}
                        };
        
        for(int i=0; i < 8; i++){
            for(int j=0; j<8; j++){
                weighted_cell[i][j] = temp[i][j];
            }
        }

        for(int i=0; i<4; i++){
            corner_x[i] = c_x[i];
            corner_y[i] = c_y[i];
        }

        for(int i=0; i<12; i++){
            adjacent_points_x[i] = points_x[i];
            adjacent_points_y[i] = points_y[i];
        }
}


void getPrevMove(const OthelloBoard& board) {
    int i, j;
    
    for (i = 0; i < 8; ++i) {
        for (j = 0; j < 8; ++j) {
            if (PrevBoard.get(i, j) == EMPTY
                    && board.get(i, j) != PrevBoard.get(i, j)) {
                //c++;
                PrevMove.x = i, PrevMove.y = j;
                return;
            }
        }
    }
}

Move MyBot::play(const OthelloBoard& board )
{
    ourTurn = turn;
    //printf("%d",ourTurn);

    if (!strtGame) {
        getPrevMove(board);
        
    } else if (ourTurn == BLACK) {
        strtGame = false;
        PrevBoard = OthelloBoard(board);
        
        list<Move> moveLst = PrevBoard.getValidMoves(ourTurn);
        list<Move>::iterator it = moveLst.begin();
        int randNo = (rand() % 4);
        for (int i = 0; i < randNo - 1; ++it, ++i);

        FinalMove.x = it->x, FinalMove.y = it->y;
        PrevBoard.makeMove(ourTurn, FinalMove);

        return FinalMove;
    }

    strtGame = false;
    PrevBoard = OthelloBoard(board);
    Node* root = new Node(PrevBoard, ourTurn);
    
    alphaBeta(root,turn,0, -INFINITY, INFINITY);
    PrevBoard.makeMove(ourTurn, FinalMove);
    return FinalMove;
}


double MyBot::alphaBeta(Node* root,Turn turn, int depth, double alpha, double beta) 
{
    if (depth == DEPTH) {
        return myHeuristic(turn,root->nodeBoard);
    }

    list<Move> successors = (root->nodeBoard).getValidMoves(root->nodeType);
    if (successors.empty()) {
        return myHeuristic(turn,root->nodeBoard);
    }

    Node* tmp = NULL;
    double newValue = 0.0;

    for (list<Move>::iterator it = successors.begin(); it != successors.end();
            ++it) {
        tmp = new Node(root->nodeBoard, other(root->nodeType));
        tmp->ModifyBoard(*it);
        newValue = -1 * alphaBeta(tmp, other(turn),depth + 1, -1 * beta, -1 * alpha);
        if (newValue > alpha) {
            alpha = newValue;
            if (depth == 0) {
                FinalMove.x = it->x;
                FinalMove.y = it->y;
            }
        }
        if (alpha >= beta) {
            return alpha;
        }
    }
    return alpha;
}

int MyBot::myHeuristic(Turn turn, const OthelloBoard& board){
  
    Turn opp = other(turn);
    int currmob = actualMobility(turn, opp, board);
    int potmob = potentialMobility(turn, opp, board);
    int stab = stableHeuristic(turn,opp, board);

    return 3*wHeuristic(turn, opp, board) + 
           30*(stab) + 
           10*(currmob) + 
           5*(potmob) +
           2*cornerHeuristics(board,turn, opp);
}

int MyBot::getTurnHeuristic(Turn turn, Turn opp, const OthelloBoard& board){
    int sum = 0;
    for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
            if(turn == board.get(i,j)){
                sum = sum + weighted_cell[i][j];
            }
            else if(opp == board.get(i,j)){
                sum = sum - weighted_cell[i][j];
            }   
        }
    }

    return sum;
}

int MyBot::wHeuristic(Turn turn, Turn opp, const OthelloBoard& board){
    
    int result = getTurnHeuristic(turn , opp, board);

    if((board.get(7, 0) == EMPTY) == false){
            if(board.get(6,0) == turn)
                result += 5-weighted_cell[6][0];
            if(board.get(7,1) == turn)
                result += 5-weighted_cell[7][1];
            if(board.get(6,1) == turn)
                result += 5-weighted_cell[6][1];
            
            if(board.get(6,0) == opp)
                result -= 5-weighted_cell[6][0];
            if(board.get(7,1) == opp)
                result -= 5-weighted_cell[7][1];
            if(board.get(6,1) == opp)
                result -= 5-weighted_cell[6][1];
    }

    if((board.get(0, 0) == EMPTY) == false){
            if(board.get(0,1) == turn)
                result += 5-weighted_cell[0][1];
            if(board.get(1,0) == turn)
                result += 5-weighted_cell[1][0];
            if(board.get(1,1) == turn)
                result += 5-weighted_cell[1][1];
            
            if(board.get(0,1) == opp)
                result -= 5-weighted_cell[0][1];
            if(board.get(1,0) == opp)
                result -= 5-weighted_cell[1][0];
            if(board.get(1,1) == opp)
                result -= 5-weighted_cell[1][1];
    }


    if((board.get(7, 7) == EMPTY) == false){
            if(board.get(6,7) == turn)
                result += 5-weighted_cell[6][7];
            if(board.get(7,6) == turn)
                result += 5-weighted_cell[7][6];
            if(board.get(6,6) == turn)
                result += 5-weighted_cell[6][6];
            
            if(board.get(6,7) == opp)
                result -= 5-weighted_cell[6][7];
            if(board.get(7,6) == opp)
                result -= 5-weighted_cell[7][6];
            if(board.get(6,6) == opp)
                result -= 5-weighted_cell[6][6];
    } 

    if((board.get(0, 7) == EMPTY) == false){
            if(board.get(0,6) == turn)
                result += 5-weighted_cell[0][6];
            if(board.get(1,7) == turn)
                result += 5-weighted_cell[1][7];
            if(board.get(1,6) == turn)
                result += 5-weighted_cell[1][6];
            
            if(board.get(0,6) == opp)
                result -= 5-weighted_cell[0][6];
            if(board.get(1,7) == opp)
                result -= 5-weighted_cell[1][7];
            if(board.get(1,6) == opp)
            result -= 5-weighted_cell[1][6];    
    }
  

    return result;

}

int MyBot::actualMobility(Turn turn, Turn opp, const OthelloBoard& board){
    int current = 0;
    list<Move> moves = board.getValidMoves(turn);
    current = moves.size();
    moves = board.getValidMoves(opp);
    current -= moves.size();
    return current;
}

int MyBot::potentialMobility(Turn turn, Turn opp, const OthelloBoard& board) {
    int potential = 0;
    
    for(int cases = 0; cases < 2; cases ++){
        Turn switchTurn = (cases == 0) ? other(turn) : other(opp);
        int  increment = (cases == 0) ? +1 : -1;
        if(board.get(1,1) == switchTurn 
            || board.get(1,0) == switchTurn 
            || board.get(0,1) == switchTurn){
            potential += increment;        
        }
        if(board.get(1,6) == switchTurn 
            || board.get(1,7) == switchTurn 
            || board.get(0,6) == switchTurn){
            potential += increment;        
        }
        if(board.get(6,1) == switchTurn 
            || board.get(6,0) == switchTurn 
            || board.get(7,1) == switchTurn){
            potential += increment;        
        }
        if(board.get(6,6) == switchTurn 
            || board.get(6,7) == switchTurn 
            || board.get(7,6) == switchTurn){
            potential += increment;        
        }
    }
    
    for(int cases = 0; cases < 2; cases ++){
        Turn switchTurn = (cases == 0) ? other(turn) : other(opp);
        int  increment = (cases == 0) ? +1 : -1;    
        int i = 0, j = 0;
        for(j=1; j<7; j++){
            if(board.get(i,j-1) == switchTurn || board.get(i,j+1) == switchTurn || board.get(i+1,j) == switchTurn)
                    potential += increment;     
        }
        
        i = 7;
        for(int j=1; j<7; j++){
            if(board.get(i,j-1) == switchTurn || board.get(i,j+1) == switchTurn || board.get(i-1,j) == switchTurn)
                    potential += increment;
        
        }
        
        j = 0;
        for(i = 1; i<7; i++){
            if(board.get(i-1,j) == switchTurn || board.get(i+1,j) == switchTurn || board.get(i,j+1) == switchTurn)
                        potential += increment;
        }

        j = 7;
        for(i = 1; i<7; i++){
            if(board.get(i-1,j) == switchTurn || board.get(i+1,j) == switchTurn || board.get(i,j-1) == switchTurn)
                potential += increment;
         
        }
    }
    
    for(int cases = 0; cases < 2; cases ++){
        Turn switchTurn = (cases == 0) ? other(turn) : other(opp);
        int  increment = (cases == 0) ? +1 : -1;
        for(int i = 1; i < 7; i++){
            for(int j = 1; j < 7 ; j++){
                    if(board.get(i-1,j-1) == switchTurn || board.get(i-1,j) == switchTurn || board.get(i-1,j+1) == switchTurn || board.get(i,j-1) == switchTurn || board.get(i,j+1) == switchTurn || board.get(i+1,j-1) == switchTurn || board.get(i+1,j) == switchTurn || board.get(i+1,j+1) == switchTurn)
                        potential += increment;
            }
        }    
    }

    return potential;
}

int MyBot::cornerHeuristics(const OthelloBoard& board, Turn turn, Turn opp)
{
    int c,l;
    Turn my_color = turn;
    Turn opp_color = opp;
    int our_cells = 0, opp_cells = 0;

    our_cells = opp_cells = 0;
    
    for(int i=0; i<4; i++){
        if(board.get(corner_x[i],corner_y[i]) == my_color) our_cells++;
        else if(board.get(corner_x[i],corner_y[i]) == opp_color) opp_cells++;    
    }
    
    if(our_cells + opp_cells != 0 )
         c = (our_cells - opp_cells)/(our_cells + opp_cells); 
    else c = 0;

    our_cells = opp_cells = 0;
    
    for(int i=0; i<4; i++){
        if(board.get(corner_x[i], corner_y[i]) == EMPTY)   {
            int index = i*3;

            if(board.get(adjacent_points_x[index],adjacent_points_y[index]) == my_color) our_cells++;
            else if(board.get(adjacent_points_x[index],adjacent_points_y[index]) == opp_color) opp_cells++;
            
            if(board.get(adjacent_points_x[index+1],adjacent_points_y[index+1]) == my_color) our_cells++;
            else if(board.get(adjacent_points_x[index+1],adjacent_points_y[index+1]) == opp_color) opp_cells++;
            
            if(board.get(adjacent_points_x[index+2],adjacent_points_y[index+2]) == my_color) our_cells++;
            else if(board.get(adjacent_points_x[index+2],adjacent_points_y[index+2]) == opp_color) opp_cells++;
        }    
    }
    
    if(our_cells + opp_cells != 0 )
         l = (our_cells - opp_cells)/(our_cells + opp_cells); 
    else l= 0;

    return c+l ;  
}



int MyBot::probabilityHeuristic (Turn turn, const OthelloBoard& board){
    
    int redCount = board.getRedCount();
    int blackCount = board.getBlackCount();

    int diff = redCount - blackCount;
    if(turn == BLACK)
        diff *= -1;

    if(diff > 0) return INFINITY;
    else if(diff == 0) return 0;
    else return -INFINITY;
    
}

int MyBot::stableHeuristic(Turn turn, Turn opp, const OthelloBoard& board){
    int x = 0;
    for(int cases = 0; cases <2; cases++){
        int mul = cases == 0 ? 1 : -1;
        Turn switchTurn = cases == 0 ? turn : opp;
        for(int i=0; i<4; i++){
            x += mul*stableCorner(board, switchTurn, corner_x[i], corner_y[i]);
            if(i<2){
                
                if(isEdgeComplete(board, corner_y[i], true))
                    x += mul*stableEdge(board, switchTurn, corner_y[i], true);
            
            }
            
            else{
                
                if(isEdgeComplete(board, corner_y[i], false))
                    x += mul*stableEdge(board, switchTurn, corner_y[i], false);   
            
            }
         }    
    }
    return x;
}

int MyBot::conditionCheck(int variable, int value, int poitiveReturn, int negativeReturn){
    if(variable == value)
        return poitiveReturn;
    return negativeReturn;
}

int MyBot::stableCorner(const OthelloBoard& board, Turn color, int cornerRow, int cornerColumn) {
    int result = 0;

    int rowInc = conditionCheck(cornerRow, 0, 1, -1);
    int colInc = conditionCheck(cornerColumn, 0, 1, -1);
    int rowSize = conditionCheck(cornerRow, 0, 8, -1);
    int colSize = conditionCheck(cornerColumn, 0, 8, -1);
    
    for (int rowIndex = cornerRow; rowIndex != rowSize; rowIndex += rowInc)
    {
        int columnIndex;
        for (columnIndex = cornerColumn; columnIndex != colSize; columnIndex += colInc){
            if (board.get(rowIndex, columnIndex) == color){
                result++;
            }
            else{
                break;
            }
        }

        if ((colInc > 0 && columnIndex < 8) || (colInc < 0 && columnIndex > 0)){
            colSize = columnIndex - colInc;

            if (colInc > 0 && colSize == 0)
            {
                colSize++;
            }
            else if (colInc < 0 && colSize == 7)
            {
                colSize--;
            }

            if ((colInc > 0 && colSize < 0)
                || (colInc < 0 && colSize > 7))
            {
                break;
            }
        }
    }

    return result;
}

Turn MyBot::getCurrentTurn(bool isHorizontal, const OthelloBoard& board, int edgeCoord, int otherCoord){
     if(isHorizontal) 
        return board.get(edgeCoord, otherCoord);
    return board.get(otherCoord, edgeCoord);
}

int MyBot::stableEdge(const OthelloBoard& board, Turn color, int edgeCoord, bool isHorizontal)
{
    int result = 0;

    bool isOppColorPassed = false;
    for (int otherCoord = 0; otherCoord < 8; otherCoord++)
        {                
        Turn fieldColor = getCurrentTurn(isHorizontal, board, edgeCoord, otherCoord);
        if (fieldColor != color)
        {
            isOppColorPassed = true;
        }
        else if (isOppColorPassed)
        {
            int consecutiveDiscsCount = 0;
            while ((otherCoord < 8) && (fieldColor == color))
            {
                consecutiveDiscsCount++;

                otherCoord++;
                if (otherCoord < 7)
                {
                    fieldColor = getCurrentTurn(isHorizontal, board, edgeCoord, otherCoord);
                }
            }
            if (otherCoord != 8)
            {
                result += consecutiveDiscsCount;
                isOppColorPassed = true;
            }                                             
        }
    }
    return result;
}

bool MyBot::isEdgeComplete(const OthelloBoard& board, int edgeCoordinate, bool isHorizontal){
    
    for (int otherCoordinate = 0; otherCoordinate < 8; otherCoordinate++){
        if ((isHorizontal && (board.get(edgeCoordinate, otherCoordinate) == EMPTY))
            || (!isHorizontal && (board.get(otherCoordinate, edgeCoordinate) == EMPTY))){
            return false;
        }
    }
    return true;
}

// The following lines are _very_ important to create a bot module for Desdemona

extern "C" {
    OthelloPlayer* createBot( Turn turn )
    {
        return new MyBot ( turn );
    }

    void destroyBot( OthelloPlayer* bot )
    {
        delete bot;
    }
}


