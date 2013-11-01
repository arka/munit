classdef munit_test1 < munit
    properties
    end
    
    methods
        function suiteSetup(obj)
            fprintf('Suite setup.\n')
        end
        function suiteTeardown(obj)
            fprintf('Suite teardown.\n')
        end
        function setup(obj) end
        function setup_setConfig(obj)
            fprintf('Setup_setConfig.\n')
        end
        function setup_loadData(obj)
            fprintf('Setup_loadData.\n')
        end
        function teardown(obj)
            fprintf('Teardown.\n\n')
            %error('let us fail this teardown');
        end
        function testA(obj)
            fprintf('run test A.\n')
            warning('I am not an error, you cannot catch me.')
        end
        function testB(obj)
            fprintf('run test B.\n')
        end
        function testC(obj)
            fprintf('run test C.\n')
            error('Monster:Chimera','Chimera eat your pet mola mola fish.')
        end
        function testD(obj)
            fprintf('run test D.\n')
        end
    end
end
