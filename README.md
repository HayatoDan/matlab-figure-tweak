# MATLABのFigure調整用
MATLABの図を良い感じに調整・保存するスクリプト関数

# Known issue
MATLAB2025aだとlatex文字の扱いが少し変になる．

今後要調整

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
## tuneFigure(figs,style,options)
### figs
整えるfigure handleを指定．デフォルトでは`gcf`（現在のfigure）を渡している．

### style
整え方を指定．
デフォルトで用意されているのは
`default`,`document`,`larger`,`bigger`,`qiita`,`ppt`

その他，いずれかのスタイルをベースに微調整することも可能

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
saveFigure('AutoSave','yes');
```

### 
オプションの`Fig_st`,`Ax_st`,`Line_st`に構造体を渡すと微調整が可能

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
ln_st.LineWidth = 20;% めっちゃ太くする


tuneFigure(f,'default','Fig_st',fig_st,'Line_st',ln_st);
saveFigure('AutoSave','yes');
```

<img width="998" height="625" alt="matlab_figure_20251008_1015_01" src="https://github.com/user-attachments/assets/c81c6dd8-be46-477c-846b-01a845162249" />



## saveFigure(foldername, filename, option)
### foldername, filename
保存名を指定できる．
何も指定しないとカレントディレクトリ内に'matlab_figure_yyyymmdd_hhmm_(figurenum).拡張子'で保存される．

存在するディレクトリを指定すればそのディレクトリ下に保存してくれる．

例えば`saveFigure("dir\")`とするとdirディレクトリ下に保存される．

`saveFigure("dir\","hoge")`とするとdirディレクトリ下にhoge.png, hoge.fig, hoge.pdfが保存される．
### option
#### AutoSave
`saveFigure('AutoSave','yes')`でセーブするか確認せずに図を保存する．
同名のファイルがある場合に上書きするので注意．

#### Regacy
`saveFigure('Regacy',true)`でレガシーモード（`exportgraphics`を使わないモード）に切り替え．

`exportgraphics`で生成したpdfは縦横サイズが勝手に調整されてしまうので，それが嫌な場合はこちらを使う．

