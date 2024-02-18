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
m_1 = 0;        % input bit
m_0 = 0;        % Regiser 1
m_minus1 = 0;   % register 2


while true
    
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

    % Shift Registers
    m_minus1 = m_0;
    m_0 = m_1;

    % Prompt user for binary input
    while true
        msg = "Enter the next input bit, or press 'q' to quit: ";    
        user_input = input(msg, "s"); % 's' forces input to string 
        if isempty(user_input)
            disp('Input cannot be empty. Please enter a binary number.');
        elseif strcmp (user_input, 'q')
            return;
        elseif strcmp (user_input, '0')
            m_1 = 0;
            break
        elseif strcmp(user_input, '1')
            m_1 = 1;
            break
        else
            disp('Invalid input. Please enter a binary number.');
        end
    end


end

