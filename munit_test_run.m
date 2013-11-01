function munit_test_run()
    clear; clc;

    xTest1 = munit_test1();
    xTest2 = munit_test2();

    result = [xTest1.run(), xTest2.run()];

    if isempty(result)
        fprintf('All pass');
    else
        % concate all the error
        errorList = {};
        for i=1:length(result)
            errorList = [errorList, result(i).error_list];
        end

        % display all the error
        for i=1:length(errorList)
            try
                rethrow(errorList{i});
            catch error
                %err_string = getReport(error, 'extended');
                err_string = getReport(error, 'basic');
                fprintf(2,'#%d.\n%s\n',i, err_string);
            end
        end

        % get total of the tests
        total = 0;
        for i=1:length(result)
            total = total + result(i).total_test;
        end

        % output results
        fprintf('\nTotal test: %d, pass: %d, fail: %d\n', total, total-length(errorList), length(errorList));
    end
end