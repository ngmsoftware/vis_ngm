unit ngmunit;

{$R vis_ngm2.res}

interface

uses
  Windows,messages;

const
  NgM_SIGNATURE =$101;
  name : pchar = 'NgMPlugin'#0;

type
// boneco --------------------------------------------
  boneco = object
    cabeca : integer;
    tronco : tpoint;
    pescoco : tpoint;

    braco1_t : integer;
    braco1_a : real;
    braco2_t : integer;
    braco2_a : real;

    mao1_t : integer;
    mao1_a : real;
    mao2_t : integer;
    mao2_a : real;

    perna1_a : real;
    perna1_t : integer;
    perna2_a : real;
    perna2_t : integer;

    pe1_t : integer;
    pe1_a : real;
    pe2_t : integer;
    pe2_a : real;

    Cx,Cy : integer;

    wnd : hwnd;
  procedure init;
  procedure desenha(dc : hdc);
  procedure constroi(int1, int2, int3, int4 : integer);
end;
// boneco --------------------------------------------


  PNgMHeader =^TNgMHeader;
  PNgMModule =^TNgMModule;
  TNgMHeader =record
    Versao     :integer;
    Descricao  :PChar;
    GetModule   : function(I :integer) :PNgMModule; cdecl;

  end;
  TNgMModule =record
    Descrition   :PChar;   {description of module}
    hWNDParent   :HWND;    {parent window (filled in by WinAMP)}
    hDLLInstance :HINST;   {instance handle to this DLL (filled in by WinAMP)}
    sRate        :integer; {sample rate (filled in by WinAMP)}
    nCh          :integer; {number of channels (filled in by WinAMP)}
    LatencyMs    :integer; {latency from call of RenderFrame to actual drawing}
                           {(WinAMP looks at this value when getting data)}
    DelayMs      :integer; {delay between calls in milliSeconds}
    SpectrumNch  :integer; {number of channels for FFT data}
    WaveformNch  :integer; {number of channels for PCM data}
{The data is filled in according to the respective Nch entry}
    SpectrumData :array[0..1,0..575] of byte;  {0=Left;1=Right}
    WaveformData :array[0..1,0..575] of shortint;  {0=Left;1=Right}
    Config       :procedure(_Mod :PNgMModule); cdecl;
                 {configuration method}
    Init         :function(_Mod :PNgMModule) :integer; cdecl;
                 {Create window, etc.; 0=success}
    Render       :function(_Mod :PNgMModule) :integer; cdecl;
                 {1=Plug-in should end; 0=success}
    Quit         :procedure(_Mod :PNgMModule); cdecl;
                 {call when done}
    UserData     :pointer; {pointer to user data (optional)}
  end;

// -------------------------------------------------
function winampVisGetHeader : PNgMHeader; cdecl; export;
//--------------------------------------------------


function PegarModulo(I : integer) : PNgMModule; cdecl;

procedure configurar(_Mod :PNgMModule); cdecl;

function iniciar(_Mod :PNgMModule) :integer; cdecl;
                 {Create window, etc.; 0=success}
function AQUI(_Mod :PNgMModule) :integer; cdecl;
                 {1=Plug-in should end; 0=success}
procedure fim(_Mod :PNgMModule); cdecl;

//-----------------------------------------

function iniciar2(_Mod :PNgMModule) :integer; cdecl;

function AQUI2(_Mod :PNgMModule) :integer; cdecl;

procedure fim2(_Mod :PNgMModule); cdecl;

//-----------------------------------------

function iniciar3(_Mod :PNgMModule) :integer; cdecl;

function AQUI3(_Mod :PNgMModule) :integer; cdecl;

procedure fim3(_Mod :PNgMModule); cdecl;


//-----------------------------------------

function iniciar4(_Mod :PNgMModule) :integer; cdecl;

function AQUI4(_Mod :PNgMModule) :integer; cdecl;

procedure fim4(_Mod :PNgMModule); cdecl;



const
    HEADER : TNgMHeader = (
      Versao     : NgM_SIGNATURE;
      Descricao  : '< NgModule >';
      GetModule   :  PegarModulo; );

    Modulo1 :TNgMModule = (
            Descrition  :'Espec...';
            hWNDParent   :0; {filled in by WinAMP}
            hDLLInstance :0; {filled in by WinAMP}
            sRate        :0; {filled in by WinAMP}
            nCh          :0; {filled in by WinAMP}
            LatencyMs    :5;
            DelayMS      :5;
            SpectrumNch  :2;
            WaveformNch  :0;
            Config       :Configurar;
            Init         :Iniciar;
            Render       :AQUI;
            Quit         :fim;
            UserData     :nil);

    Modulo2 :TNgMModule = (
            Descrition  :'RAW...';
            hWNDParent   :0; {filled in by WinAMP}
            hDLLInstance :0; {filled in by WinAMP}
            sRate        :0; {filled in by WinAMP}
            nCh          :0; {filled in by WinAMP}
            LatencyMs    :15;
            DelayMS      :15;
            SpectrumNch  :0;
            WaveformNch  :2;
            Config       :Configurar;
            Init         :Iniciar2;
            Render       :AQUI2;
            Quit         :fim2;
            UserData     :nil);

    Modulo3 :TNgMModule = (
            Descrition  :'VU Meter...';
            hWNDParent   :0; {filled in by WinAMP}
            hDLLInstance :0; {filled in by WinAMP}
            sRate        :0; {filled in by WinAMP}
            nCh          :0; {filled in by WinAMP}
            LatencyMs    :25;
            DelayMS      :25;
            SpectrumNch  :0;
            WaveformNch  :2;
            Config       :Configurar;
            Init         :Iniciar3;
            Render       :AQUI3;
            Quit         :fim3;
            UserData     :nil);


    Modulo4 :TNgMModule = (
            Descrition  :'Dance Dance Dance ! ! !';
            hWNDParent   :0; {filled in by WinAMP}
            hDLLInstance :0; {filled in by WinAMP}
            sRate        :0; {filled in by WinAMP}
            nCh          :0; {filled in by WinAMP}
            LatencyMs    :50;
            DelayMS      :50;
            SpectrumNch  :0;
            WaveformNch  :2;
            Config       :Configurar;
            Init         :Iniciar4;
            Render       :AQUI4;
            Quit         :fim4;
            UserData     :nil);



var
  MainWnd1  : HWND;
  MainWnd2  : HWND;
  width, height,x,y :integer;
  pode : boolean;

  pen1 : hpen;
  pen2 : hpen;

  _hdc : hdc;
  hqualquer,htemp : hdc;
  memBM : HBITMAP;
  memBM2 : HBITMAP;

  SpectrumDataBAK :array[0..1,0..575] of byte;
  WaveBAK :array[0..1,0..575] of shortint;

  rgn : hrgn;

  bo1,bo2 : boneco;

  Wnd1 : hwnd;

  V1 : integer;

  btdn: boolean;
implementation

//boneco ---------------------------------------------

function deg(x : real) : real;
begin
  result:=pi*x/180;
end;

procedure boneco.init;
begin
    Cx:=100;
    Cy:=15;

    cabeca := 7;
    tronco.x := Cx;
    tronco.y := Cy+30;
    pescoco.x := Cx;
    pescoco.y := Cy+10;


    braco1_t := 15;
    braco1_a := 45.0;
    braco2_t := 15;
    braco2_a := 45.0;

    mao1_t := 15;
    mao1_a := 30.0;
    mao2_t := 15;
    mao2_a := 30.0;

    perna1_t := 15;
    perna1_a := 45.0;
    perna2_t := 15;
    perna2_a := 45.0;

    pe1_t := 15;
    pe1_a := 30.0;
    pe2_t := 15;
    pe2_a := 30.0;

end;

procedure boneco.desenha(dc : hdc);
var
  p : tpoint;
begin
  movetoex(dc,Cx,Cy,nil);
  lineto(dc,pescoco.x,pescoco.y);
  lineto(dc,tronco.x,tronco.y);

  p.x:=pescoco.x-round(braco1_t*sin(deg(braco1_a)));
  p.y:=pescoco.y+round(braco1_t*cos(deg(braco1_a)));
  movetoex(dc,pescoco.x,pescoco.y,nil);
  lineto(dc,p.x,p.y);
  p.x:=p.x-round(mao1_t*sin(deg(mao1_a)));
  p.y:=p.y+round(mao1_t*cos(deg(mao1_a)));
  lineto(dc,p.x,p.y);

  p.x:=pescoco.x+round(braco2_t*sin(deg(braco2_a)));
  p.y:=pescoco.y+round(braco2_t*cos(deg(braco2_a)));
  movetoex(dc,pescoco.x,pescoco.y,nil);
  lineto(dc,p.x,p.y);
  p.x:=p.x+round(mao2_t*sin(deg(mao2_a)));
  p.y:=p.y+round(mao2_t*cos(deg(mao2_a)));
  lineto(dc,p.x,p.y);

  p.x:=tronco.x-round(perna1_t*sin(deg(perna1_a)));
  p.y:=tronco.y+round(perna1_t*cos(deg(perna1_a)));
  movetoex(dc,tronco.x,tronco.y,nil);
  lineto(dc,p.x,p.y);
  p.x:=p.x-round(pe1_t*sin(deg(pe1_a)));
  p.y:=p.y+round(pe1_t*cos(deg(pe1_a)));
  lineto(dc,p.x,p.y);

  p.x:=tronco.x+round(perna2_t*sin(deg(perna2_a)));
  p.y:=tronco.y+round(perna2_t*cos(deg(perna2_a)));
  movetoex(dc,tronco.x,tronco.y,nil);
  lineto(dc,p.x,p.y);
  p.x:=p.x+round(pe2_t*sin(deg(pe2_a)));
  p.y:=p.y+round(pe2_t*cos(deg(pe2_a)));
  lineto(dc,p.x,p.y);

  ellipse(dc,Cx-cabeca,Cy-cabeca,Cx+cabeca,Cy+cabeca);

end;

procedure boneco.constroi(int1, int2, int3, int4 : integer);
begin
  pescoco.x := Cx;
  pescoco.y := Cy+10;

  tronco.x:=Cx+(int1+int2) div 2;
  tronco.y:=Cy+40+(int1+int2) div 4;

  braco1_a:=45.0 + int1*4;
  mao1_a:=mao1_a+int2;

  braco2_a:=45.0 + int3*4;
  mao2_a:=mao2_a+int4;

  perna1_a:=45.0 + int1;
  pe1_a:=30.0 + int2*4;

  perna2_a:=45.0 + int3;
  pe2_a:=30.0 + int4*4;
end;

//boneco ---------------------------------------------






function winampVisGetHeader :PNgMHeader;
begin
  Result := @HEADER;
end;

function PegarModulo(I : integer) : PNgMModule;
begin
  case I of
    0 : Result := @Modulo1;
    1 : Result := @Modulo2;
    2 : Result := @Modulo3;
    3 : Result := @Modulo4;
   else Result := nil;
  end;

end;

procedure configurar(_Mod :PNgMModule);
const
{  s1 : string = 'Vis_NgM Plugin para WinAmp'#13#13;

  s2 : string = '-:[Criado por NinGueM]:-  (Inligent like an AMEBA...)'#13;
  s3 : string = '[Espectro | Dados | VU | Dance ]  versão 1.0ß²'#13;
  s4 : string = 'Este plug-ins está sugeuto a ±10¹³¹²²³ erros...'#13#13;

  s5 : string = 'Bugs e críticas: ninguem@summer.com.br'#13; }

  s1 : string = 'MgModule: WinAmp PlugIn'#13#13;

  s2 : string = '-[Created by NinGueM]-  (Inligent like an AMEBA...)'#13;
  s3 : string = '[Espec | RAW | VU Meter | Dance ]  version 1.0ß²'#13;
  s4 : string = 'this plug-ins may have ±10¹³¹²²³ errors... %-)'#13#13;

  s5 : string = 'Bugs: ninguem@summer.com.br'#13#13;

  s6 : string = 'Enjoy, it''s freeware %-)';

begin
messagebox(_Mod.hWNDParent,pchar(s1+s2+s3+s4+s5+s6),
'About NgModule...',MB_OK or MB_ICONINFORMATION);
end;

//-------------------------------------

procedure barra(dc : hdc; x : integer; y : integer; altura : integer);
var
  a : integer;
begin
  for a:=1 to altura do
    begin
      movetoex(dc,x,y-2*a,nil);
      lineto(dc,x+4,y-2*a);
    end;
end;

function WindowProc(Window: HWnd; Msg, WParam: Word;
  LParam: Longint): Longint; stdcall; export;
var
  x : word;
  rec : trect;
begin
  case Msg of
    WM_NCLBUTTONDOWN :
      begin
        V1:=V1+1;
        if V1>10 then V1:=10;
        WindowProc := DefWindowProc(Window, Msg, WParam, LParam);
      end;
    WM_NCRBUTTONDOWN :
      begin
        btdn:=true;
        V1:=V1-1;
        if V1<1 then V1:=1;
        WindowProc := DefWindowProc(Window, Msg, WParam, LParam);
      end;

    WM_NCRBUTTONUP : btdn:=false;

    WM_NCMOUSEMOVE:
      begin
        x := word(lParam);
        getwindowrect(window,rec);
        if ((window = bo1.wnd) and btdn) then bo1.Cx:=x-rec.left;
        if ((window = bo2.wnd) and btdn) then bo2.Cx:=x-rec.left;
      end;

    WM_NCHITTEST:
      Result:=HTCAPTION;
  else
     WindowProc := DefWindowProc(Window, Msg, WParam, LParam);
  end;
end;


function iniciar(_Mod :PNgMModule) :integer;
var
  wc1      :TWndClass;
  wcHandle1 ,a : integer;

begin
  pode:=true;

  width := 200;
  height := 85;

   wc1.style := 0;
   wc1.lpfnWndProc := @WindowProc;
   wc1.cbClsExtra := 0;
   wc1.cbWndExtra := 0;
   wc1.hInstance := _Mod^.hDllInstance;
   wc1.hIcon := 0;
   wc1.hCursor := 0;
   wc1.hbrBackground := getstockobject(LTGRAY_BRUSH);
   wc1.lpszMenuName := #0;
   wc1.lpszClassName := pchar(name);

  wcHandle1 := Windows.RegisterClass(wc1);
  if wcHandle1 = 0 then
  begin
    messagebox(0,'erro1','erro RegisterClass 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd1 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de cá !'),
              WS_POPUPWINDOW,
              100,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd1 = 0) then
  begin
    messagebox(0,'erro1c','erro CreateWnd 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd2 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de lá !'),
              WS_POPUPWINDOW,
              400,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd2 = 0) then
  begin
    messagebox(0,'erro2c','erro CreateWnd 2',MB_OK);
    Result:=1;
    exit;
  end;


  ShowWindow(MainWnd1,SW_SHOWNORMAL);
  ShowWindow(MainWnd2,SW_SHOWNORMAL);

  for a:=1 to 575 do
    begin
     spectrumDataBAK[0][a]:=0;
     spectrumDataBAK[1][a]:=0;
    end;
  V1:=3;


  _hdc := CreateCompatibleDC(GetDC(0));
  memBM := CreateCompatibleBitmap(GetDc(0),width,height);
  SelectObject(_hdc, memBM);

  memBM2:=loadbitmap(hInstance,pchar('HEHEHEE'));
  htemp := CreatecompatibleDC(GetDC(0));
  SelectObject(htemp, memBM2);

  pen1:=createpen(PS_SOLID,1,rgb(20,230,21));
  pen2:=createpen(PS_SOLID,1,rgb(20,240,210));

//  rectangle(_hdc,0,0,width,height);
  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  hqualquer:=getdc(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);

  hqualquer:=getdc(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


  Result := 0;
end;

function AQUI(_Mod :PNgMModule) : integer;
var
  a : integer;
begin
  if pode then
  begin

  pode:=false;


  if (getdc(mainwnd1)=0) then
  begin
    result:=1;
    exit;
  end;
  if (getdc(mainwnd2)=0) then
  begin
    result:=1;
    exit;
  end;


  for a:=0 to 200 do
    begin
      if (_mod^.spectrumData[0][a]>spectrumDataBAK[0][a]) then
        spectrumDataBAK[0][a]:=_mod^.spectrumData[0][a]
      else
        if (spectrumDataBAK[0][a]>V1) then
          spectrumDataBAK[0][a]:=spectrumDataBAK[0][a]-V1;

      if (_mod^.spectrumData[1][a]>spectrumDataBAK[1][a]) then
        spectrumDataBAK[1][a]:=_mod^.spectrumData[1][a]
      else
        if (spectrumDataBAK[1][a]>V1) then
          spectrumDataBAK[1][a]:=spectrumDataBAK[1][a]-V1;

    end;

//   Desenhos começão aqui!

//----------- Janela 1

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  selectobject(_hdc,pen1);
  for a:=2 to 36 do
    begin
      barra(_hdc,a*5,75,spectrumDataBAK[1][a*3] div 8);
    end;

  hqualquer := GetDC(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


//----------- Janela 2

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);



  selectobject(_hdc,pen2);
  for a:=2 to 36 do
    begin
      barra(_hdc,a*5,75,spectrumDataBAK[0][a*3] div 6);
    end;

  hqualquer := GetDC(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd2,hqualquer);


  pode:=true;

  result:=0;
  end;

  result := 0;
end;

procedure fim(_Mod :PNgMModule);
begin
  DeleteObject(pen1);
  DeleteObject(pen2);
  DeleteObject(memBM);
  DeleteObject(memBM2);
  DeleteDC(_hdc);
  DeleteDC(htemp);
  DestroyWindow(MainWnd1);    {delete our window}
  DestroyWindow(MainWnd2);    {delete our window}
  Windows.UnregisterClass(pchar(name),_Mod^.hDLLInstance);
end;

//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------

function iniciar2(_Mod :PNgMModule) :integer;
var
  wc1      :TWndClass;
  wcHandle1 ,a : integer;

begin
  pode:=true;

  width := 200;
  height := 85;

   wc1.style := 0;
   wc1.lpfnWndProc := @WindowProc;
   wc1.cbClsExtra := 0;
   wc1.cbWndExtra := 0;
   wc1.hInstance := _Mod^.hDllInstance;
   wc1.hIcon := 0;
   wc1.hCursor := 0;
   wc1.hbrBackground := getstockobject(LTGRAY_BRUSH);
   wc1.lpszMenuName := #0;
   wc1.lpszClassName := pchar(name);

  wcHandle1 := Windows.RegisterClass(wc1);
  if wcHandle1 = 0 then
  begin
    messagebox(0,'erro1','erro RegisterClass 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd1 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de cá !'),
              WS_POPUPWINDOW,
              100,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd1 = 0) then
  begin
    messagebox(0,'erro1c','erro CreateWnd 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd2 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de lá !'),
              WS_POPUPWINDOW,
              400,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd2 = 0) then
  begin
    messagebox(0,'erro2c','erro CreateWnd 2',MB_OK);
    Result:=1;
    exit;
  end;


  ShowWindow(MainWnd1,SW_SHOWNORMAL);
  ShowWindow(MainWnd2,SW_SHOWNORMAL);

  for a:=1 to 575 do
    begin
     wavebak[0][a]:=0;
     wavebak[1][a]:=0;
    end;


  _hdc := CreateCompatibleDC(GetDC(0));
  memBM := CreateCompatibleBitmap(GetDc(0),width,height);
  SelectObject(_hdc, memBM);

  memBM2:=loadbitmap(hInstance,pchar('HEHEHEW'));
  htemp := CreatecompatibleDC(GetDC(0));
  SelectObject(htemp, memBM2);


  pen1:=createpen(PS_SOLID,1,rgb(255,255,255));
  pen2:=createpen(PS_SOLID,1,rgb(0,250,250));

//  rectangle(_hdc,0,0,width,height);
  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  hqualquer:=getdc(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);

  hqualquer:=getdc(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


  Result := 0;
end;

function AQUI2(_Mod :PNgMModule) : integer;
var
  a : integer;
begin
  if pode then
  begin

  pode:=false;


  if (getdc(mainwnd1)=0) then
  begin
    result:=1;
    exit;
  end;
  if (getdc(mainwnd2)=0) then
  begin
    result:=1;
    exit;
  end;


//   Desenhos começão aqui!

//----------- Janela 1

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  selectobject(_hdc,pen1);
  movetoex(_hdc,6,45,nil);
  for a:=6 to 194 do
    begin
      lineto(_hdc,a,45-_mod.waveformdata[1][a*2] div 4);
    end;

  hqualquer := GetDC(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


//----------- Janela 2

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);



  selectobject(_hdc,pen2);
  movetoex(_hdc,6,45,nil);
  for a:=6 to 194 do
    begin
      lineto(_hdc,a,45-_mod.waveformdata[0][a*2] div 4);
    end;

  hqualquer := GetDC(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd2,hqualquer);


  pode:=true;

  result:=0;
  end;

  result := 0;
end;

procedure fim2(_Mod :PNgMModule);
begin
  DeleteObject(pen1);
  DeleteObject(pen2);
  DeleteObject(memBM);
  DeleteObject(memBM2);
  DeleteDC(_hdc);
  DeleteDC(htemp);
  DestroyWindow(MainWnd1);    {delete our window}
  DestroyWindow(MainWnd2);    {delete our window}
  Windows.UnregisterClass(pchar(name),_Mod^.hDLLInstance);
end;

//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------

procedure drawlinha(dc : hdc; xi,yi : integer; value : integer);
var
  nx,ny,nx2,ny2 : integer;
  ang : real;
begin
  ang:=(value/10000)*pi/2 - pi/4;
  nx:=round(50*sin(ang));
  ny:=-round(50*cos(ang));

  nx2:=round(22*sin(ang));
  ny2:=-round(22*cos(ang));



  movetoex(dc,xi+nx2,yi+ny2,nil);
  lineto(dc,xi+nx,yi+ny);

end;

function WindowProc2(Window: HWnd; Msg, WParam: Word;
  LParam: Longint): Longint; stdcall; export;
begin
  case Msg of
    wm_Create:
      begin
        Rgn:=CreateEllipticRgn(1, 1, 102, 102);
        SetWindowRgn(window, Rgn, false);
      end;
    WM_NCHITTEST:
      Result:=HTCAPTION;
  else
     WindowProc2 := DefWindowProc(Window, Msg, WParam, LParam);
  end;
end;


function iniciar3(_Mod :PNgMModule) :integer;
var
  wc1      :TWndClass;
  wcHandle1 ,a : integer;

begin
  pode:=true;

  width := 102;
  height := 102;

   wc1.style := 0;
   wc1.lpfnWndProc := @WindowProc2;
   wc1.cbClsExtra := 0;
   wc1.cbWndExtra := 0;
   wc1.hInstance := _Mod^.hDllInstance;
   wc1.hIcon := 0;
   wc1.hCursor := 0;
   wc1.hbrBackground := getstockobject(LTGRAY_BRUSH);
   wc1.lpszMenuName := #0;
   wc1.lpszClassName := pchar(name);

  wcHandle1 := Windows.RegisterClass(wc1);
  if wcHandle1 = 0 then
  begin
    messagebox(0,'erro1','erro RegisterClass 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd1 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de cá !'),
              WS_POPUPWINDOW,
              100,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd1 = 0) then
  begin
    messagebox(0,'erro1c','erro CreateWnd 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd2 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de lá !'),
              WS_POPUPWINDOW,
              400,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd2 = 0) then
  begin
    messagebox(0,'erro2c','erro CreateWnd 2',MB_OK);
    Result:=1;
    exit;
  end;


  ShowWindow(MainWnd1,SW_SHOWNORMAL);
  ShowWindow(MainWnd2,SW_SHOWNORMAL);


  _hdc := CreateCompatibleDC(GetDC(0));
  memBM := CreateCompatibleBitmap(GetDc(0),width,height);
  SelectObject(_hdc, memBM);

  memBM2:=loadbitmap(hInstance,pchar('HEHEHE2'));
  htemp := CreatecompatibleDC(GetDC(0));
  SelectObject(htemp, memBM2);


  pen1:=createpen(PS_SOLID,2,rgb(200,20,10));
  pen2:=createpen(PS_SOLID,2,rgb(200,240,10));

//  rectangle(_hdc,0,0,width,height);
  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  hqualquer:=getdc(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);

  hqualquer:=getdc(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


  Result := 0;
end;

function AQUI3(_Mod :PNgMModule) : integer;
var
  a : integer;
  vvalue : integer;
begin
  if pode then
  begin

  pode:=false;


  if (getdc(mainwnd1)=0) then
  begin
    result:=1;
    exit;
  end;
  if (getdc(mainwnd2)=0) then
  begin
    result:=1;
    exit;
  end;


//   Desenhos começão aqui!

//----------- Janela 1

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  selectobject(_hdc,pen1);

  vvalue:=0;
  for a:=0 to 200 do
    begin
      vvalue:=vvalue+abs(_mod.waveformdata[0][a*2]);
    end;

  drawlinha(_hdc,50,75,vvalue);

  hqualquer := GetDC(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


//----------- Janela 2

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);



  selectobject(_hdc,pen2);

  vvalue:=0;
  for a:=0 to 200 do
    begin
      vvalue:=vvalue+abs(_mod.waveformdata[1][a*2]);
    end;

  drawlinha(_hdc,50,75,vvalue);

  hqualquer := GetDC(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd2,hqualquer);


  pode:=true;

  result:=0;
  end;

  result := 0;
end;

procedure fim3(_Mod :PNgMModule);
begin
  DeleteObject(pen1);
  DeleteObject(pen2);
  DeleteObject(memBM);
  DeleteObject(memBM2);
  DeleteDC(_hdc);
  DeleteDC(htemp);
  DestroyWindow(MainWnd1);    {delete our window}
  DestroyWindow(MainWnd2);    {delete our window}
  Windows.UnregisterClass(pchar(name),_Mod^.hDLLInstance);
end;

//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------

function iniciar4(_Mod :PNgMModule) :integer;
var
  wc1      :TWndClass;
  wcHandle1,a : integer;

begin
  pode:=true;

  width := 200;
  height := 85;

   wc1.style := 0;
   wc1.lpfnWndProc := @WindowProc;
   wc1.cbClsExtra := 0;
   wc1.cbWndExtra := 0;
   wc1.hInstance := _Mod^.hDllInstance;
   wc1.hIcon := 0;
   wc1.hCursor := 0;
   wc1.hbrBackground := getstockobject(LTGRAY_BRUSH);
   wc1.lpszMenuName := #0;
   wc1.lpszClassName := pchar(name);

  wcHandle1 := Windows.RegisterClass(wc1);
  if wcHandle1 = 0 then
  begin
    messagebox(0,'erro1','erro RegisterClass 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd1 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de cá !'),
              WS_POPUPWINDOW,
              100,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd1 = 0) then
  begin
    messagebox(0,'erro1c','erro CreateWnd 1',MB_OK);
    Result:=1;
    exit;
  end;

  MainWnd2 := CreateWindowEx(
              WS_EX_TOOLWINDOW,
              pchar(name),
              pchar('Canal de lá !'),
              WS_POPUPWINDOW,
              400,10,
              width, height,
              _Mod^.hWNDParent,
              0,
              _Mod^.hDLLInstance,
              nil);
  if (MainWnd2 = 0) then
  begin
    messagebox(0,'erro2c','erro CreateWnd 2',MB_OK);
    Result:=1;
    exit;
  end;


  ShowWindow(MainWnd1,SW_SHOWNORMAL);
  ShowWindow(MainWnd2,SW_SHOWNORMAL);


  _hdc := CreateCompatibleDC(GetDC(0));
  memBM := CreateCompatibleBitmap(GetDc(0),width,height);
  SelectObject(_hdc, memBM);

  memBM2:=loadbitmap(hInstance,pchar('HEHEHEB'));
  htemp := CreatecompatibleDC(GetDC(0));
  SelectObject(htemp, memBM2);


  pen1:=createpen(PS_SOLID,2,rgb(200,20,10));
  pen2:=createpen(PS_SOLID,2,rgb(200,240,10));

//  rectangle(_hdc,0,0,width,height);
  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  hqualquer:=getdc(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);

  hqualquer:=getdc(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


  bo1.init;
  bo1.wnd := MainWnd1;
  bo2.init;
  bo2.wnd := MainWnd2;

  btdn:=false;

  Result := 0;
end;

function AQUI4(_Mod :PNgMModule) : integer;
var
  a : integer;
  vvalue : integer;
begin
  if pode then
  begin

  pode:=false;


  if (getdc(mainwnd1)=0) then
  begin
    result:=1;
    exit;
  end;
  if (getdc(mainwnd2)=0) then
  begin
    result:=1;
    exit;
  end;


//   Desenhos começão aqui!

//----------- Janela 1

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);

  selectobject(_hdc,pen1);


  bo1.Cx:=bo1.Cx+_mod.waveformdata[1][40] div 15;
  bo1.constroi(_mod.waveformdata[1][2] div 4,
   _mod.waveformdata[1][50] div 4, _mod.waveformdata[1][100] div 4,
   _mod.waveformdata[1][150] div 4);
  bo1.desenha(_hdc);

  if (bo1.Cx>230) then bo1.Cx:=-30;
  if (bo1.Cx<-30) then bo1.Cx:=230;


  hqualquer := GetDC(MainWnd1);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd1,hqualquer);


//----------- Janela 2

  BitBlt(_hdc,0,0,width,height,htemp,0,0,SRCCOPY);



  selectobject(_hdc,pen2);



  bo2.Cx:=bo2.Cx+_mod.waveformdata[0][20] div 15;
  bo2.constroi(_mod.waveformdata[0][10] div 4,
   _mod.waveformdata[0][40] div 4, _mod.waveformdata[0][130] div 4,
   _mod.waveformdata[0][110] div 4);
  bo2.desenha(_hdc);

  if (bo2.Cx>230) then bo2.Cx:=-30;
  if (bo2.Cx<-30) then bo2.Cx:=230;



  hqualquer := GetDC(MainWnd2);
  BitBlt(hqualquer,0,0,200,200,_hdc,0,0,SRCCOPY);
  ReleaseDC(MainWnd2,hqualquer);


  pode:=true;

  result:=0;
  end;

  result := 0;
end;

procedure fim4(_Mod :PNgMModule);
begin
  DeleteObject(pen1);
  DeleteObject(pen2);
  DeleteObject(memBM);
  DeleteObject(memBM2);
  DeleteDC(_hdc);
  DeleteDC(htemp);
  DestroyWindow(MainWnd1);    {delete our window}
  DestroyWindow(MainWnd2);    {delete our window}
  Windows.UnregisterClass(pchar(name),_Mod^.hDLLInstance);
end;

//-------------------------------------------------------------------

end.
