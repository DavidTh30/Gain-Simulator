{%BuildCommand $(CompPath) $EdFile()}
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TASources, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls, ComCtrls, BGRABitmap,
  BGRABitmapTypes, LCLIntf;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart2: TChart;
    Chart2LineSeries1: TLineSeries;
    Chart2LineSeries2: TLineSeries;
    Chart2LineSeries3: TLineSeries;
    Chart2LineSeries4: TLineSeries;
    Chart2LineSeries5: TLineSeries;
    Chart3: TChart;
    Chart4: TChart;
    Chart5: TChart;
    Chart6: TChart;
    Chart6LineSeries1: TLineSeries;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit1: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    IdleTimer1: TIdleTimer;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lcsDerivative: TListChartSource;
    lcsDerivative1: TListChartSource;
    lcsDerivative2: TListChartSource;
    lcsDerivative3: TListChartSource;
    lcsDerivative4: TListChartSource;
    lcsDerivative5: TListChartSource;
    PageControl1: TPageControl;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    ScrollBar4: TScrollBar;
    ScrollBar5: TScrollBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit4EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure ScrollBar4Change(Sender: TObject);
    procedure ScrollBar5Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Chatr6Active();
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    Function Distance_(BEGIN_: Extended; END_: Extended) : Extended;
    Function Postion_(BEGIN_: Extended; END_: Extended; DistanceExt: Extended) : Extended;
    Function PositionToPersen_(BEGIN_: Extended; END_: Extended; PositionExt: Extended) : Extended;
    Function PersenToPosition_(BEGIN_: Extended; END_: Extended; PersenExt: Extended) : Extended;
    Function PersenToDistance_(BEGIN_: Extended; END_: Extended; PersenExt: Extended) : Extended;
    Function Min_(Valve1_: Extended; Valve2_: Extended) : Extended;
    Function Max_(Valve1_: Extended; Valve2_: Extended) : Extended;
  end;

var
  Form1: TForm1;
  Zero_: Extended;
  Gain_: Extended;
  Ramp_up: Extended;
  Ramp_down: Extended;
  Old_value: Extended;
  New_value: Extended;
  Old_TickCount: extended;
  New_TickCount: extended;
  Ed1: String;
  ED2: String;
  Simulate: Extended;
  Simulate_Po_Ne: Boolean;
  Simulate_Old : Extended;
  Simulate_New : Extended;
const
  Po1: array[0..3, 0..1] of Extended =
    (
    (-65, -8),
    (11, -8),
    (11, 7),
    (-65, 7)
    );
  Po2: array[0..15] of Extended =
    (
    (0),
    (pi/8),
    (pi/4),
    ((pi/4)+(pi/8)),
    (pi/2),
    ((pi/2)+(pi/8)),
    ((pi/2)+(pi/4)),
    ((pi/2)+(pi/4)+(pi/8)),
    (pi),
    ((pi)+(pi/8)),
    ((pi)+(pi/4)),
    ((pi)+(pi/4)+(pi/8)) ,
    ((pi)+(pi/2)),
    ((pi)+(pi/2)+(pi/8)),
    ((pi)+(pi/2)+(pi/4)),
    ((pi)+(pi/2)+(pi/4)+(pi/8))
    );

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.FormCreate(Sender: TObject);
var
  bmp: TBGRABitmap;
  x : Extended;
  y : Extended;
  x1 : Extended;
  y1 : Extended;
  t : Extended;
  //c: TBGRAPixel;
  i : integer;
  Orgx: Extended;
  Orgy: Extended;
  //dt_: Extended;
  //dt2_: Extended;

begin
//bmp := TBGRABitmap.Create(ClientWidth,ClientHeight, ColorToBGRA(ColorToRGB(clBtnFace))); // BGRA(239,239,239)
////bmp.Canvas2D.fillStyle ('rgb(130,100,255)');
//bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
////bmp.Canvas2D.beginPath();
//bmp.Canvas2D.lineWidth:=1;
////bmp.Canvas2D.moveTo(5,5);bmp.Canvas2D.lineTo(20,10);bmp.Canvas2D.lineTo(55,5);bmp.Canvas2D.lineTo(45,18);bmp.Canvas2D.lineTo(30,50);
////bmp.Canvas2D.closePath();
////bmp.Canvas2D.stroke();
////bmp.Canvas2D.fill();
//
////bmp.Canvas2D.rotate(ScrollBar1.Position/1000);
//bmp.Canvas2D.fillStyle('rgb(240,128,0)');
//bmp.Canvas2D.fillRect(30,30,80,60);
////bmp.Canvas2D.rotate(-50);
//bmp.Canvas2D.strokeRect(50,50,80,60);
//
//bmp.Draw(Canvas,0,0);
//
//bmp.Free;
  Simulate := 0;
  Simulate_Po_Ne := False;
  lcsDerivative5.Clear;
  Old_TickCount := 0;
  New_TickCount := 0;
  Orgx := 48/2;
  Orgy := 48/2;
//  Po2 := Po1;
  bmp := TBGRABitmap.Create(48,48, ColorToBGRA(ColorToRGB(clBtnFace))); //ColorToBGRA(ColorToRGB(clBtnFace)) // BGRA(239,239,239)  //88,195,BGRA(239,239,239)
//
//  t := (((-pi)/4/10000)*ScrollBar1.Position)+(pi/8);  //(2*pi/10000)*ScrollBar1.Position;
//  x :=((-55)*cos(t))+Orgx;
//  y :=((-55)*sin(t))+Orgy;
//
  bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;
  bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
  bmp.Canvas2D.fillStyle(BGRA(60,60,255,255));
  bmp.Canvas2D.fillRect(0,0,48,48);

  for i := 0 to 15 do
  begin
    t := Po2[i];
    x := (17*cos(t)) - (0*sin(t))+Orgx;
    y := (17*sin(t)) + (0*cos(t))+Orgy;
    x1 := (22*cos(t)) - (0*sin(t))+Orgx;
    y1 := (22*sin(t)) + (0*cos(t))+Orgy;
    bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,255,255,255),1);
  end;

  bmp.EllipseAntialias(Orgx,Orgy,23,23,BGRA(255,255,255,255),1);
  bmp.EllipseAntialias(Orgx,Orgy,16,16,BGRA(0,0,0,255),1);

  t := Po2[6];
  x := (-6*cos(t)) - (0*sin(t))+Orgx;
  y := (-6*sin(t)) + (0*cos(t))+Orgy;
  x1 := (14*cos(t)) - (0*sin(t))+Orgx;
  y1 := (14*sin(t)) + (0*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,155,255),2);
  x := (-4*cos(t)) - (1*sin(t))+Orgx;
  y := (-4*sin(t)) + (1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  x := (-4*cos(t)) - (-1*sin(t))+Orgx;
  y := (-4*sin(t)) + (-1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (-1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (-1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);

  bmp.Draw(Image1.Canvas,0,0);
  bmp.Draw(Image2.Canvas,0,0);
  bmp.Draw(Image3.Canvas,0,0);
  bmp.Draw(Image4.Canvas,0,0);
  bmp.Free;

  Zero_ := 0;
  Gain_ := 0;
  Ramp_up := 1;
  Ramp_Down := 1;
  Old_value := 0;
  New_value := 0;

  //bmp := TBGRABitmap.Create(208,208, ColorToBGRA(ColorToRGB(clBtnFace)));
  //bmp.Canvas2D.stroke();
  //bmp.Canvas2D.lineWidth:=1;
  //bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
  //bmp.Canvas2D.fillStyle(BGRA(200,200,200,255));
  ////bmp.Canvas2D.fillRect(0,0,208,208);
  ////StringToBarcodeToTBitmap.Canvas.TextOut(StrToInt(FloatToStr((StringToBarcodeToTBitmap.Width-Sum_)/2))-StrToInt(FloatToStr((StringToBarcodeToTBitmap.Canvas.TextExtent(Text_).cx-Sum_2)/2)) ,StringToBarcodeToTBitmap.Canvas.Height-StringToBarcodeToTBitmap.Canvas.TextExtent(Text_).cy,Text_);
  //bmp.Canvas.Font.Size:=7;
  ////bmp.Canvas.TextOut(0,0,'123');
  //
  //bmp.FontHeight := 7;
  //Orgx := bmp.Canvas.TextExtent(Edit4.Text).cx;
  //Orgx := bmp.TextSize(Edit1.Text).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/2)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/2)).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/4)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/4)).cx;
  //if  Orgx < bmp.TextSize(Edit4.Text).cx then Orgx := bmp.TextSize(Edit4.Text).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/2)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/2)).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/4)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/4)).cx;
  //Orgx := Orgx+4;
  //Orgy := bmp.TextSize(Edit1.Text).cy;
  //if  bmp.TextSize(Edit1.Text).cy < bmp.TextSize(Edit4.Text).cy then Orgy := bmp.TextSize(Edit4.Text).cy;
  //x := Orgx-(bmp.TextSize(Edit2.Text).cx/2);
  //if x <= 0 then x:= 0;
  //bmp.TextOut(x,0,Edit2.Text,ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),dt_);
  //bmp.TextOut(0,10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_/2)+(dt_/4));
  //bmp.TextOut(0,((208-Orgy-10-4)/4)+10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_/2));
  //bmp.TextOut(0,((208-Orgy-10-4)/2)+10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_/4));
  //bmp.TextOut(0,((208-Orgy-10-4)/2)+((208-Orgy-10-4)/4)+10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_-dt_));
  //bmp.TextOut(0,200-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  ////bmp.Canvas.Colors[0,0] := bmp.Canvas.Colors[0,100];
  //bmp.DrawPolyLineAntialias([PointF(Orgx,10), PointF(Orgx,208-Orgy-4), PointF(190,208-Orgy-4)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,10), PointF(Orgx-3,10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,((208-Orgy-10-4)/4)+10), PointF(Orgx-3,((208-Orgy-10-4)/4)+10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,((208-Orgy-10-4)/2)+10), PointF(Orgx-3,((208-Orgy-10-4)/2)+10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,((208-Orgy-10-4)/2)+((208-Orgy-10-4)/4)+10), PointF(Orgx-3,((208-Orgy-10-4)/2)+((208-Orgy-10-4)/4)+10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,208-Orgy-4), PointF(Orgx-3,208-Orgy-4)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,208-Orgy-4), PointF(Orgx,208-Orgy-1)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(190,208-Orgy-4), PointF(190,208-Orgy-1)],BGRA(0,0,0,255),1);
  //
  //bmp.TextOut(x,0,Edit2.Text,ColorToBGRA(ColorToRGB(clInfoText)));
  //bmp.TextOut(Orgx,208-(Orgy),'0',ColorToBGRA(ColorToRGB(clInfoText)));
  //bmp.TextOut(190-(bmp.TextSize('1').cx/2),208-(Orgy),'1',ColorToBGRA(ColorToRGB(clInfoText)));
  //bmp.TextOut(190+4,208-(Orgy)-4-(bmp.TextSize('T').cy/2),'T',ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt2_ := PositionToPersen_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Zero_);
  ////button1.Caption:=FloatToStr(dt2_);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,(208-Orgy-4)-((208-Orgy-4-10)/(10)*dt2_/10)), PointF(190,(208-Orgy-4)-((208-Orgy-4-10)/(10)*dt2_/10))],BGRA(0,0,255,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,(208-Orgy-4)-((208-Orgy-4-10)/(10)*0/10)), PointF(190,(208-Orgy-4)-((208-Orgy-4-10)/(10)*0/10))],BGRA(0,2550,0,255),1);
  ////Edit3.Text:=FloatToStr(Zero_) + ' ' + FloatToStr(StrToFloat(Edit1.Text)-StrToFloat(Edit4.Text));
  //bmp.Draw(Image5.Canvas,0,0);
  //Image5.Refresh;
  //bmp.Free;
  ////button1.Caption:=FloatToStr(Postion_(0,10,9));

  lcsDerivative.Clear;
  lcsDerivative.Add(0,0);
  lcsDerivative.Add(1,0);
  Chart2.LeftAxis.Range.UseMax:=True;
  Chart2.LeftAxis.Range.UseMin:=True;
  Chart2.LeftAxis.Range.Max:=StrToFloat(Edit1.Text);
  Chart2.LeftAxis.Range.Min:=StrToFloat(Edit4.Text);
  Chart2.BottomAxis.Range.UseMax:=True;
  Chart2.BottomAxis.Range.UseMin:=True;
  Chart2.BottomAxis.Range.Max:=1;
  Chart2.BottomAxis.Range.Min:=0;
  lcsDerivative.SetyValue(0,Zero_);
  lcsDerivative.SetyValue(1,Zero_);

  lcsDerivative1.Clear;
  lcsDerivative1.Add(0,0);
  lcsDerivative1.Add(1,0);
  Chart3.LeftAxis.Range.UseMax:=True;
  Chart3.LeftAxis.Range.UseMin:=True;
  Chart3.LeftAxis.Range.Max:=100;
  Chart3.LeftAxis.Range.Min:=0;
  Chart3.BottomAxis.Range.UseMax:=True;
  Chart3.BottomAxis.Range.UseMin:=True;
  Chart3.BottomAxis.Range.Max:=1;
  Chart3.BottomAxis.Range.Min:=0;
  lcsDerivative1.SetyValue(0,Gain_);
  lcsDerivative1.SetyValue(1,Gain_);

  lcsDerivative2.Clear;
  lcsDerivative2.Add(0,StrToFloat(Edit4.Text));
  lcsDerivative2.Add(Ramp_up,StrToFloat(Edit1.Text));
  Chart4.LeftAxis.Range.UseMax:=True;
  Chart4.LeftAxis.Range.UseMin:=True;
  Chart4.LeftAxis.Range.Max:=StrToFloat(Edit1.Text);
  Chart4.LeftAxis.Range.Min:=StrToFloat(Edit4.Text);
  Chart4.BottomAxis.Range.UseMax:=True;
  Chart4.BottomAxis.Range.UseMin:=True;
  Chart4.BottomAxis.Range.Max:=Ramp_up;
  Chart4.BottomAxis.Range.Min:=0;
  lcsDerivative2.SetxValue(0,0);
  lcsDerivative2.SetxValue(1,Ramp_up);

  lcsDerivative3.Clear;
  lcsDerivative3.Add(0,StrToFloat(Edit1.Text));
  lcsDerivative3.Add(Ramp_Down,StrToFloat(Edit4.Text));
  Chart5.LeftAxis.Range.UseMax:=True;
  Chart5.LeftAxis.Range.UseMin:=True;
  Chart5.LeftAxis.Range.Max:=StrToFloat(Edit1.Text);
  Chart5.LeftAxis.Range.Min:=StrToFloat(Edit4.Text);
  Chart5.BottomAxis.Range.UseMax:=True;
  Chart5.BottomAxis.Range.UseMin:=True;
  Chart5.BottomAxis.Range.Max:=Ramp_Down;
  Chart5.BottomAxis.Range.Min:=0;
  lcsDerivative3.SetxValue(0,0);
  lcsDerivative3.SetxValue(1,Ramp_Down);

  Chatr6Active
end;
procedure TForm1.FormPaint(Sender: TObject);
begin
end;

Function TForm1.Distance_(BEGIN_: Extended; END_: Extended) : Extended;
begin
  distance_:=0;
  if (BEGIN_ >= 0) and (END_ >= 0) then distance_ := abs(BEGIN_ - END_);
  if (BEGIN_ >= 0) and (END_ < 0) then distance_ := BEGIN_ + abs(END_);
  if (BEGIN_ < 0) and (END_ >= 0) then distance_ := abs(BEGIN_) + END_;
  if (BEGIN_ < 0) and (END_ < 0) then distance_ := abs(abs(BEGIN_) - abs(END_));
end;

Function TForm1.Postion_(BEGIN_: Extended; END_: Extended; DistanceExt: Extended) : Extended;
begin
  Postion_:=0;
  //if (DistanceExt <= Distance_(BEGIN_,END_)) and (DistanceExt >= 0) then
  //begin
      if (BEGIN_ >= 0) and (END_ >= 0) and (BEGIN_ <= END_) then Postion_ := BEGIN_ + DistanceExt;
      if (BEGIN_ >= 0) and (END_ >= 0) and (BEGIN_ >= END_) then Postion_ := BEGIN_ - DistanceExt;

      if (BEGIN_ < 0) and (END_ >= 0) then Postion_ := BEGIN_ + DistanceExt;

      if (BEGIN_ >= 0) and (END_ < 0) then Postion_ := BEGIN_ - DistanceExt;

      if (BEGIN_ < 0) and (END_ < 0) and (BEGIN_ <= END_) then Postion_ := BEGIN_ + DistanceExt;
      if (BEGIN_ < 0) and (END_ < 0) and (BEGIN_ >= END_) then Postion_ := BEGIN_ - DistanceExt;
  //end
  //else
  //  begin
  //    Postion_ := 0;
  //  end;
end;

Function TForm1.PositionToPersen_(BEGIN_: Extended; END_: Extended; PositionExt: Extended) : Extended;
var
  dt1 : Extended;
  dt2 : Extended;

begin
      dt1:=Distance_(BEGIN_,END_);
      dt2:=Distance_(BEGIN_,PositionExt);
      PositionToPersen_ := dt2/dt1*100;
end;

Function TForm1.PersenToPosition_(BEGIN_: Extended; END_: Extended; PersenExt: Extended) : Extended;
var
  dt1 : Extended;

begin
  dt1:=Distance_(BEGIN_,END_)/100;
  dt1:=dt1*PersenExt;
  PersenToPosition_:=Postion_(BEGIN_,END_,dt1);
end;

Function TForm1.PersenToDistance_(BEGIN_: Extended; END_: Extended; PersenExt: Extended) : Extended;
var
  dt1 : Extended;

begin
  dt1:=Distance_(BEGIN_,END_)/100;
  PersenToDistance_:=dt1*PersenExt;
end;

Function TForm1.Min_(Valve1_: Extended; Valve2_: Extended) : Extended;
begin
  if Valve1_ >= Valve2_ then
    Min_ := Valve2_
  else
    Min_ := Valve1_;
end;

Function TForm1.Max_(Valve1_: Extended; Valve2_: Extended) : Extended;
begin
  if Valve1_ >= Valve2_ then
    Max_ := Valve1_
  else
    Max_ := Valve2_;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  bmp: TBGRABitmap;
  x : Extended;
  y : Extended;
  x1 : Extended;
  y1 : Extended;
  t : Extended;
  //c: TBGRAPixel;
  i : integer;
  i2 : Extended;
  Orgx: Extended;
  Orgy: Extended;
  s : String;
  F : Double;
begin

  Orgx := 48/2;
  Orgy := 48/2;

  bmp := TBGRABitmap.Create(48,48, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;
  bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
  bmp.Canvas2D.fillStyle(BGRA(60,60,255,255));
  bmp.Canvas2D.fillRect(0,0,48,48);

  for i := 0 to 15 do
  begin
    t := Po2[i];
    x := (17*cos(t)) - (0*sin(t))+Orgx;
    y := (17*sin(t)) + (0*cos(t))+Orgy;
    x1 := (22*cos(t)) - (0*sin(t))+Orgx;
    y1 := (22*sin(t)) + (0*cos(t))+Orgy;
    bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,255,255,255),1);
  end;

  bmp.EllipseAntialias(Orgx,Orgy,23,23,BGRA(255,255,255,255),1);
  bmp.EllipseAntialias(Orgx,Orgy,16,16,BGRA(0,0,0,255),1);
  //Button1.Caption:=FloatToStr(ScrollBar1.Position) ;
  t := Po2[6] + ((ScrollBar1.Position*(-1))*(pi/32));
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
    i2 := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text))*(0.25);
    ////Label17.Caption:= FloatToStr(i2) + Edit2.Text;
    i2 := (i2)/(ScrollBar1.Min*(-1));
    ////Label17.Caption:= FloatToStr(i2) + Edit2.Text;
    //if StrToFloat(Edit1.Text) < StrToFloat(Edit4.Text) then
    //i2 := StrToFloat(Edit1.Text)+(i2*((ScrollBar1.Position+48) * (-1)))
    //else
    //i2 := StrToFloat(Edit4.Text)+(i2*(ScrollBar1.Position * (-1)));
    i2 := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(i2*abs(ScrollBar1.Position )));
    s:=FloatToStr(i2);
    if length(s) > 3 then
      s:=FormatFloat('####0.000',i2)
    else
      s:=FormatFloat('0.0',i2);
    if StrToFloat(s) = 0 then s := '0';

    Zero_ := StrToFloat(s);
    Label17.Caption:= s + Edit2.Text;
    //Label17.Caption:= FloatToStr((ScrollBar1.Position*(-1))*(100/48)) + Edit2.Text;
  end;
  x := (-6*cos(t)) - (0*sin(t))+Orgx;
  y := (-6*sin(t)) + (0*cos(t))+Orgy;
  x1 := (14*cos(t)) - (0*sin(t))+Orgx;
  y1 := (14*sin(t)) + (0*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,155,255),2);
  x := (-4*cos(t)) - (1*sin(t))+Orgx;
  y := (-4*sin(t)) + (1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  x := (-4*cos(t)) - (-1*sin(t))+Orgx;
  y := (-4*sin(t)) + (-1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (-1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (-1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  bmp.Draw(Image1.Canvas,0,0);
  Image1.Refresh;
  bmp.Free;


  //bmp := TBGRABitmap.Create(208,208, ColorToBGRA(ColorToRGB(clBtnFace)));
  //bmp.Canvas2D.stroke();
  //bmp.Canvas2D.lineWidth:=1;
  //bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
  //bmp.Canvas2D.fillStyle(BGRA(200,200,200,255));
  ////bmp.Canvas2D.fillRect(0,0,208,208);
  ////StringToBarcodeToTBitmap.Canvas.TextOut(StrToInt(FloatToStr((StringToBarcodeToTBitmap.Width-Sum_)/2))-StrToInt(FloatToStr((StringToBarcodeToTBitmap.Canvas.TextExtent(Text_).cx-Sum_2)/2)) ,StringToBarcodeToTBitmap.Canvas.Height-StringToBarcodeToTBitmap.Canvas.TextExtent(Text_).cy,Text_);
  //bmp.Canvas.Font.Size:=7;
  ////bmp.Canvas.TextOut(0,0,'123');
  //
  //bmp.FontHeight := 7;
  //Orgx := bmp.Canvas.TextExtent(Edit4.Text).cx;
  //Orgx := bmp.TextSize(Edit1.Text).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/2)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/2)).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/4)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit1.Text)/4)).cx;
  //if  Orgx < bmp.TextSize(Edit4.Text).cx then Orgx := bmp.TextSize(Edit4.Text).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/2)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/2)).cx;
  //if  Orgx < bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/4)).cx then Orgx := bmp.TextSize(FloatToStr(StrToFloat(Edit4.Text)/4)).cx;
  //Orgx := Orgx+4;
  //Orgy := bmp.TextSize(Edit1.Text).cy;
  //if  bmp.TextSize(Edit1.Text).cy < bmp.TextSize(Edit4.Text).cy then Orgy := bmp.TextSize(Edit4.Text).cy;
  //x := Orgx-(bmp.TextSize(Edit2.Text).cx/2);
  //if x <= 0 then x:= 0;
  //bmp.TextOut(x,0,Edit2.Text,ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),dt_);
  //bmp.TextOut(0,10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_/2)+(dt_/4));
  //bmp.TextOut(0,((208-Orgy-10-4)/4)+10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_/2));
  //bmp.TextOut(0,((208-Orgy-10-4)/2)+10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_/4));
  //bmp.TextOut(0,((208-Orgy-10-4)/2)+((208-Orgy-10-4)/4)+10-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt_ := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),(dt_-dt_));
  //bmp.TextOut(0,200-(Orgy/2),FloatToStr(dt_),ColorToBGRA(ColorToRGB(clInfoText)));
  //
  ////bmp.Canvas.Colors[0,0] := bmp.Canvas.Colors[0,100];
  //bmp.DrawPolyLineAntialias([PointF(Orgx,10), PointF(Orgx,208-Orgy-4), PointF(190,208-Orgy-4)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,10), PointF(Orgx-3,10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,((208-Orgy-10-4)/4)+10), PointF(Orgx-3,((208-Orgy-10-4)/4)+10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,((208-Orgy-10-4)/2)+10), PointF(Orgx-3,((208-Orgy-10-4)/2)+10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,((208-Orgy-10-4)/2)+((208-Orgy-10-4)/4)+10), PointF(Orgx-3,((208-Orgy-10-4)/2)+((208-Orgy-10-4)/4)+10)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,208-Orgy-4), PointF(Orgx-3,208-Orgy-4)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,208-Orgy-4), PointF(Orgx,208-Orgy-1)],BGRA(0,0,0,255),1);
  //bmp.DrawPolyLineAntialias([PointF(190,208-Orgy-4), PointF(190,208-Orgy-1)],BGRA(0,0,0,255),1);
  //
  //bmp.TextOut(x,0,Edit2.Text,ColorToBGRA(ColorToRGB(clInfoText)));
  //bmp.TextOut(Orgx,208-(Orgy),'0',ColorToBGRA(ColorToRGB(clInfoText)));
  //bmp.TextOut(190-(bmp.TextSize('1').cx/2),208-(Orgy),'1',ColorToBGRA(ColorToRGB(clInfoText)));
  //bmp.TextOut(190+4,208-(Orgy)-4-(bmp.TextSize('T').cy/2),'T',ColorToBGRA(ColorToRGB(clInfoText)));
  //
  //dt_ := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
  //dt2_ := PositionToPersen_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Zero_);
  ////button1.Caption:=FloatToStr(dt2_);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,(208-Orgy-4)-((208-Orgy-4-10)/(10)*dt2_/10)), PointF(190,(208-Orgy-4)-((208-Orgy-4-10)/(10)*dt2_/10))],BGRA(0,0,255,255),1);
  //bmp.DrawPolyLineAntialias([PointF(Orgx,(208-Orgy-4)-((208-Orgy-4-10)/(10)*0/10)), PointF(190,(208-Orgy-4)-((208-Orgy-4-10)/(10)*0/10))],BGRA(0,2550,0,255),1);
  ////Edit3.Text:=FloatToStr(Zero_) + ' ' + FloatToStr(StrToFloat(Edit1.Text)-StrToFloat(Edit4.Text));
  //bmp.Draw(Image5.Canvas,0,0);
  //Image5.Refresh;
  //bmp.Free;

  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
  if (Chart2.LeftAxis.Range.Max <> StrToFloat(Edit1.Text)) or (Chart2.LeftAxis.Range.Min <> StrToFloat(Edit4.Text)) then
  begin
    lcsDerivative.Clear;
    lcsDerivative.Add(0,1);
    lcsDerivative.Add(1,1);
    Chart2.LeftAxis.Range.UseMax:=True;
    Chart2.LeftAxis.Range.UseMin:=True;
    Chart2.LeftAxis.Range.Max:=StrToFloat(Edit1.Text);
    Chart2.LeftAxis.Range.Min:=StrToFloat(Edit4.Text);
    Chart2.BottomAxis.Range.UseMax:=True;
    Chart2.BottomAxis.Range.UseMin:=True;
    Chart2.BottomAxis.Range.Max:=1;
    Chart2.BottomAxis.Range.Min:=0;
  end;
  lcsDerivative.SetyValue(0,Zero_);
  lcsDerivative.SetyValue(1,Zero_);
  Chatr6Active
  end;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
var
  bmp: TBGRABitmap;
  x : Extended;
  y : Extended;
  x1 : Extended;
  y1 : Extended;
  t : Extended;
  //c: TBGRAPixel;
  i : integer;
  i2 : Extended;
  Orgx: Extended;
  Orgy: Extended;
  s : String;
  F : Double;

begin

  Orgx := 48/2;
  Orgy := 48/2;

  bmp := TBGRABitmap.Create(48,48, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;
  bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
  bmp.Canvas2D.fillStyle(BGRA(60,60,255,255));
  bmp.Canvas2D.fillRect(0,0,48,48);

  for i := 0 to 15 do
  begin
    t := Po2[i];
    x := (17*cos(t)) - (0*sin(t))+Orgx;
    y := (17*sin(t)) + (0*cos(t))+Orgy;
    x1 := (22*cos(t)) - (0*sin(t))+Orgx;
    y1 := (22*sin(t)) + (0*cos(t))+Orgy;
    bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,255,255,255),1);
  end;

  bmp.EllipseAntialias(Orgx,Orgy,23,23,BGRA(255,255,255,255),1);
  bmp.EllipseAntialias(Orgx,Orgy,16,16,BGRA(0,0,0,255),1);
  t := Po2[6] + ((ScrollBar2.Position*(-1))*(pi/32));
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
    i2 := 100;
    i2 := (i2)/(ScrollBar2.Min*(-1));
    i2 := (i2*(ScrollBar2.Position * (-1)));
    s:=FloatToStr(i2);
    s:=FormatFloat('####0',i2);

    Gain_ := StrToFloat(s);
    Label18.Caption:= s + '%';
  end;
  x := (-6*cos(t)) - (0*sin(t))+Orgx;
  y := (-6*sin(t)) + (0*cos(t))+Orgy;
  x1 := (14*cos(t)) - (0*sin(t))+Orgx;
  y1 := (14*sin(t)) + (0*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,155,255),2);
  x := (-4*cos(t)) - (1*sin(t))+Orgx;
  y := (-4*sin(t)) + (1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  x := (-4*cos(t)) - (-1*sin(t))+Orgx;
  y := (-4*sin(t)) + (-1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (-1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (-1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  bmp.Draw(Image2.Canvas,0,0);
  Image2.Refresh;
  bmp.Free;

  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
  if (Chart3.LeftAxis.Range.Max <> 100) or (Chart3.LeftAxis.Range.Min <> 0) then
  begin
  lcsDerivative1.Clear;
  lcsDerivative1.Add(0,0);
  lcsDerivative1.Add(1,0);
  Chart3.LeftAxis.Range.UseMax:=True;
  Chart3.LeftAxis.Range.UseMin:=True;
  Chart3.LeftAxis.Range.Max:=100;
  Chart3.LeftAxis.Range.Min:=0;
  Chart3.BottomAxis.Range.UseMax:=True;
  Chart3.BottomAxis.Range.UseMin:=True;
  Chart3.BottomAxis.Range.Max:=1;
  Chart3.BottomAxis.Range.Min:=0;
  end;
  lcsDerivative1.SetyValue(0,Gain_);
  lcsDerivative1.SetyValue(1,Gain_);
  Chatr6Active
  end;
end;

procedure TForm1.ScrollBar3Change(Sender: TObject);
var
  bmp: TBGRABitmap;
  x : Extended;
  y : Extended;
  x1 : Extended;
  y1 : Extended;
  t : Extended;
  i : integer;
  i2 : Extended;
  Orgx: Extended;
  Orgy: Extended;
  s : String;
  F : Double;

begin

  Orgx := 48/2;
  Orgy := 48/2;

  bmp := TBGRABitmap.Create(48,48, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;
  bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
  bmp.Canvas2D.fillStyle(BGRA(60,60,255,255));
  bmp.Canvas2D.fillRect(0,0,48,48);

  for i := 0 to 15 do
  begin
    t := Po2[i];
    x := (17*cos(t)) - (0*sin(t))+Orgx;
    y := (17*sin(t)) + (0*cos(t))+Orgy;
    x1 := (22*cos(t)) - (0*sin(t))+Orgx;
    y1 := (22*sin(t)) + (0*cos(t))+Orgy;
    bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,255,255,255),1);
  end;

  bmp.EllipseAntialias(Orgx,Orgy,23,23,BGRA(255,255,255,255),1);
  bmp.EllipseAntialias(Orgx,Orgy,16,16,BGRA(0,0,0,255),1);
  t := Po2[6] + ((ScrollBar3.Position*(-1))*(pi/32));
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
    i2 := 2500;
    i2 := (i2)/(ScrollBar3.Min*(-1));
    i2 := (i2*(ScrollBar3.Position * (-1)));
    if i2 <= 0 then i2 := 1;
    s:=FloatToStr(i2);
    s:=FormatFloat('####0',i2);

    Ramp_up := StrToFloat(s);
    Label19.Caption:= s + 'ms';
  end;
  x := (-6*cos(t)) - (0*sin(t))+Orgx;
  y := (-6*sin(t)) + (0*cos(t))+Orgy;
  x1 := (14*cos(t)) - (0*sin(t))+Orgx;
  y1 := (14*sin(t)) + (0*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,155,255),2);
  x := (-4*cos(t)) - (1*sin(t))+Orgx;
  y := (-4*sin(t)) + (1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  x := (-4*cos(t)) - (-1*sin(t))+Orgx;
  y := (-4*sin(t)) + (-1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (-1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (-1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  bmp.Draw(Image3.Canvas,0,0);
  Image3.Refresh;
  bmp.Free;

  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
  if (Chart4.LeftAxis.Range.Max <> StrToFloat(Edit1.Text)) or (Chart4.LeftAxis.Range.Min <> StrToFloat(Edit4.Text))  or (Chart4.BottomAxis.Range.Max <> Ramp_up) then
  begin
    lcsDerivative2.Clear;
    lcsDerivative2.Add(0,StrToFloat(Edit4.Text));
    lcsDerivative2.Add(Ramp_up,StrToFloat(Edit1.Text));
    Chart4.LeftAxis.Range.UseMax:=True;
    Chart4.LeftAxis.Range.UseMin:=True;
    Chart4.LeftAxis.Range.Max:=StrToFloat(Edit1.Text);
    Chart4.LeftAxis.Range.Min:=StrToFloat(Edit4.Text);
    Chart4.BottomAxis.Range.UseMax:=True;
    Chart4.BottomAxis.Range.UseMin:=True;
    Chart4.BottomAxis.Range.Max:=Ramp_up;
    Chart4.BottomAxis.Range.Min:=0;
  end;
  lcsDerivative2.SetxValue(0,0);
  lcsDerivative2.SetxValue(1,Ramp_up);
  Chatr6Active
  end;
end;

procedure TForm1.ScrollBar4Change(Sender: TObject);
var
  bmp: TBGRABitmap;
  x : Extended;
  y : Extended;
  x1 : Extended;
  y1 : Extended;
  t : Extended;
  i : integer;
  i2 : Extended;
  Orgx: Extended;
  Orgy: Extended;
  s : String;
  F : Double;

begin

  Orgx := 48/2;
  Orgy := 48/2;

  bmp := TBGRABitmap.Create(48,48, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;
  bmp.Canvas2D.strokeStyle ('rgb(0,0,255)');
  bmp.Canvas2D.fillStyle(BGRA(60,60,255,255));
  bmp.Canvas2D.fillRect(0,0,48,48);

  for i := 0 to 15 do
  begin
    t := Po2[i];
    x := (17*cos(t)) - (0*sin(t))+Orgx;
    y := (17*sin(t)) + (0*cos(t))+Orgy;
    x1 := (22*cos(t)) - (0*sin(t))+Orgx;
    y1 := (22*sin(t)) + (0*cos(t))+Orgy;
    bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,255,255,255),1);
  end;

  bmp.EllipseAntialias(Orgx,Orgy,23,23,BGRA(255,255,255,255),1);
  bmp.EllipseAntialias(Orgx,Orgy,16,16,BGRA(0,0,0,255),1);
  t := Po2[6] + ((ScrollBar4.Position*(-1))*(pi/32));
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
    i2 := 2500;
    i2 := (i2)/(ScrollBar4.Min*(-1));
    i2 := (i2*(ScrollBar4.Position * (-1)));
    if i2 <= 0 then i2 := 1;
    s:=FloatToStr(i2);
    s:=FormatFloat('####0',i2);

    Ramp_Down := StrToFloat(s);
    Label20.Caption:= s + 'ms';
  end;
  x := (-6*cos(t)) - (0*sin(t))+Orgx;
  y := (-6*sin(t)) + (0*cos(t))+Orgy;
  x1 := (14*cos(t)) - (0*sin(t))+Orgx;
  y1 := (14*sin(t)) + (0*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,155,255),2);
  x := (-4*cos(t)) - (1*sin(t))+Orgx;
  y := (-4*sin(t)) + (1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  x := (-4*cos(t)) - (-1*sin(t))+Orgx;
  y := (-4*sin(t)) + (-1*cos(t))+Orgy;
  x1 := (11*cos(t)) - (-1*sin(t))+Orgx;
  y1 := (11*sin(t)) + (-1*cos(t))+Orgy;
  bmp.DrawPolyLineAntialias([PointF(x,y), PointF(x1,y1)],BGRA(0,0,205,155),1);
  bmp.Draw(Image4.Canvas,0,0);
  Image4.Refresh;
  bmp.Free;

  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
  if (Chart5.LeftAxis.Range.Max <> StrToFloat(Edit1.Text)) or (Chart5.LeftAxis.Range.Min <> StrToFloat(Edit4.Text))  or (Chart5.BottomAxis.Range.Max <> Ramp_Down) then
  begin
    lcsDerivative3.Clear;
    lcsDerivative3.Add(0,StrToFloat(Edit1.Text));
    lcsDerivative3.Add(Ramp_Down,StrToFloat(Edit4.Text));
    Chart5.LeftAxis.Range.UseMax:=True;
    Chart5.LeftAxis.Range.UseMin:=True;
    Chart5.LeftAxis.Range.Max:=StrToFloat(Edit1.Text);
    Chart5.LeftAxis.Range.Min:=StrToFloat(Edit4.Text);
    Chart5.BottomAxis.Range.UseMax:=True;
    Chart5.BottomAxis.Range.UseMin:=True;
    Chart5.BottomAxis.Range.Max:=Ramp_Down;
    Chart5.BottomAxis.Range.Min:=0;
  end;
  lcsDerivative3.SetxValue(0,0);
  lcsDerivative3.SetxValue(1,Ramp_Down);
  Chatr6Active
  end;
end;

procedure TForm1.ScrollBar5Change(Sender: TObject);

var
  i : Extended;
  s : String;
  F : Double;
begin
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
    i := (Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text)))/(ScrollBar5.Max+10000);
    //button1.Caption:=FloatToStr(i*(ScrollBar5.Position+10000)) + ' ' + IntToStr((ScrollBar5.Position)) + ' ' + IntToStr((ScrollBar5.Max));
    i := Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),i*abs(ScrollBar5.Position));
    New_value := (Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text)))/(ScrollBar5.Max+10000)*abs(ScrollBar5.Position);
    s:=FormatFloat('####0.000',i);
    if StrToFloat(s) = StrToFloat(Edit4.Text) then s := FloatToStr(StrToFloat(Edit4.Text));
    if StrToFloat(s) = StrToFloat(Edit1.Text) then s := FloatToStr(StrToFloat(Edit1.Text));
    Edit3.Text := s + ' ' + Edit2.Text;
  //if (StrToFloat(Edit2.Text)=0) or (StrToFloat(Edit3.Text) = 0) or (StrToFloat(Edit1.Text) = 0) then
  //i:=0
  //else
  //i:=((StrToFloat(Edit1.Text) * StrToFloat(Edit2.Text)) / StrToFloat(Edit3.Text));
  //s:=FormatFloat('####0.000',i + StrToFloat(Edit4.Text));
  //if StrToFloat(s) = 0 then s := '0';
  //Edit5.Text := s + ' ' + Edit10.Text;//FloatToStr(i + StrToFloat(Edit4.Text)) + ' ' + Edit10.Text;
  //end
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i : Extended;
  F : Double;
  s : string;
  Pers: Extended;
  Dist: Extended;
begin
  application.ProcessMessages;
  New_TickCount := LCLIntf.GetTickCount;
  if (New_value <> Old_value) and TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) then
  begin
    //button1.Caption:=FloatToStr(Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text))/Ramp_down);
    if New_value < Old_value then
    begin
      i := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text))/Ramp_down;
      ////if Old_value-i > Old_value then Old_value := Old_value+i+(((StrToFloat(Edit1.Text)-StrToFloat(Edit4.Text))/2500)*(New_TickCount - Old_TickCount));
      ////if Old_value-i < Old_value then Old_value := Old_value-i-(((StrToFloat(Edit1.Text)-StrToFloat(Edit4.Text))/2500)*(New_TickCount - Old_TickCount));
      //if Old_value-i > Old_value then Old_value := Old_value+(i*(New_TickCount - Old_TickCount));
      //if Old_value-i < Old_value then Old_value := Old_value-(i*(New_TickCount - Old_TickCount));
      //if (Old_value < New_value) and (New_value >= 0 ) then  Old_value := New_value;
      Old_value :=Old_value-(i*(New_TickCount - Old_TickCount));
      if New_value > Old_value then Old_value := New_value;
    end;
    if New_value > Old_value then
    begin
      i := Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text))/Ramp_up;
      //if Old_value+i < Old_value then Old_value := Old_value-(i*(New_TickCount - Old_TickCount));
      //if Old_value+i > Old_value then Old_value := Old_value+(i*(New_TickCount - Old_TickCount));
      //if (Old_value > New_value) and (New_value >= 0 )  then  Old_value := New_value;
      //if (Old_value > New_value) and (New_value <= 0 )  then  Old_value := New_value;
      Old_value :=Old_value+(i*(New_TickCount - Old_TickCount));
      if New_value < Old_value then Old_value := New_value;
    end;
    //if abs(New_value - Old_value) < abs(i) then Old_value := New_value;
  end;
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) then
  begin
    //s:=FormatFloat('####0.000',Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Old_value) + ((Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Old_value)-Zero_)/100*Gain_) + Zero_);//+(New_value/100*Gain_) + Zero_);

    Pers:=PositionToPersen_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Zero_);
    Dist:=PersenToDistance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Pers);
    //button1.Caption:=FloatToStr(Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Old_value)) + ' ' + FloatToStr(Pers) + ' ' + FloatToStr(Dist);
    s:=FormatFloat('####0.000',Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Old_value+Dist+(Old_value/100*Gain_)));
    if StrToFloat(s) = StrToFloat(Edit4.Text) then s := FloatToStr(StrToFloat(Edit4.Text));
    if StrToFloat(s) = StrToFloat(Edit1.Text) then s := FloatToStr(StrToFloat(Edit1.Text));
    Edit5.Text := s + Edit2.Text;// + ' '+ floatToStr(((StrToFloat(Edit1.Text)-StrToFloat(Edit4.Text))/2500)*(New_TickCount - Old_TickCount)) + ' ' + FloatToStr(New_TickCount - Old_TickCount);
    //Edit5.Text := s + ' ' + FloatToStr(timer1.Interval) + ' ' + FloatToStr(Ramp_up) + Edit2.Text;
    //Edit5.Text:=FloatToStr(Old_value) + ' ' + FloatToStr(i);
  end;
  Old_TickCount := New_TickCount;
end;

procedure TForm1.Chatr6Active();
var
  F : Double;
  s : string;
  Pers: Extended;
  Dist: Extended;
  MaxDist: Extended;
begin
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
    MaxDist:=Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text));
    Pers:=PositionToPersen_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Zero_);
    Dist:=PersenToDistance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Pers);
    //button1.Caption:=FloatToStr(Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Old_value)) + ' ' + FloatToStr(Pers) + ' ' + FloatToStr(Dist);
    s:=FormatFloat('####0.000',Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),MaxDist+Dist+(MaxDist/100*Gain_)));

  lcsDerivative4.Clear;
  lcsDerivative4.Add(0,Zero_);
  lcsDerivative4.Add(Ramp_up,StrToFloat(s));
  lcsDerivative4.Add(Ramp_up+2000,StrToFloat(s));
  lcsDerivative4.Add(Ramp_up+2000+Ramp_Down,Zero_);
  Chart6.LeftAxis.Range.UseMax:=True;
  Chart6.LeftAxis.Range.UseMin:=True;
  Dist:=PersenToDistance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),20);
  s:=FormatFloat('####0.000',Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),MaxDist+Dist+(MaxDist/100*100)));
  if StrToFloat(s) >= 0 then
  begin
    Chart6.LeftAxis.Range.Max:=StrToFloat(s)*1.1;
    Chart6.LeftAxis.Range.Min:=Min_(StrToFloat(Edit1.Text),StrToFloat(Edit4.Text));
  end
  else
  begin
    Chart6.LeftAxis.Range.Max:=Max_(StrToFloat(Edit1.Text),StrToFloat(Edit4.Text));
    Chart6.LeftAxis.Range.Min:=StrToFloat(s)*1.1;
  end;
  Chart6.BottomAxis.Range.UseMax:=True;
  Chart6.BottomAxis.Range.UseMin:=True;
  if Ramp_up+2000+Ramp_Down < (2500+2000+2500)/1.7 then Chart6.BottomAxis.Range.Max:=Ramp_up+2000+Ramp_Down+500;
  if Ramp_up+2000+Ramp_Down >= (2500+2000+2500)/1.7 then Chart6.BottomAxis.Range.Max:=2500+2000+2500+200;
  Chart6.BottomAxis.Range.Min:=0;
  end;

  //Pers:=PositionToPersen_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Zero_);
  //  Dist:=PersenToDistance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Pers);
  //  //button1.Caption:=FloatToStr(Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Old_value)) + ' ' + FloatToStr(Pers) + ' ' + FloatToStr(Dist);
  //  s:=FormatFloat('####0.000',Postion_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text),Old_value+Dist+(Old_value/100*Gain_)));

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Simulate_New:=LCLIntf.GetTickCount;
  if Simulate <= 0 then Simulate_Po_Ne := False;
  if Simulate >= Ramp_up+2000+Ramp_Down then Simulate_Po_Ne := True;
  if Simulate_Po_Ne = False then Simulate := Simulate+1+(Simulate_New-Simulate_Old);
  if Simulate_Po_Ne = True then Simulate := 0;
  Simulate_Old:=Simulate_New;
  lcsDerivative5.SetyValue(0,Chart6.LeftAxis.Range.Min);
  lcsDerivative5.SetyValue(1,Chart6.LeftAxis.Range.Max);
  lcsDerivative5.SetxValue(0,Simulate);
  lcsDerivative5.SetxValue(1,Simulate);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Timer2.Enabled = True then
  begin
    Simulate := 0;
    lcsDerivative5.Clear;
    Simulate_Old:=0;
    Simulate_New:=0;
    Button1.Caption := 'Start Simulate';
  end;
  if Timer2.Enabled = False then
  begin
    Simulate := 0;
    lcsDerivative5.Clear;
    lcsDerivative5.Add(Simulate,Chart6.LeftAxis.Range.Min);
    lcsDerivative5.Add(Simulate,Chart6.LeftAxis.Range.Max);
    Simulate_Old:=LCLIntf.GetTickCount;
    Simulate_New:=LCLIntf.GetTickCount;
    Button1.Caption := 'Stop Simulate';
  end;
  Timer2.Enabled:= not Timer2.Enabled;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked = True then
  begin
    Ed1:= Edit1.Text;
    Edit1.Enabled:= False;
    Ed2:= Edit4.Text;
    Edit4.Enabled:= False;
    Edit1.Text:=FloatToStr(Distance_(StrToFloat(Edit4.Text),StrToFloat(Edit1.Text)));
    Edit4.Text:='0'
  end
  else
  begin
    Edit1.Text:= Ed1;
    Edit1.Enabled:= True;
    Edit4.Text:= Ed2;
    Edit4.Enabled:= True;
  end;
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
var
  F : Double;
begin
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
  ScrollBar1Change(Sender);
  ScrollBar2Change(Sender);
  Chatr6Active;
  ScrollBar5Change(Sender);
  end;
end;

procedure TForm1.Edit4EditingDone(Sender: TObject);
var
  F : Double;
begin
  if TryStrToFloat(Edit1.Text,F) and TryStrToFloat(Edit4.Text,F) Then
  begin
  ScrollBar1Change(Sender);
  ScrollBar2Change(Sender);
  Chatr6Active;
  ScrollBar5Change(Sender);
  end;
end;

end.

