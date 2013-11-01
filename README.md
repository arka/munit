munit
=====

Small matlab unit(munit) test class

Why: I was looking for something small and simple to use.

Known things:
* Cannot catch error in C code. 
* Code implemented with a brief summary. And for flexibility and small code base, I would just return MException if no need for summary.
* Code tested with Matlab 2011a, 2012a and 2013b.

Alternative:
* [Matlab's unit test](http://www.mathworks.com/help/matlab/matlab-unit-test-framework.html) framework in 2013b.
* Open source [xUnity](http://www.mathworks.com/matlabcentral/fileexchange/22846-matlab-xunit-test-framework) package for matlab. 

Usage:
```matlab
  classdef munit_test1 < munit
    methods
        function suiteSetup(obj) end        % run at suite init
        function suiteTeardown(obj) end     % run at suite done
        function setup_setConfig(obj) end   % run before each test
        function setup_loadData(obj) end    % run before each test
        function teardown(obj) end          % run after each test
        function testA(obj)                 % test case (name: test.*)
            fprintf('run test A.\n')
            warning('warning cannot be catched.')
        end
        function testB(obj) end             % test case (name: test.*)
        function testC(obj)                 % test case (name: test.*)
            fprintf('run test C.\n')
            error('ErrorID','What is the error?')
        end
    end
  end
```

Licence: MIT
