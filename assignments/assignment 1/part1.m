% ELEC 6661: Medical Image Processing
% Assignment 1
%
% Xavier Sumba
% StudentID: 40086818
%
% 1.) Make a 12x12 matrix and fill in with the numbers 1-144 column-wise (without the use of for loops!). I.E. the first column is 1,2,3,4... the second is 13,14,15, .... and so on.
% 	Expected output:
%           1     2     3     4     5     6     7     8     9    10    11    12
%     13    14    15    16    17    18    19    20    21    22    23    24
%     25    26    27    28    29    30    31    32    33    34    35    36
%     37    38    39    40    41    42    43    44    45    46    47    48
%     49    50    51    52    53    54    55    56    57    58    59    60
%     61    62    63    64    65    66    67    68    69    70    71    72
%     73    74    75    76    77    78    79    80    81    82    83    84
%     85    86    87    88    89    90    91    92    93    94    95    96
%     97    98    99   100   101   102   103   104   105   106   107   108
%   109   110   111   112   113   114   115   116   117   118   119   120
%   121   122   123   124   125   126   127   128   129   130   131   132
%   133   134   135   136   137   138   139   140   141   142   143   144


A = reshape(1:144, 12, 12).'

% 2.) Do the same as question 1 now row-wise.

% 	Expected output:
%      1    13    25    37    49    61    73    85    97   109   121   133
%      2    14    26    38    50    62    74    86    98   110   122   134
%      3    15    27    39    51    63    75    87    99   111   123   135
%      4    16    28    40    52    64    76    88   100   112   124   136
%      5    17    29    41    53    65    77    89   101   113   125   137
%      6    18    30    42    54    66    78    90   102   114   126   138
%      7    19    31    43    55    67    79    91   103   115   127   139
%      8    20    32    44    56    68    80    92   104   116   128   140
%      9    21    33    45    57    69    81    93   105   117   129   141
%     10    22    34    46    58    70    82    94   106   118   130   142
%     11    23    35    47    59    71    83    95   107   119   131   143
%     12    24    36    48    60    72    84    96   108   120   132   144

B = reshape(1:144, 12, 12)

% 3.) Using the matrix from question 1, create a new matrix half the size of the original containing the odd columns and the even rows.
%
% 	Expected output:
%     13    15    17    19    21    23
%     37    39    41    43    45    47
%     61    63    65    67    69    71
%     85    87    89    91    93    95
%   109   111   113   115   117   119
%   133   135   137   139   141   143


A_half = A(2:2:end, 1:2:end)


% 4.) Using the matrix from question 1 create a Boolean matrix (0,1) indicating the elements greater than 30.
% 	Expected output:
%   0  0  0  0  0  0  0  0  0  0  0  0
%   0  0  0  0  0  0  0  0  0  0  0  0
%   0  0  0  0  0  0  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1
%   1  1  1  1  1  1  1  1  1  1  1  1


A_bool = A > 30

% 5.) Solve this system:
% This should be done in one short line using matrixes and built-in operators.


% 	X + Y + Z = 9;
% 	2*X + Y = 3;
% 	Y + Z = 5;

% 	Expected output: 
% 	x = 4, y = -5, z = 10

% declare system of equations
syms x y z
eqn1 = x + y + z == 9;
eqn2 = 2*x + y == 3;
eqn3 = y + z == 5;

% extract matrix notation
[A,B] = equationsToMatrix([eqn1, eqn2, eqn3], [x, y, z])

% solve system of equations (one line)
sol = linsolve(A,B)
