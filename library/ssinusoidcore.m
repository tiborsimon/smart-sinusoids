function [out1, out2] = ssinusoidcore( trigfun, raw_varargin )
%SSINUSOIDCORE Smart Sinusoid synthesizer
%
%   Dependecy
%       To use ssin or ssin, you need to download and add to your path 
%       Simple Input Parser which is a package that allows you to create
%       functions with a more convenient interface.
%       URL: https://github.com/tiborsimon/simple-input-parser
%
%   This functions is the base of thw two Smart Sinusoids function. See the 
%   usage in that functions help.
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

%% Default parameters
data.phi = 0;
data.A   = 1;
data.f   = 0;
data.fs  = 0;
data.T   = 0;
data.dt  = 0;
data.N   = 0;
data.n   = 0;
data.L   = 0;
data.x  = 'index';

flags.phi = 0;
flags.A   = 0;
flags.f   = 0;
flags.fs  = 0;
flags.T   = 0;
flags.dt  = 0;
flags.N   = 0;
flags.n   = 0;
flags.L   = 0;
flags.x   = 0;

function [valid, errormsg] = validate_A(value)
    errormsg = 'Parameter A has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_f(value)
    errormsg = 'Parameter f has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_fs(value)
    errormsg = 'Parameter fs has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_T(value)
    errormsg = 'Parameter T has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_dt(value)
    errormsg = 'Parameter dt has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_N(value)
    errormsg = 'Parameter N has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_n(value)
    errormsg = 'Parameter n has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_L(value)
    errormsg = 'Parameter L has to be greater than zero!';
    valid = value>0;
end

function [valid, errormsg] = validate_x(value)
    errormsg = 'Parameter x has to be one of these: index, norm, time';
    valid = strcmp(value, 'index') || strcmp(value, 'norm') || strcmp(value, 'time') || strcmp(value, 'militime') || strcmp(value, 's') || strcmp(value, 'ms');
end

validators.A  = @validate_A;
validators.f  = @validate_f;
validators.fs = @validate_fs;
validators.T  = @validate_T;
validators.dt = @validate_dt;
validators.N  = @validate_N;
validators.n  = @validate_n;
validators.L  = @validate_L;
validators.x  = @validate_x;

%% Dependency check
if exist('simple_input_parser') == 0
    throw_exception('dependencyerror', 'Missing module: Simple Input Parser. You can download it from https://github.com/tiborsimon/simple-input-parser.');
end  

%% Input parameter parsing
varlen = length(raw_varargin);
if varlen < 2
    data.phi = 0;
    data.A   = 1;
    data.f   = 0;
    data.fs  = 0;
    data.T   = 0;
    data.dt  = 0;
    data.N   = 1;
    data.n   = 42;
    data.L   = 0;
    data.x  = 'index';

    flags.phi = 0;
    flags.A   = 0;
    flags.f   = 0;
    flags.fs  = 0;
    flags.T   = 0;
    flags.dt  = 0;
    flags.N   = 1;
    flags.n   = 1;
    flags.L   = 0;
    flags.x   = 0;
else
    [data, flags] = simple_input_parser(data, raw_varargin, validators);
end

%% Error handling
if flags.f && flags.T
    if data.f ~= 1/data.T
        throw_exception('overdefinedSignal',['Ambiguous signal definition: f=', num2str(data.f), 'Hz and T=', num2str(data.T),'s which results to f*=', num2str(1/data.T), 'Hz.']); 
    end
elseif flags.fs && flags.dt
    if data.fs ~= 1/data.dt
        throw_exception('overdefinedSignal',['Ambiguous signal definition: fs=', num2str(data.fs), 'Hz and dt=', num2str(data.dt),'s which results to fs*=', num2str(1/data.dt), 'Hz.']); 
    end
elseif flags.L && flags.dt && flags.n
    if data.L ~= data.n*data.dt
        throw_exception('overdefinedSignal',['Ambiguous signal definition: L=', num2str(data.L), 's and (dt=', num2str(data.dt),'s, n=', num2str(data.n),') which results to L*=', num2str(data.n*data.dt), 's.']); 
    end
end
    

%% Mode Selection
try
    s = construct_with_n_N();
catch
   try
       s = construct_with_L_N_fs();
   catch
      try 
          s = construct_with_f_N_fs();
      catch 
          try
              s = construct_with_n_f_fs();
          catch
              try
                  s = construct_with_L_f_fs();
              catch
                  throw_exception('parameterError','With the given parameters there is no way to construct a sinusoid signal!'); 
              end
          end
          
      end
   end
end

s = data.A .* s(:);

if nargout == 1
    out1 = s;
elseif nargout == 2
    t = 1:length(s);
    t = t(:);
    switch data.x
        case 'index'
        case 'norm'
            t = t./max(t);
        otherwise
            try
                t = t./max(t);
                t = t.* get_L();
                if strcmp(data.x, 'militime') || strcmp(data.x, 'ms')
                    t = t*1000;
                end
            catch
                warning('There is not enough information to calculate the lenght of the signal. x vector calculation falled back to index mode.');
            end
            
    end
    out1 = t;
    out2 = s;
else
    throw_exception('argumenterror', 'Number of output argument mismatch.');
end

%% Signal synthesizer functions
    function s = construct_with_n_N()
        n = get_n();
        N = get_N();
        phi = data.phi;
        
        k = 0:n-1;
        k = k/n;
        phi = phi*pi/180;
        s = trigfun(2*pi*N*k + phi);
    end

    function s = construct_with_L_N_fs()
        L = get_L();
        N = get_N();
        fs = get_fs();
        phi = data.phi;
        
        k = 0:1/fs:L-1/fs;
        k=k/L;
        phi = phi*pi/180;
        s = trigfun(2*pi*N*k + phi);
    end

    function s = construct_with_f_N_fs()
        f = get_f();
        N = get_N();
        fs = get_fs();
        phi = data.phi;
        
        k = 0:1/fs:(N/f)-1/fs;
        phi = phi*pi/180;
        s = trigfun(2*pi*f*k + phi);
    end

    function s = construct_with_n_f_fs()
        n = get_n();
        f = get_f();
        fs = get_fs();
        phi = data.phi;
        
        k = 0:n-1;
        k = k*(1/fs);
        phi = phi*pi/180;
        s = trigfun(2*pi*f*k + phi);
    end

    function s = construct_with_L_f_fs()
        L = get_L();
        f = get_f();
        fs = get_fs();
        phi = data.phi;
        
        n = 0:1/fs:L-1/fs;
        phi = phi*pi/180;
        s = trigfun(2*pi*f*n + phi);
    end


%% Parameter construction
    function f = get_f()
        if flags.f
            f = data.f;
        elseif flags.T
            f = 1 / data.T;
        elseif flags.N && flags.L
            f = data.N / data.L;
        elseif flags.n && flags.dt && flags.L && flags.T
            f = data.n * data.dt / data.L / data.T;
        elseif flags.n && flags.fs && flags.L && flags.T
            f = data.n / data.fs / data.L / data.T;
        else
            throw('.');
        end
    end

    function T = get_T()
        if flags.T
            T = data.T;
        elseif flags.f
            T = 1 / data.f;
        elseif flags.L && flags.N
            T = data.L / data.N;
        elseif flags.L && flags.n && flags.dt && flags.f
            T = data.L / data.n / data.dt / data.f;
        elseif falgs.L && flags.n && flags.fs && flags.f
            T = data.L * data.fs / data.n / data.f;
        else
            throw('.');
        end
    end

    function n = get_n()
        if flags.n
            n = data.n;
        elseif flags.L && flags.fs
            n = data.L * data.fs;
        elseif flags.L && flags.dt
            n = data.L / data.dt;
        elseif flags.N && flags.T && flags.dt
            n = data.N * data.T / data.dt;
        elseif flags.N && flags.T && flags.fs
            n = data.N * data.T * data.fs;
        else
            throw('.')
        end
    end

    function N = get_N()
        if flags.N
            N = data.N;
        elseif flags.L && flags.T
            N = data.L / data.T;
        elseif flags.L && flags.f
            N = data.L * data.f;
        elseif flags.n && flags.dt && flags.T
            N = data.n * data.dt / data.T;
        elseif flags.n && flags.dt && flags.f
            N = data.n * data.dt * data.f;
        elseif flags.n && flags.fs && flags.T
            N = data.n / data.fs / data.T;
        elseif flags.n && flags.f && flags.fs
            N = data.n * data.f / data.fs;
        else
            throw('.')
        end
    end

    function fs = get_fs()
        if flags.fs
            fs = data.fs;
        elseif flags.dt
            fs = 1 / data.dt;
        elseif flags.n && flags.L
            fs = data.n / data.L;
        elseif flags.n && flags.N && flags.T
            fs = data.n / data.N / data.T;
        elseif flags.n && flags.L && flags.f && flags.T
            fs = data.n / data.L / data.f / data.T;
        else
            throw('.');
        end
    end

    function dt = get_dt()
        if flags.dt
            dt = data.dt;
        elseif flags.fs
            dt = 1 / data.fs;
        elseif flags.L && flags.n
            dt = data.L / data.n;
        elseif flags.N && flags.T && flags.n
            dt = data.N * data.T / data.n;
        elseif flags.L && flags.f && flags.T && flags.n
            dt = data.L * data.f * data.T / data.n;
        else
            throw('.');
        end
    end

    function L = get_L()
        if flags.L
            L = data.L;
        elseif flags.N && flags.T
            L = data.N * data.T;
        elseif flags.n && flags.dt
            L = data.n * data.dt;
        elseif flags.N && flags.f
            L = data.N / data.f;
        elseif flags.n && flags.fs
            L = data.n / data.fs;
        else
            throw('.');
        end
    end
    
    
%% Helper functions
    function throw_exception(header, message)
        id = [MODULE_NAME, ':', header];
        exception = MException(id, message);
        throw(exception)
    end

end
