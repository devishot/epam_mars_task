## Mission to Mars

1. Problem
2. Solution
3. Realization
4. Tests

The problem is to process instructions of many rovers on the plateau. 

Problem solution require to read many lines from input and parse them into current size of plateau, state of rovers and instructions for every rover.
There is some difficulty in input reading. Problem description does not declare any limitations by input data.
Therefore, to ensure that solution can work correctly there were added data validation.

After that, it was clearly to separate work on reading and parsing from representation of the program state.
In this situation implement the Builder pattern was helpful. 
This pattern designed for separate object construction and representation.

My solution has 4 classes. Where two classes provide implementation of the Builder pattern.

## Realization

### Class Rover

It is the main class of the solution. Describes a rover and store its state: position on plareau and facing direction. 
It has single procedure - to process instructions.

### Class Plateau

The Plateau class keeps information of surface where rovers will move. 
Moreover, it contains rover instances and instructions for every of them.
It implements procedure which sequentially start processing of instructions on rovers.

### Class Builder

This class provides realization of the GoF pattern. It constructs Plateau instance.
Furthermore, it validates input data.

### Class Reader

The Reader class encapsulates the parsing of the input. It works in front of the Builder class. 
It reads input line by line. At the same time it directs parsed data in a builder. 
Its main responsibility is input validation. 
The class provides ability to read from different I/O stream objects. 
It can be any class which implement IO class of Ruby core.


## Testing


### Running the tests

For TDD testing was used MiniTest. There was used unit-testing and mocking functionality.

It is small and fast testing framework provided by Ruby core.
Testing does not requires any testing framework.

Note: new syntax of MiniTest may require Ruby 2.2

There are several ways around this:
* Upgrade to ruby 2.2
* Install *gem "minitest"*

To test solution run unit-tests in test/ directory:
> ruby test/test_mars_rover.rb

other test files:
* test_mars_plateau.rb
* test_mars_reader.rb
* test_mars_rover.rb


