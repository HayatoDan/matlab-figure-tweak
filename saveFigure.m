function saveFigure(filename,options)
    arguments
        filename char = ''
        options.AutoSave char {mustBeMember(options.AutoSave,{'unabled','enabled'})} = 'unabled'
    end
   
if strcmp(options.AutoSave,'unabled')
    saveflag = input('Do you want to save the figure? (y/n)\n','s');
    if strcmp(saveflag,'y')
    else
        disp('no save')
        return
    end
end
    

%% figure読み込み
fig = gcf;
%% 現在のfigureをpng,fig,pdfで保存
if strcmp(filename,'') % 引数を忘れたら，matlab_figure_yyyymmdd_hhmm[figure番号]をファイル名として作成
    t = datetime('now');
    stamp = yyyymmdd(t);
    [h,m,~] = hms(t);
    filename = sprintf('matlab_figure_%8d_%02d%02d_%02d',stamp,h,m,fig.Number);
end


if filename(end) == '\' % ファイル名が\で終わっている（フォルダ指定）の場合はそのフォルダにtimestampを付けて保存
    t = datetime('now');
    stamp = yyyymmdd(t);
    [h,m,~] = hms(t);
    filename_ = sprintf('matlab_figure_%8d_%02d%02d_%02d',stamp,h,m,fig.Number);
    filename = strcat(filename,filename_);
end

disp('saving as')
disp(['''' filename ''''])
%% Figureに合わせて軸を拡張
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset; 
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
%% Figure のサイズとページ サイズの指定

fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
%%% pdf,png,figを作成
print(filename,'-dpdf');
print(filename,'-dpng');
savefig(filename);