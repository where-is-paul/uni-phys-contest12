function changeR( r )
% changes the radius defined in the constants file

    str = fileread('getConstant.m'); 
    rep = horzcat('R = ', num2str(r), ';');
    str = regexprep(str, 'R = .*;', rep, 'dotexceptnewline');

    fid = fopen('getConstant.m', 'w');
    fwrite(fid, str, '*char');              %# write characters (bytes)
    fclose(fid);

end

