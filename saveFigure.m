function saveFigure(foldername, filename, options)
    arguments
        foldername (1, :) string {mustBeFolder} = ".\"
        filename string = ""
        options.AutoSave char {mustBeMember(options.AutoSave, {'unabled', 'enabled'})} = 'unabled'
    end

    

    fig = gcf;
%% 現在のfigureをpng,fig,pdfで保存

    % filenameが空ならタイムスタンプで保存
    if strcmp(filename, "")
        t = datetime('now');
        stamp = yyyymmdd(t);
        [h,m,~] = hms(t);
        baseName = sprintf('matlab_figure_%8d_%02d%02d_%02d',stamp,h,m,fig.Number);
        fullfilename = fullfile(foldername, baseName);
    else
        fullfilename = fullfile(foldername, filename);
    end

    if options.AutoSave == "unabled"        
        fullfilenameEscaped = strrep(fullfilename, "\", "\\");
        saveflag = input(sprintf("Do you want to save the figure as \n %s  (y/n)\n",fullfilenameEscaped), 's');
        if saveflag ~= "y"
            disp('No save');
            return;
        end
    end

    fprintf(" Saving as: %s \n", fullfilename)

    fig.PaperPositionMode = 'auto';
    fig_pos = fig.PaperPosition;
    fig.PaperSize = 1.01 * [fig_pos(3) fig_pos(4)];

    print(fig, char(fullfilename), '-dpdf');
    print(fig, char(fullfilename), '-dpng');
    savefig(fig, char(fullfilename));
end


