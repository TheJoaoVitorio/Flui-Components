unit FLUIButton;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Graphics, Vcl.StdCtrls,
  System.UITypes;

type
  TFLUIButton = class(TCustomControl)
  private
    FCaption: string;
    FOnClick: TNotifyEvent;
    procedure SetCaption(const Value: string);
  protected
    // Sobrescreva o m�todo Paint para desenhar o bot�o
    procedure Paint; override;
    // Outros m�todos protegidos que voc� possa precisar (ex: MouseDown, MouseUp)
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    // Construtor
    constructor Create(AOwner: TComponent); override;
    // Destrutor (se necess�rio)
    // destructor Destroy; override;
  published
    // Propriedades que aparecer�o no Object Inspector
    property Caption: string read FCaption write SetCaption;
    property Align;
    property Anchors;
    property Constraints;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick: TNotifyEvent read FOnClick write FOnClick; // Se quiser um evento OnClick padr�o

  end;

procedure Register; // Procedimento para registrar o componente

implementation

procedure Register;
begin
  RegisterComponents('FLUI', [TFLUIButton]); // 'FLUI' � a paleta onde o bot�o aparecer�
end;

{ TFLUIButton }

constructor TFLUIButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Inicialize valores padr�o aqui
  ControlStyle := ControlStyle + [csOpaque, csClickEvents, csCaptureMouse]; // Estilos importantes
  Width := 100; // Largura padr�o
  Height := 30; // Altura padr�o
  FCaption := Name; // Caption inicial igual ao nome do componente
  // Outras inicializa��es
  // Ex: Font.Color := clWindowText;
end;

procedure TFLUIButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  // L�gica para quando o bot�o � pressionado (ex: mudar a apar�ncia)
  Invalidate; // Redesenha o controle
end;

procedure TFLUIButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  // L�gica para quando o bot�o � solto
  // Se voc� quiser implementar o OnClick manualmente:
  // if (Button = mbLeft) and (FOnClick <> nil) and PtInRect(ClientRect, Point(X,Y)) then
  //   FOnClick(Self);
  Invalidate; // Redesenha o controle
end;

procedure TFLUIButton.Paint;
var
  Rect: TRect;
  TextFlags: Cardinal;
begin
  inherited; // � importante chamar o inherited Paint se voc� quiser que o Delphi lide com algumas coisas b�sicas.
             // Por�m, para controle total, voc� pode omitir e desenhar tudo do zero.

  // Preenche o fundo
  Canvas.Brush.Color := clBtnFace; // Cor de fundo padr�o do bot�o
  // Se voc� tiver uma propriedade para cor de fundo:
  // Canvas.Brush.Color := FCorDeFundo;
  Canvas.FillRect(ClientRect);

  // Desenha a borda (opcional)
  // Canvas.Pen.Color := clBlack;
  // Canvas.Rectangle(0, 0, Width -1, Height -1);


  // Desenha o Caption (texto)
  Canvas.Font.Assign(Self.Font); // Usa a fonte definida para o componente
  Canvas.Brush.Style := bsClear; // Para o texto n�o ter um fundo pr�prio

  Rect := ClientRect; // �rea para desenhar o texto

  // Centraliza o texto
  TextFlags := DT_CENTER or DT_VCENTER or DT_SINGLELINE;

  // Ajusta a cor do texto se o bot�o estiver desabilitado
  if not Enabled then
    Canvas.Font.Color := clGrayText
  else
    Canvas.Font.Color := Self.Font.Color; // Ou uma propriedade de cor de texto espec�fica

  DrawText(Canvas.Handle, PChar(FCaption), Length(FCaption), Rect, TextFlags);

  // Adicione aqui a l�gica para desenhar o estado pressionado, foco, etc.
  // Exemplo simples de estado pressionado (se voc� controlar via uma vari�vel FIsPressed):
  // if FIsPressed then
  // begin
  //   Canvas.Pen.Color := clGray;
  //   Canvas.FrameRect(ClientRect); // Desenha uma borda interna
  // end;

  // Se o controle tiver foco, voc� pode querer desenhar um ret�ngulo de foco
  // if Focused and (csDesigning in ComponentState) then // Exemplo para desenhar foco em design-time
  //   DrawFocusRect(Canvas.Handle, ClientRect);

end;

procedure TFLUIButton.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Invalidate; // Solicita o redesenho do controle para exibir o novo caption
    // Se voc� estiver usando csSetCaption no ControlStyle, o Delphi pode invalidar automaticamente.
  end;
end;

end.
