function [subset_accuracy,signal_subset_accuracy,multi_subset_accuracy] = S_accuracy(prediction,testtarget)
   signal_targetnum = 0;
   multi_targetnum = 0;
   num_test_signal = 0;
   num_test_multi = 0;
   if size(prediction)~=size(testtarget)
        error( 'The sizes of prediction and turth are not match');
   else
        num_test= size(testtarget,2);
        num=0;
        for i=1:num_test
           temp_target = find(testtarget(:,i)==1);
           if  size(temp_target,1) == 1
                 num_test_signal = num_test_signal+1;
           end
           if  size(temp_target,1) >1
                 num_test_multi = num_test_multi+1;
           end
           if prediction(:,i)==testtarget(:,i)
              num=num+1;
              flag_target = find(testtarget(:,i)==1);
              if size(flag_target,1) == 1
                  signal_targetnum = signal_targetnum+1;
              end
              if size(flag_target,1) > 1
                  multi_targetnum = multi_targetnum+1;
              end
           end  
        end
        subset_accuracy = num/num_test;
        signal_subset_accuracy = signal_targetnum/num_test_signal;
        multi_subset_accuracy = multi_targetnum/num_test_multi;  
   end
end