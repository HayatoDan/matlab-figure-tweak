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
    

%% figure�ǂݍ���
fig = gcf;
%% ���݂�figure��png,fig,pdf�ŕۑ�
if strcmp(filename,'') % ������Y�ꂽ��Cmatlab_figure_yyyymmdd_hhmm[figure�ԍ�]���t�@�C�����Ƃ��č쐬
    t = datetime('now');
    stamp = yyyymmdd(t);
    [h,m,~] = hms(t);
    filename = sprintf('matlab_figure_%8d_%02d%02d_%02d',stamp,h,m,fig.Number);
end


if filename(end) == '\' % �t�@�C������\�ŏI����Ă���i�t�H���_�w��j�̏ꍇ�͂��̃t�H���_��timestamp��t���ĕۑ�
    t = datetime('now');
    stamp = yyyymmdd(t);
    [h,m,~] = hms(t);
    filename_ = sprintf('matlab_figure_%8d_%02d%02d_%02d',stamp,h,m,fig.Number);
    filename = strcat(filename,filename_);
end

disp('saving as')
disp(['''' filename ''''])
%% Figure�ɍ��킹�Ď����g��
% ax = gca;
% outerpos = ax.OuterPosition;
% ti = ax.TightInset; 
% left = outerpos(1) + ti(1);
% bottom = outerpos(2) + ti(2);
% ax_width = outerpos(3) - ti(1) - ti(3);
% ax_height = outerpos(4) - ti(2) - ti(4);
% ax.Position = [left bottom ax_width ax_height];
%% Figure �̃T�C�Y�ƃy�[�W �T�C�Y�̎w��

fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
%%% pdf,png,fig���쐬
print(filename,'-dpdf');
print(filename,'-dpng');
savefig(filename);