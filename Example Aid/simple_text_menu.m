% Example of Simple Text-Based Menu

% Set up the stopping condition: 
%   false if user wants to exit the program
%   true if the user wants to continue running the program
continueProgram = true;

% This while loop will continue to loop until continueProgram becomes false 
while continueProgram
    % Clear the screen
    % This makes the menu interactions a bit cleaner
    clc;
    
    % Display the menu to the user
	%print_menu_options;
    fprintf('What do you want to do?\n');
    fprintf('1) Do fun stuff\n');
    fprintf('2) Do boring stuff\n');
    fprintf('3) Do useful stuff\n');
    fprintf('4) Exit\n');
    % Print prompt
    fprintf('Enter your choice: ');
    
    % Get user input
    % For safety, read as a string to prevent MATLAB from evaluating input
	choice = input('','s');
    
    % Determine which action to take based on the user's input
    switch choice
		case '1'
            % do action for option 1
			do_fun_stuff();
		case '2'
            % do action for option 2
			do_boring_stuff();
		case '3'
            % do action for option 3
			do_useful_stuff();
		case '4'
            % do action for option 4
			continueProgram = false;
        otherwise
            % This case handles invalid input
			fprintf('\nERROR: Please enter an integer between 1 and 4\n\n');
            
            % Wait for user to acknowledge the error message
            fprintf('Press any key to continue');
            pause;
    end % end of switch
end % end of while

% clean up after ourselves
clc;
clear done choice;
% end of script