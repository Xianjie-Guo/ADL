function [skeleton] = new_rule(init_skeleton, SepSet, PC, p)

for i=1:p
    for j=1:i-1
        common_pc=intersect(PC{i},PC{j});
        if init_skeleton(i,j)==1&&init_skeleton(j,i)==0 % the PC set of i includes j but i is not in the PC set of j 
            if ~isempty(intersect(common_pc,SepSet{j,i})) % there exists a variable in the sepset of j from i that is the common PC of i and j 
                init_skeleton(i,j)=0; % using the AND-rule
            else
                init_skeleton(j,i)=1; % using the OR-rule
            end
        elseif init_skeleton(i,j)==0&&init_skeleton(j,i)==1 % j is not in the PC set of i but the PC set of j includes i   
            if ~isempty(intersect(common_pc,SepSet{i,j})) % there exists a variable in the sepset of i from j that is the common PC of i and j 
                init_skeleton(j,i)=0; % using the AND-rule
            else   
                init_skeleton(i,j)=1; % using the OR-rule
            end
        end
    end
end
skeleton=init_skeleton;
end

