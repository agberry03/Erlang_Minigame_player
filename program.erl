-module(program). % Define the module.
-export([main/0]). % Define functions that will be exported.
-import(rand, [uniform/1]). % Define any imports.

% Main function that runs the other functions. I may remove it for the final product.
main() ->
    guess_number(uniform(10), 0). % uniform(10) gets a random number between 1 and 10 (inclusive).

% The guess_number function. Runs the number guessing game.
% Number = the number the user needs to guess.
% Guesses = the number of guesses the user has made.
guess_number(Number, Guesses) ->
	
	% The game will continue until two guesses are made,
	% or a guess is correct.
    if Guesses < 2 ->

		% Get input from the user as a guess.
		% (The input must end with a '.' or it will not be read.)
        {ok, Guess_number} = io:read("Guess a number between 1 and 10: "),

        if Guess_number > Number ->
            io:format("Lower.~n"),
            guess_number(Number, Guesses+1);

           Guess_number < Number ->
            io:format("Higher.~n"),
            guess_number(Number, Guesses+1);

           true -> % Guess is correct.
            io:format("You got it!~n")
        end;

       true -> % You ran out of guesses.
        io:format("You ran out of guesses. The answer was ~p.~n", [Number])
    end.