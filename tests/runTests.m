function runTests()

    isFailed=0;

    for i=0:1
        result=testNuka(i);

        if result~=i
            isFailed=1;
            fprintf('Warning: testNuka has failed.\n');
        end
       
        result=testNuka_nonAGCT(i);

        if result~=i
            isFailed=1;
            fprintf('Warning: testNuka_nonAGCT has failed.\n');
        end
    end

    if isFailed==0
        fprintf('All tests have passed.\n');
    end

end