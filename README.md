# MATLABのFigure調整用
MATLABの図を良い感じに調整・保存するスクリプト関数

# 使い方
1. MATLABのパスが通っているところ（Documents/MATLABなど）にtuneFigure.mとsaveFigure.mを置く
2. 適当にplotした後にtuneFigure，saveFigureを呼び出すといい感じに調整して，fig, png, pdfで保存してくれる．

例
```
clear all
close all

x = 0:0.01:4;
y = sin(x);

figure
plot(x,y)
xlabel('$$x$$ [m]')
ylabel('$$y$$ [m]')
grid on

tuneFigure();
saveFigure();
```
![matlab_figure_20240110_1001_01](https://github.com/HayatoDan/matlab-figure-tweak/assets/90384782/c09e2c15-eea6-4e08-8c37-4f4107d239b1)

実行するとコマンドウインドウに図をセーブするか聞かれるのでy/nで答える．

# 使い方詳細
## tuneFigure(figs,style,custom_style)
### figs
整えるfigure handleを指定．デフォルトでは`gcf`（現在のfigure）を渡している．

### style
整え方を指定．
デフォルトで用意されているのは
`default`,`document`,`qiita`,`ppt`,`custom`

`custom`を指定した場合はつぎのcustom_styleの指定が必要となる

例：
```
clear all
close all

x = 0:0.01:4;
y = sin(x);

f = figure;
plot(x,y)
xlabel('$$x$$ [m]')
ylabel('$$y$$ [m]')
grid on

tuneFigure(f,"default");
saveFigure('','AutoSave','enabled');
```

### custom_style
cell形式でfig,ax,lineのスタイルを渡す．
例：
```
clear all
close all

x = 0:0.01:4;
y = sin(x);

f = figure;
plot(x,y)
xlabel('$$x$$ [m]')
ylabel('$$y$$ [m]')
grid on

fig_st.Color = 'w'; % 背景色を白に
ax_st.LineWidth = 2;
ln_st.LineWidth = 2;

custom_style = {fig_st,ax_st,ln_st};

tuneFigure(f,'custom',custom_style);
saveFigure('','AutoSave','enabled');
```
![matlab_figure_20240110_1017_01](https://github.com/HayatoDan/matlab-figure-tweak/assets/90384782/bd4e40f8-11f2-46f3-81b2-1f78a88eca2d)


## saveFigure(foldername, filename, option)
### foldername, filename
保存名を指定できる．
何も指定しないとカレントディレクトリ内に'matlab_figure_yyyymmdd_hhmm_(figurenum).拡張子'で保存される．

存在するディレクトリを指定すればそのディレクトリ下に保存してくれる．
例えば`saveFigure("dir\")`とするとdirディレクトリ下に保存される．
### option
#### AutoSave
`saveFigure('','AutoSave','enabled')`でセーブするか確認せずに図を保存する．
同名のファイルがある場合に上書きするので注意．
