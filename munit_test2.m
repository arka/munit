classdef munit_test2 < munit
    methods
        function testA(obj)
            fprintf('run test A.\n')
        end
        function testB(obj)
            fprintf('run test B.\n')
            assert(1==2, 'it is not possible here')
        end
        function testC(obj)
            fprintf('run test C.\n')
            assert(1==2, 'yes, I did it again.')
        end
    end
end
