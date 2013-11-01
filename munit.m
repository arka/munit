classdef munit < handle
    %munit Summary of this class goes here
    %
    % Function:
    % .run()  - run test cases
    %
    % Example:
    % classdef munit_test1 < munit
    %     methods
    %         function suiteSetup(obj) end        % run at suite init
    %         function suiteTeardown(obj) end     % run at suite done
    %         function setup_setConfig(obj) end   % run before each test
    %         function setup_loadData(obj) end    % run before each test
    %         function teardown(obj) end          % run after each test
    %         function testA(obj)                 % test case (name: test.*)
    %             fprintf('run test A.\n')
    %             warning('warning cannot be catched.')
    %         end
    %         function testB(obj) end             % test case (name: test.*)
    %         function testC(obj)                 % test case (name: test.*)
    %             fprintf('run test C.\n')
    %             error('ErrorID','What is the error?')
    %         end
    %     end
    % end
	
    methods (Sealed = true)
        function result = run(obj, varargin)
            % munit.run()
            
            result = struct;
            
            % TODO: expand varargin if necessary
            % fprintf('Number of arguments: %d\n',nargin);
            % celldisp(varargin);
            
            % get meta class
            mco = metaclass(obj);
                        
            % get current testcase
            %mlist = mco.MethodList(); % A more detailed method list
            mlist = methods(obj);                                       % type:cell, brief:method list
            
            suiteSetupList    = obj.getFunList(mlist, 'suiteSetup');    % every test suite can have setup functions, run once at beginning
            
            suiteTeardownList = obj.getFunList(mlist, 'suiteTeardown'); % every test suite can have teardown functions, run once at last
            
            setupList         = obj.getFunList(mlist, 'setup');         % setup functions will run before running every test cases
            
            teardownList      = obj.getFunList(mlist, 'teardown');      % setup functions will run after running every test cases
            
            testList          = obj.getFunList(mlist, 'test');          % now we load all the test cases
            
            errorlist = {};                                             % error list for output
            
            % output test case name
            fprintf('%s start\n',mco.Name);
            
            % run suite setup functions
            for i = 1:length(suiteSetupList)
                case_str = strcat('obj.', suiteSetupList{i}, '()');
                try
                    eval(case_str);
                catch error
                    next = length(errorlist)+1;
                    errorlist{next} = error;
                end
            end
            
            fprintf('Number of test cases: %d\n', length(testList));
            % run test functions
            for i = 1:length(testList)
                try
                    % run setup functions
                    for j = 1:length(setupList)
                        case_str = strcat('obj.', setupList{j}, '()');
                        try
                            eval(case_str);
                        catch error
                            rethrow(error)
                        end
                    end
                    
                    % run test function
                    case_str = strcat('obj.', testList{i}, '()');
                    eval(case_str);
                catch error
                    next = length(errorlist)+1;
                    errorlist{next} = error;
                end
                
                % run tear down functions
                for j = 1:length(teardownList)
                    case_str = strcat('obj.', teardownList{j}, '()');
                    try
                        eval(case_str);
                    catch error
                        next = length(errorlist)+1;
                        errorlist{next} = error;
                    end
                end
            end
            
            % run suite tear down functions
            for i = 1:length(suiteTeardownList)
                case_str = strcat('obj.', suiteTeardownList{i}, '()');
                try
                    eval(case_str);
                catch error
                    next = length(errorlist)+1;
                    errorlist{next} = error;
                end
            end
            
            % end of tests
            fprintf('%s done.\n\n',mco.Name);
            
            % return
            result.total_test = length(testList);
            result.error_list = errorlist;
        end
    end
    
    methods (Sealed = true, Hidden)
        function resultList = getFunList(obj, mlist, filter)
            % get function list
            % input is cell of methods
            % resultList will be the methods string list
            
            mmask = strfind(mlist, filter); % method with string 'test' in name mask
            resultList = {};
            for i = 1:length(mlist)
                if mmask{i} == 1
                    next = length(resultList) + 1;
                    resultList{next} = mlist{i};
                end
            end
        end
    end
    
end