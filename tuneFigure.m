function [] = tuneFigure(figs, style, options)
%RESHAPE_FIGURE figureの見た目を整える
%
%   tunefig(figs, style, custom_style)
%       figs:           figure handle(matrix of figure handle)
%       style:          style select('document', 'ppt', %/'custom'/%)
%       options:        styleにさらにカスタマイズを入れる場合のオプション
%
%   See also FIGURE, AXES, LINE

% Copyright (c) 2019 larking95(https://qiita.com/larking95)
% Released under the MIT Licence 
% https://opensource.org/licenses/mit-license.php


% 2020/12/17
% Hayato Dan edited
% 
% Function line are not supported

arguments 
    figs (:,:) = gcf
    style (1,:) char {mustBeMember(style,{'default','document', 'larger', 'bigger', 'ppt', 'qiita'})} = 'default'
    options.Fig_st struct = struct([])
    options.Ax_st struct = struct([])
    options.Line_st struct = struct([])
    options.width double = 640
    options.height double = 400
end


validateattributes(figs, {'matlab.ui.Figure'}, {'vector'});
validateattributes(figs, {'matlab.ui.Figure'}, {'vector'});

%% 初期化
width  = options.width;	% 8:5
height = options.height;
pt2cm = 2.54/72;

%% デフォルト設定の作成
% ======= default mode =======
% Type: figure
% fig_st.Color = 'w';  % 背景色Color = 白'w'
fig_st.PaperPosition = [0 0 pt2cm*width pt2cm*height];
fig_st.PaperSize = [pt2cm*width pt2cm*height];

% Type: axis
% ax_st.Color = 'w';
ax_st.Box = 'on';
ax_st.GridLineStyle = '--';
ax_st.GridAlpha = 1;
ax_st.MinorGridLineStyle = '-';
ax_st.MinorGridAlpha = 0.1;
ax_st.LineWidth = 1;
ax_st.XColor = 'k';
ax_st.YColor = 'k';
ax_st.ZColor = 'k';
% ax_st.GridAlpha = 0.0;
ax_st.FontName = 'Times';
ax_st.FontSize= 20;
ax_st.LabelFontSizeMultiplier= 1.2;

ax_st.XLabel.Interpreter = 'latex'; % $$ $$で囲われた部分をlatex解釈
ax_st.YLabel.Interpreter = 'latex'; % $$ $$で囲われた部分をlatex解釈
ax_st.ZLabel.Interpreter = 'latex'; % $$ $$で囲われた部分をlatex解釈
ax_st.Legend.Interpreter = 'latex'; % $$ $$で囲われた部分をlatex解釈
ax_st.Title.Interpreter = 'latex'; % $$ $$で囲われた部分をlatex解釈


% Type: line
ln_st.LineWidth = 3;


switch style
    case 'document'
        % ======= document ======
    case 'larger'
        % ======= larger ======
        ax_st.FontSize= 28;
        ln_st.LineWidth = 4;

    case 'bigger'
        % ======= bigger ======
        ax_st.FontSize= 42;
        ln_st.LineWidth = 5;

    case 'ppt'
        % ======= ppt =======
%         fig_st.Color = 'none'; % 背景色のみ透明に
        ax_st.FontSize= 36;
        ln_st.LineWidth = 5;
    case 'qiita'
        % ======= qiita =======
        ax_st.LineWidth = 2;   % 軸のライン幅変更
        ax_st.FontSize= 15;
        ln_st.LineWidth = 2;   % プロットのライン幅だけに変更
end
       
   
% カスタムスタイルでデフォルトの設定を上書き
if ~isempty(options.Fig_st)
    custom_fig_fields = fieldnames(options.Fig_st);
    for i = 1:length(custom_fig_fields)
        fig_st.(custom_fig_fields{i}) = options.Fig_st.(custom_fig_fields{i});
    end
end
if ~isempty(options.Ax_st)
    custom_ax_fields = fieldnames(options.Ax_st);
    for i = 1:length(custom_ax_fields)
        ax_st.(custom_ax_fields{i}) = options.Ax_st.(custom_ax_fields{i});
    end
end
if ~isempty(options.Line_st)
    custom_ln_fields = fieldnames(options.Line_st);
    for i = 1:length(custom_ln_fields)
        ln_st.(custom_ln_fields{i}) = options.Line_st.(custom_ln_fields{i});
    end
end


%% 整形
ff = fieldnames(fig_st);
af = fieldnames(ax_st);
lf = fieldnames(ln_st);

for f = 1:length(figs)
    figs(f).PaperPositionMode = 'auto';
    pos = get(figs(f), 'Position');
    pos(3) = width-1;
    pos(4) = height;
    figs(f).Position = pos;
    
    for ffidx = 1:length(ff)
        figs(f).(cell2mat(ff(ffidx))) = fig_st.(cell2mat(ff(ffidx)));
    end
    ax = findobj(figs(f),'Type','axes');
    for a = 1:length(ax)
        for afidx = 1:length(af)
            if isempty(ax_st.(cell2mat(af(afidx))))
                continue;
            end
            if isstruct(ax_st.(cell2mat(af(afidx))))
                sf = fieldnames(ax_st.(cell2mat(af(afidx))));
                for sfidx = 1:length(sf)
                    field1 = cell2mat(af(afidx));
                    field2 = cell2mat(sf(sfidx));
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%% suppress the error about legend
                    %%%%
                    %%%% 
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    warning('off','MATLAB:handle_graphics:exceptions:SceneNode')
                    if strcmp(field2,'Interpreter')&&~isempty(ax(a).(field1))
                        % (ax_st(style_num).(cell2mat(af(afidx)))==(Label or Legend).Interpreterで
                        % かつ
                        % （Label or Legend）が存在する場合
                        latex_contain = strfind(ax(a).(field1).String, '$$','ForceCellOutput',true);
                        latex_contain = cell2mat(latex_contain);
                        if any(latex_contain)
                            ax(a).(field1).(field2) = ax_st.(cell2mat(af(afidx))).Interpreter;
                        else
                            ax(a).(field1).(field2) = 'none'; % $$が存在しない場合はtex
                        end   
                    end
                    warning('on','MATLAB:handle_graphics:exceptions:SceneNode')
                end
            else
                ax(a).(cell2mat(af(afidx))) = ax_st.(cell2mat(af(afidx)));
            end
        end
        ln = findobj(ax(a),'Type','Line','-or','Type','Bar','-or','Type','ErrorBar','-or','Type','Scatter','-or','Type','Stair');
        for l = 1:length(ln)
            for lfidx = 1:length(lf)
                ln(l).(cell2mat(lf(lfidx))) = ln_st.(cell2mat(lf(lfidx)));
            end
        end
    end

    

end