function [traindata,testdata] = featnorm( traindata,testdata)


MItrain = min(traindata,[],1);
MAtrain = MItrain;
for i=1:size(traindata,2)
        traindata(:,i) = traindata(:,i) - MItrain(i);
        MAtrain(i) = max(traindata(:,i));
        traindata(:,i) = traindata(:,i) / MAtrain(i);
end

for i=1:size(testdata,2)
        testdata(:,i) = testdata(:,i) - MItrain(i);
        testdata(:,i) = testdata(:,i) / MAtrain(i);
end
testdata(testdata>1)=1;
testdata(testdata<0)=0;

