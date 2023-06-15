-module(program). % Define the module.
-export([main/0]). % Define functions that will be exported.
-import(rand, [uniform/1]). % Define any imports.

% Main function that runs the other functions. I may remove it for the final product.
main() ->
    % guess_number(uniform(10), 0), % uniform(10) gets a random number between 1 and 10 (inclusive).
    % rock_paper_scissors().
    % Prompt the user to think of a number.
    io:read("Think of a number between one and 100.(Press ENTER to continue): "),
    computer_guess(lists:seq(1, 100)).

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

% The rock_paper_scissors function
rock_paper_scissors() ->
    
    % Randomly select the opponent's choice.
    Com_input = uniform(3),

    % Display the different options for the player to select.
    io:format("Select one of the following options:~n"),
    io:format("1. Rock~n"),
    io:format("2. Paper~n"),
    io:format("3. Scissors~n"),

    % Select a value corresponding to rock, paper, or scissors.
    {ok, Player_input} = io:read("Select one: "),

    % Check if it is a tie.
    if Player_input == Com_input ->
        io:format("It's a tie!");
        
        true -> % It's not a tie.
            case Player_input of
                1 ->
                    if Com_input == 2 ->
                        io:format("Rock beats scissors!~nYou win!~n");
                        
                        true -> % Computer beats rock.
                            io:format("Paper beats rock.~nYou lose.~n")
                    end;
                2 ->
                    if Com_input == 1 ->
                        io:format("Paper beats rock!~nYou win!~n");
                    
                        true -> % Computer beats paper.
                            io:format("Scissors beats paper.~nYou lose.~n")
                    end;
                3 ->
                    if Com_input == 2 ->
                        io:format("Scissors beats paper!~nYou win!~n");

                        true -> % Computer beats scissors.
                            io:format("Rock beats scissors.~nYou lose.~n")
                    end
            end
    end.

% I couldn't figure out how to write a quick draw program, so I decided to make a function
% where the program must guess a number between 1 and 100.
computer_guess(Number_list) ->

    % The computer guesses a random number.
    RandomIndex = uniform(length(Number_list)),
    Guess = lists:nth(RandomIndex, Number_list),

    % The computer asks if the number is correct.
    io:format("Is the number ~p? ", [Guess]),
    {ok, Is_correct} = io:read("y/n: "),
    
    
    case Is_correct of
        
        y ->
            % If it is, then end the program.
            io:format("Awesome! The answer is ~p!~n", [Guess]);

        n ->
            % Otherwise, ask if the real number is lower or higher.
            {ok, Lower_higher} = io:read("Is the number lower or higher? l/h: "),

            case Lower_higher of

                % Depending on the answer, the program will eliminate all of the
                % options higher or lower than the initial guess.
                % This continues until the correct answer is reached.
                l ->
                    Filtered_list = lists:filter(fun(X) -> X < Guess end, Number_list),
                    computer_guess(Filtered_list);

                h ->
                    Filtered_list = lists:filter(fun(X) -> X > Guess end, Number_list),
                    computer_guess(Filtered_list)
                end
            end.