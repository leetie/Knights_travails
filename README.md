This project was part of the curriculum for The Odin Project https://www.theodinproject.com/courses/ruby-programming/lessons/data-structures-and-algorithms#null

The goal of this project was to create a script that represents a game board and knight, and to develop an algorith to find the shortest possible path between two squares using legal moves.

In it I created a "Knight" class in Ruby that has a @board instance variable set to an 8 by 8 array. I had some fun with colorize and the modulus operator making the board checkered, and gave my Knight piece some text content with the instance variable @text_content. Initially I knew that I would have to be working with an x and y position, and some form of graph or tree.

I defined legal moves as ones that left the piece at an index where neither x or y was greater than 7, or less than 0. This would ensure that when running my current position through the possible moves that a knight can make, it will only return moves that will keep it on the board. 

After some (very) considerable thought, I determined that a good course of action would be to develop a method that takes a pair of destination coordinates and a position. My method (knight_moves) adds the position argument to a queue and checks to see if its value is equal to that of the destination. If it is, great! It returns from the method and outputs the path and amount of turns to get to the destination. If not, it creates child nodes from all the possible legal moves and adds them to the queue.