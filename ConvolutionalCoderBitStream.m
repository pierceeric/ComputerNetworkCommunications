% This program is a Convolutional Coder
% Eric Pierce, 17 FEB 2024
% written for MATLAB 2023b
% 
% Characteristics of this Convolutional Coder:
%      m-bit input information = 1
%      n-bit output symbol = 3
%      K-bit constraint factor = 3 memory registers
%      code rate = m/n = 1/3
%   
%               XOR ---------- x_1 
%             /  |  \
%            /   |   \
%           /    |     \
%          |     |      |
%      ---------------------
%      |      |     |      |
%  --->|  m_1 | m_0 | m_-1 |
%      |      |     |      |
%      ---------------------
%          \      \    /|
%           \      \  / |  
%            \      XOR ------ x_2
%             \         |
%              \        |
%               \       |
%                \      |
%                 \     |
%                   XOR ------ x_3
%

clear;
clc;
close all;

% initialize system
m_1 = 0;            % input bit
m_0 = 0;            % Regiser 1
m_minus1 = 0;       % register 2
output_array = [];  % create empty output array
more_numbers = true;

% Prompt user for binary array input 
user_input = input('Enter an array of binary numbers (MSB to LSB): ', 's'); % 's' flag ensures input is treated as string
numbers = strsplit(user_input); % Split the input string by spaces
input_array = str2double(numbers) % Convert the cell array of strings to an array of numbers

while (more_numbers == true)

    % when the input_array is empty stop the program
    if isempty(input_array)
        more_numbers = false;
        output_array
        return;
    else more_numbers = true;
    end

    m_1 = input_array(end);              % save LSB from array
    input_array = input_array(1:end-1);  % remove LSB from array
    
    % Calculate outputs
    x_1 = xor ((xor (m_1, m_0)),m_minus1); % 3-input xor
    x_2 = xor (m_0, m_minus1);
    x_3 = xor (m_1, m_minus1);
    % convert logicals to double
    x_1 = double (x_1);
    x_2 = double (x_2);
    x_3 = double (x_3);

    % Create tables to display on screen
    input_value = table(m_1);
    current_state = table(m_0, m_minus1);
    next_state = table(m_1, m_0);
    output_values = table(x_1, x_2, x_3);
    T = table(input_value, current_state, next_state, output_values);
    disp(T)

    % Create output array
    output_array = [output_array x_1];
    output_array = [output_array x_2];
    output_array = [output_array x_3];

    % Shift Registers
    m_minus1 = m_0;
    m_0 = m_1;

end

