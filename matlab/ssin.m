function [out1, out2] = ssin( varargin )
%SSIN Smart Sinusoid synthesizer
%
%   Dependecy
%       To use ssin or scos, you need to download and add to your path 
%       Simple Input Parser which is a package that allows you to create
%       functions with a more convenient interface.
%       URL: https://github.com/tiborsimon/simple-input-parser
%
%
%   SSIN features
%       - fast and easy signal generation
%       - flexible parameter handling
%
%   Possible parameters
%       A   []   - signal amplitude 
%       phi [°]  - phase in degrees 
%       f   [Hz] - signal frequency 
%       fs  [Hz] - sample rate
%       T   [s]  - signal period
%       dt  [s]  - sample time
%       N   []   - number of periods in the signal
%       n   []   - sample count
%       L   [s]  - signal length
%
%   Possible use cases
%
%       Case 1
%          n - number of samples
%          N - periods in it
%
%          signal = ssin('nN', 200, 2.5);
%
%
%       Case 2
%          L  - signal lenght
%          N  - periods in the signal
%          fs - with a given sample frequency
%          
%          signal = ssin('LNfs', 0.01, 3, 48e3);
%          
%
%       Case 3
%          f  - signal frequency
%          N  - periods in the signal
%          fs - with a given sample frequency
%          
%          signal = ssin('fNfs', 440, 3.3, 48e3);
%
%
%       Case 4
%          f  - signal frequency
%          n  - number of samples
%          fs - with a given sample frequency
%          
%          signal = ssin('fnfs', 440, 200, 48e3);
%
%
%       Case 5
%          f  - signal frequency
%          L  - signal lenght
%          fs - with a given sample frequency
%          
%          signal = ssin('fLfs', 800, 0.001, 48e3);
%
%
%   In every case every parameter can be substituted with the eqvivalent
%   counterparst. ie. f~T, fs~dt, L~n,dt ...
%
%   The amplitude (A) and phase (phi) are optional with the defualt values
%   A=1 and phi=0.
%
%   For more detailed description, visit:
%   http://tiborsimon.github.io/tools/smart-sinusoids/
%
% The MIT License (MIT)
% 
% Copyright (c) 2015 Tibor Simon
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

MODULE_NAME = 'SmartSinusoids';

if nargout == 1
    out1 = ssinusoidcore(@sin, varargin);
elseif nargout == 2
    [t, s] = ssinusoidcore(@sin, varargin);
    out1 = t;
    out2 = s;
else
    throw_exception('argumenterror', 'Number of output argument mismatch.');
end

%% Helper functions
    function throw_exception(header, message)
        id = [MODULE_NAME, ':', header];
        exception = MException(id, message);
        throw(exception)
    end

end
