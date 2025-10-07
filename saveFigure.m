function saveFigure(foldername, filename, options)
    arguments
        foldername (1, :) string {mustBeFolder} = ".\"
        filename string = ""
        options.AutoSave char {mustBeMember(options.AutoSave, {'yes', 'ask', 'no'})} = 'ask'
    end

    

    fig = gcf;
%% ���݂�figure��png,fig,pdf�ŕۑ�

    % filename����Ȃ�^�C���X�^���v�ŕۑ�
    if strcmp(filename, "")
        t = datetime('now');
        stamp = yyyymmdd(t);
        [h,m,~] = hms(t);
        baseName = sprintf('matlab_figure_%8d_%02d%02d_%02d',stamp,h,m,fig.Number);
        fullfilename = fullfile(foldername, baseName);
    else
        fullfilename = fullfile(foldername, filename);
    end

    if options.AutoSave == "ask"        
        fullfilenameEscaped = strrep(fullfilename, "\", "\\");
        saveflag = input(sprintf("Do you want to save the figure as \n %s  (y/n)\n",fullfilenameEscaped), 's');
        if saveflag ~= "y"
            disp('No save');
            return;
        end
    end

    if options.AutoSave == "no"
        disp('No save');
        return;
    end

    fprintf(" Saving as: %s \n", fullfilename)

    fig.PaperPositionMode = 'auto';
    fig_pos = fig.PaperPosition;
    fig.PaperSize = 1.01 * [fig_pos(3) fig_pos(4)];

    print(fig, char(fullfilename), '-dpdf');
    print(fig, char(fullfilename), '-dpng');
    savefig(fig, char(fullfilename));
end


