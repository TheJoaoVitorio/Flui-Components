unit FLUI.Button;

interface

uses
  FLUI.Classes,
  System.SysUtils, System.Classes, System.UITypes, System.Math,
  Winapi.Windows, Winapi.Messages,
  Vcl.Controls, Vcl.Graphics, Vcl.StdCtrls, Vcl.Themes,
  Winapi.GDIPOBJ, Winapi.GDIPAPI, Winapi.GDIPUTIL;

type
  TFLUIButtonRender = class;

  TFLUIButton = class(TCustomControl)
  private
    FRender: TFLUIButtonRender;
    FOnClick: TNotifyEvent;

    function GetCaption: string;
    procedure SetCaption(const Value: string);
    function GetContainedFontColor: TColor;
    procedure SetContainedFontColor(const Value: TColor);
    function GetDarkColor: TColor;
    procedure SetDarkColor(const Value: TColor);
    function GetDarkFontColor: TColor;
    procedure SetDarkFontColor(const Value: TColor);
    function GetLightColor: TColor;
    procedure SetLightColor(const Value: TColor);
    function GetLightFontColor: TColor;
    procedure SetLightFontColor(const Value: TColor);
    function GetHoverColor: TColor;
    procedure SetHoverColor(const Value: TColor);
    function GetPressedColor: TColor;
    procedure SetPressedColor(const Value: TColor);
    function GetBorderSettings: TFLUIBorderSettings;
    procedure SetBorderSettings(const Value: TFLUIBorderSettings);
    function GetButtonColorSettings: TFLUIButtonColorSettings;
    procedure SetButtonColorSettings(const Value: TFLUIButtonColorSettings);
    function GetImage: TFLUIImage;
    procedure SetImage(const Value: TFLUIImage);
    function GetJustifyContent: TFLUIJustifyContent;
    procedure SetJustifyContent(const Value: TFLUIJustifyContent);

  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Caption: string read GetCaption write SetCaption;
    property ButtonColor: TFLUIButtonColorSettings read GetButtonColorSettings write SetButtonColorSettings;
    property BorderSettings: TFLUIBorderSettings read GetBorderSettings write SetBorderSettings;
    property Image: TFLUIImage read GetImage write SetImage;
    property JustifyContent: TFLUIJustifyContent read GetJustifyContent write SetJustifyContent default jcfCenter;

    property ContainedFontColor: TColor read GetContainedFontColor write SetContainedFontColor default clHighlightText;
    property DarkColor: TColor read GetDarkColor write SetDarkColor default clBlack;
    property DarkFontColor: TColor read GetDarkFontColor write SetDarkFontColor default clWhite;
    property LightColor: TColor read GetLightColor write SetLightColor default clBtnFace;
    property LightFontColor: TColor read GetLightFontColor write SetLightFontColor default clBtnText;
    property HoverColor: TColor read GetHoverColor write SetHoverColor default clNone;
    property PressedColor: TColor read GetPressedColor write SetPressedColor default clNone;

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
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property Action;
    property HelpContext;
    property Hint;
    property ParentColor;
    property TabOrder;
    property TabStop default False;
  end;

  /// <summary>
  /// Handles the rendering and visual state management for TFLUIButton.
  /// Separates the visual logic from the component wrapper, following the pattern
  /// used in the StyledComponents library (e.g., TStyledButtonRender).
  /// </summary>
  TFLUIButtonRender = class(TObject)
  private
    FOwnerControl: TCustomControl;

    // Properties moved from TFLUIButton
    FCaption: string;
    FContainedFontColor: TColor;
    FDarkColor: TColor;
    FDarkFontColor: TColor;
    FLightColor: TColor;
    FLightFontColor: TColor;
    FHoverColor: TColor;
    FPressedColor: TColor;
    FBorderSettings: TFLUIBorderSettings;
    FButtonColorSettings: TFLUIButtonColorSettings;
    FImage: TFLUIImage;
    FJustifyContent: TFLUIJustifyContent;

    // State management
    FIsHovering: Boolean;
    FIsPressed: Boolean;

    procedure SettingsChanged(Sender: TObject);
    procedure Invalidate;

    // Helper drawing methods
    function CreateGPRoundedRectPath(ARect: TGPRectF; ARadius: Single): TGPGraphicsPath;
    function CreateGPRoundedRectBorderPath(AOuterRect: TGPRectF; AOuterRadius: Single; ABorderThickness: Single): TGPGraphicsPath;

  public
    constructor Create(AOwner: TCustomControl);
    destructor Destroy; override;

    procedure DrawButton(ACanvas: TCanvas);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseEnter;
    procedure MouseLeave;
    procedure EnabledChanged;

    // Property Setters
    procedure SetCaption(const Value: string);
    procedure SetContainedFontColor(const Value: TColor);
    procedure SetDarkColor(const Value: TColor);
    procedure SetDarkFontColor(const Value: TColor);
    procedure SetLightColor(const Value: TColor);
    procedure SetLightFontColor(const Value: TColor);
    procedure SetHoverColor(const Value: TColor);
    procedure SetPressedColor(const Value: TColor);
    procedure SetBorderSettings(const Value: TFLUIBorderSettings);
    procedure SetButtonColorSettings(const Value: TFLUIButtonColorSettings);
    procedure SetImage(const Value: TFLUIImage);
    procedure SetJustifyContent(const Value: TFLUIJustifyContent);

    // Property Getters
    property Caption: string read FCaption;
    property ContainedFontColor: TColor read FContainedFontColor;
    property DarkColor: TColor read FDarkColor;
    property DarkFontColor: TColor read FDarkFontColor;
    property LightColor: TColor read FLightColor;
    property LightFontColor: TColor read FLightFontColor;
    property HoverColor: TColor read FHoverColor;
    property PressedColor: TColor read FPressedColor;
    property BorderSettings: TFLUIBorderSettings read FBorderSettings;
    property ButtonColorSettings: TFLUIButtonColorSettings read FButtonColorSettings;
    property Image: TFLUIImage read FImage;
    property JustifyContent: TFLUIJustifyContent read FJustifyContent;

    property IsHovering: Boolean read FIsHovering;
    property IsPressed: Boolean read FIsPressed;
  end;

procedure Register;

implementation

function ColorToARGB(AColor: TColor; AAlpha: Byte = 255): ARGB;
var
  LColorRGB: TColor;
begin
  LColorRGB := ColorToRGB(AColor);
  Result := (DWORD(AAlpha) shl 24) or (GetRValue(LColorRGB) shl 16) or
    (GetGValue(LColorRGB) shl 8) or GetBValue(LColorRGB);
end;

function DarkenColor(AColor: TColor; APercent: Byte): TColor;
var
  R, G, B: Byte;
begin
  R := GetRValue(ColorToRGB(AColor));
  G := GetGValue(ColorToRGB(AColor));
  B := GetBValue(ColorToRGB(AColor));
  R := Max(0, R - MulDiv(R, APercent, 100));
  G := Max(0, G - MulDiv(G, APercent, 100));
  B := Max(0, B - MulDiv(B, APercent, 100));
  Result := TColor(RGB(R, G, B));
end;

function LightenColor(AColor: TColor; APercent: Byte): TColor;
var
  R, G, B: Byte;
begin
  R := GetRValue(ColorToRGB(AColor));
  G := GetGValue(ColorToRGB(AColor));
  B := GetBValue(ColorToRGB(AColor));
  R := Min(255, R + MulDiv(255 - R, APercent, 100));
  G := Min(255, G + MulDiv(255 - G, APercent, 100));
  B := Min(255, B + MulDiv(255 - B, APercent, 100));
  Result := TColor(RGB(R, G, B));
end;

{ TFLUIButtonRender }

constructor TFLUIButtonRender.Create(AOwner: TCustomControl);
begin
  inherited Create;
  FOwnerControl := AOwner;

  // Default values
  FCaption := FOwnerControl.Name;
  FContainedFontColor := clHighlightText;
  FDarkColor := clBlack;
  FDarkFontColor := clWhite;
  FLightColor := clBtnFace;
  FLightFontColor := clBtnText;
  FHoverColor := clNone;
  FPressedColor := clNone;
  FIsHovering := False;
  FIsPressed := False;
  FJustifyContent := jcfCenter;

  FBorderSettings := TFLUIBorderSettings.Create;
  FBorderSettings.OnChange := SettingsChanged;

  FButtonColorSettings := TFLUIButtonColorSettings.Create;
  FButtonColorSettings.OnChange := SettingsChanged;

  FImage := TFLUIImage.Create;
  FImage.OnChange := SettingsChanged;
end;

destructor TFLUIButtonRender.Destroy;
begin
  if Assigned(FBorderSettings) then
  begin
    FBorderSettings.OnChange := nil;
    FBorderSettings.Free;
  end;
  if Assigned(FButtonColorSettings) then
  begin
    FButtonColorSettings.OnChange := nil;
    FButtonColorSettings.Free;
  end;
  if Assigned(FImage) then
  begin
    FImage.OnChange := nil;
    FImage.Free;
  end;
  inherited Destroy;
end;

procedure TFLUIButtonRender.SettingsChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TFLUIButtonRender.Invalidate;
begin
  if Assigned(FOwnerControl) and not (csDestroying in FOwnerControl.ComponentState) then
    FOwnerControl.Invalidate;
end;

procedure TFLUIButtonRender.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetContainedFontColor(const Value: TColor);
begin
  if FContainedFontColor <> Value then
  begin
    FContainedFontColor := Value;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetDarkColor(const Value: TColor);
begin
  if FDarkColor <> Value then
  begin
    FDarkColor := Value;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetDarkFontColor(const Value: TColor);
begin
  if FDarkFontColor <> Value then
  begin
    FDarkFontColor := Value;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetLightColor(const Value: TColor);
begin
  if FLightColor <> Value then
  begin
    FLightColor := Value;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetLightFontColor(const Value: TColor);
begin
  if FLightFontColor <> Value then
  begin
    FLightFontColor := Value;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetHoverColor(const Value: TColor);
begin
  if FHoverColor <> Value then
  begin
    FHoverColor := Value;
    if FIsHovering then
      Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetPressedColor(const Value: TColor);
begin
  if FPressedColor <> Value then
  begin
    FPressedColor := Value;
    if FIsPressed then
      Invalidate;
  end;
end;

procedure TFLUIButtonRender.SetBorderSettings(const Value: TFLUIBorderSettings);
begin
  FBorderSettings.Assign(Value);
end;

procedure TFLUIButtonRender.SetButtonColorSettings(const Value: TFLUIButtonColorSettings);
begin
  FButtonColorSettings.Assign(Value);
end;

procedure TFLUIButtonRender.SetImage(const Value: TFLUIImage);
begin
  FImage.Assign(Value);
end;

procedure TFLUIButtonRender.SetJustifyContent(const Value: TFLUIJustifyContent);
begin
  if FJustifyContent <> Value then
  begin
    FJustifyContent := Value;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.MouseEnter;
begin
  if not (csDesigning in FOwnerControl.ComponentState) then
  begin
    FIsHovering := True;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.MouseLeave;
begin
  if not (csDesigning in FOwnerControl.ComponentState) then
  begin
    FIsHovering := False;
    if FIsPressed then
      FIsPressed := False;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.EnabledChanged;
begin
  Invalidate;
end;

procedure TFLUIButtonRender.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and FOwnerControl.Enabled and not (csDesigning in FOwnerControl.ComponentState) then
  begin
    FIsPressed := True;
    Invalidate;
  end;
end;

procedure TFLUIButtonRender.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FIsPressed then
  begin
    FIsPressed := False;
    Invalidate;
  end;
end;

function TFLUIButtonRender.CreateGPRoundedRectPath(ARect: TGPRectF; ARadius: Single): TGPGraphicsPath;
var
  LPath: TGPGraphicsPath;
  LRadiusEffective: Single;
  Diameter: Single;
begin
  LPath := TGPGraphicsPath.Create;
  LRadiusEffective := Max(0, ARadius);

  Diameter := LRadiusEffective * 2;
  if Diameter > ARect.Width then Diameter := ARect.Width;
  if Diameter > ARect.Height then Diameter := ARect.Height;

  if (ARect.Width <=0) or (ARect.Height <=0) then
  begin
    Result := LPath;
    Exit;
  end;

  LRadiusEffective := Diameter / 2;

  if (LRadiusEffective = 0) then
  begin
    LPath.AddRectangle(ARect);
  end
  else
  begin
    LPath.AddArc(ARect.X, ARect.Y, Diameter, Diameter, 180, 90);
    LPath.AddLine(ARect.X + LRadiusEffective, ARect.Y, ARect.X + ARect.Width - LRadiusEffective, ARect.Y);
    LPath.AddArc(ARect.X + ARect.Width - Diameter, ARect.Y, Diameter, Diameter, 270, 90);
    LPath.AddLine(ARect.X + ARect.Width, ARect.Y + LRadiusEffective, ARect.X + ARect.Width, ARect.Y + ARect.Height - LRadiusEffective);
    LPath.AddArc(ARect.X + ARect.Width - Diameter, ARect.Y + ARect.Height - Diameter, Diameter, Diameter, 0, 90);
    LPath.AddLine(ARect.X + ARect.Width - LRadiusEffective, ARect.Y + ARect.Height, ARect.X + LRadiusEffective, ARect.Y + ARect.Height);
    LPath.AddArc(ARect.X, ARect.Y + ARect.Height - Diameter, Diameter, Diameter, 90, 90);
    LPath.AddLine(ARect.X, ARect.Y + ARect.Height - LRadiusEffective, ARect.X, ARect.Y + LRadiusEffective);
    LPath.CloseFigure();
  end;
  Result := LPath;
end;

function TFLUIButtonRender.CreateGPRoundedRectBorderPath(AOuterRect: TGPRectF; AOuterRadius: Single; ABorderThickness: Single): TGPGraphicsPath;
var
  OuterPath, InnerPath: TGPGraphicsPath;
  InnerRect: TGPRectF;
  InnerRadius: Single;
begin
  Result := TGPGraphicsPath.Create(FillModeAlternate);

  if ABorderThickness <= 0 then Exit;

  OuterPath := CreateGPRoundedRectPath(AOuterRect, AOuterRadius);
  Result.AddPath(OuterPath, False);
  OuterPath.Free;

  InnerRect := AOuterRect;
  InnerRect.X := InnerRect.X + ABorderThickness;
  InnerRect.Y := InnerRect.Y + ABorderThickness;
  InnerRect.Width := InnerRect.Width - (2 * ABorderThickness);
  InnerRect.Height := InnerRect.Height - (2 * ABorderThickness);

  InnerRadius := Max(0, AOuterRadius - ABorderThickness);

  if (InnerRect.Width <= 0) or (InnerRect.Height <= 0) then Exit;

  InnerPath := CreateGPRoundedRectPath(InnerRect, InnerRadius);
  Result.AddPath(InnerPath, False);
  InnerPath.Free;
end;

procedure TFLUIButtonRender.DrawButton(ACanvas: TCanvas);
var
  LRectVCL: TRect;
  LGPGraphics: TGPGraphics;
  LGPRectClient: TGPRectF;
  LGPFillPath: TGPGraphicsPath;
  LGPBorderPath: TGPGraphicsPath;
  LGPBrush: TGPBrush;
  LGPPen: TGPPen;
  LCurrentFillColor, LCurrentBorderColorSolid, LCurrentTextColor: TColor;
  LCurrentFillGradientStart, LCurrentFillGradientEnd: TColor;
  LCurrentBorderGradientStart, LCurrentBorderGradientEnd: TColor;
  LCurrentBorderThickness: Integer;
  LCurrentBorderStyle: TPenStyle;
  LCurrentRadiusEffective: Single;
  LCurrentButtonType: TFLUIButtonType;
  LUseGradientFill, LUseGradientBorderEnabled: Boolean;
  TextFlags: Cardinal;
  PathDrawRect: TGPRectF;
  PathInset: Single;
begin
  LRectVCL := FOwnerControl.ClientRect;
  if (LRectVCL.Width <= 0) or (LRectVCL.Height <= 0) then Exit;

  LGPGraphics := TGPGraphics.Create(ACanvas.Handle);
  try
    LGPGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
    LGPGraphics.SetPixelOffsetMode(PixelOffsetModeHalf);
    ACanvas.Font.Assign(FOwnerControl.Font);

    LCurrentRadiusEffective := FBorderSettings.Radius;
    LCurrentBorderColorSolid := FBorderSettings.BorderColor;
    LCurrentBorderThickness := FBorderSettings.BorderThickness;
    LCurrentBorderStyle := FBorderSettings.BorderStyle;
    LUseGradientBorderEnabled := FBorderSettings.UseGradientBorder and FBorderSettings.Gradient.Enabled;
    if LUseGradientBorderEnabled then
    begin
      LCurrentBorderGradientStart := FBorderSettings.Gradient.StartColor;
      LCurrentBorderGradientEnd := FBorderSettings.Gradient.EndColor;
    end;

    LCurrentFillColor := FButtonColorSettings.FillColor;
    LUseGradientFill := (FButtonColorSettings.ButtonType = fbtGradient) and FButtonColorSettings.Gradient.Enabled;
    if LUseGradientFill then
    begin
      LCurrentFillGradientStart := FButtonColorSettings.Gradient.StartColor;
      LCurrentFillGradientEnd := FButtonColorSettings.Gradient.EndColor;
    end;
    LCurrentButtonType := FButtonColorSettings.ButtonType;
    LCurrentTextColor := FOwnerControl.Font.Color;

    if not FOwnerControl.Enabled then
    begin
      LCurrentFillColor := clBtnShadow;
      LCurrentTextColor := clGrayText;
      LCurrentBorderColorSolid := clDkGray;
      LUseGradientFill := False;
      LUseGradientBorderEnabled := False;
    end
    else
    begin
      case LCurrentButtonType of
        fbtContained: LCurrentTextColor := FContainedFontColor;
        fbtOutline:
          begin
            LCurrentFillColor := clNone;
            LUseGradientFill := False;
            LCurrentTextColor := LCurrentBorderColorSolid;
            if LUseGradientBorderEnabled then
               LCurrentTextColor := FBorderSettings.Gradient.StartColor;
            LCurrentBorderThickness := Max(1, LCurrentBorderThickness);
          end;
        fbtDark:
          begin
            LCurrentFillColor := FDarkColor;
            LCurrentTextColor := FDarkFontColor;
            if not LUseGradientBorderEnabled then LCurrentBorderColorSolid := FDarkColor;
            if LCurrentBorderThickness = 0 then LCurrentBorderThickness := 1;
            LUseGradientFill := False;
          end;
        fbtLight:
          begin
            LCurrentFillColor := FLightColor;
            LCurrentTextColor := FLightFontColor;
            if not LUseGradientBorderEnabled then LCurrentBorderColorSolid := FLightColor;
            if LCurrentBorderThickness = 0 then LCurrentBorderThickness := 1;
            LUseGradientFill := False;
          end;
        fbtGradient:
          begin
            LCurrentTextColor := FContainedFontColor;
          end;
      end;

      var TempFillColor: TColor := LCurrentFillColor;
      var TempBorderColorSolid: TColor := LCurrentBorderColorSolid;
      var TempFillGradientStart: TColor := LCurrentFillGradientStart;
      var TempFillGradientEnd: TColor := LCurrentFillGradientEnd;
      var TempBorderGradientStart: TColor := LCurrentBorderGradientStart;
      var TempBorderGradientEnd: TColor := LCurrentBorderGradientEnd;
      var TempUseGradientFill: Boolean := LUseGradientFill;
      var TempUseGradientBorder: Boolean := LUseGradientBorderEnabled;

      if FIsPressed and not (csDesigning in FOwnerControl.ComponentState) then
      begin
        if FPressedColor <> clNone then
        begin
          TempFillColor := FPressedColor;
          TempUseGradientFill := False;
        end
        else if TempUseGradientFill then
        begin
          TempFillGradientStart := DarkenColor(LCurrentFillGradientStart, 20);
          TempFillGradientEnd := DarkenColor(LCurrentFillGradientEnd, 20);
        end
        else if TempFillColor <> clNone then
          TempFillColor := DarkenColor(LCurrentFillColor, 20);

        if TempUseGradientBorder then
        begin
            TempBorderGradientStart := DarkenColor(LCurrentBorderGradientStart, 20);
            TempBorderGradientEnd := DarkenColor(LCurrentBorderGradientEnd, 20);
        end
        else
            TempBorderColorSolid := DarkenColor(LCurrentBorderColorSolid, 20);

        if LCurrentButtonType = fbtOutline then
            LCurrentTextColor := TempBorderColorSolid;
      end
      else if FIsHovering and not (csDesigning in FOwnerControl.ComponentState) then
      begin
        if FHoverColor <> clNone then
        begin
          TempFillColor := FHoverColor;
          TempUseGradientFill := False;
        end
        else if TempUseGradientFill then
        begin
          TempFillGradientStart := LightenColor(LCurrentFillGradientStart, 15);
          TempFillGradientEnd := LightenColor(LCurrentFillGradientEnd, 15);
        end
        else if TempFillColor <> clNone then
            TempFillColor := LightenColor(LCurrentFillColor, 15);

        if TempUseGradientBorder then
        begin
            TempBorderGradientStart := LightenColor(LCurrentBorderGradientStart, 15);
            TempBorderGradientEnd := LightenColor(LCurrentBorderGradientEnd, 15);
        end
        else
            TempBorderColorSolid := LightenColor(LCurrentBorderColorSolid, 15);

         if LCurrentButtonType = fbtOutline then
            LCurrentTextColor := TempBorderColorSolid;
      end;

      LCurrentFillColor := TempFillColor;
      LCurrentBorderColorSolid := TempBorderColorSolid;
      LCurrentFillGradientStart := TempFillGradientStart;
      LCurrentFillGradientEnd := TempFillGradientEnd;
      LCurrentBorderGradientStart := TempBorderGradientStart;
      LCurrentBorderGradientEnd := TempBorderGradientEnd;
      LUseGradientFill := TempUseGradientFill;
      LUseGradientBorderEnabled := TempUseGradientBorder;

      if (LCurrentButtonType = fbtOutline) and (FIsHovering or FIsPressed) and FOwnerControl.Enabled and not (csDesigning in FOwnerControl.ComponentState) then
      begin
        if LUseGradientBorderEnabled then
             LCurrentTextColor := LCurrentBorderGradientStart
        else
             LCurrentTextColor := LCurrentBorderColorSolid;
      end;
    end;

    LGPRectClient := MakeRect(LRectVCL.Left.ToSingle, LRectVCL.Top.ToSingle, LRectVCL.Width.ToSingle, LRectVCL.Height.ToSingle);

    if LCurrentBorderThickness > 0 then
      PathInset := LCurrentBorderThickness / 2.0
    else
      PathInset := 0.0;

    PathDrawRect := MakeRect(LGPRectClient.X + PathInset, LGPRectClient.Y + PathInset,
                           LGPRectClient.Width - 2 * PathInset, LGPRectClient.Height - 2 * PathInset);

    if PathDrawRect.Width < 0 then PathDrawRect.Width := 0;
    if PathDrawRect.Height < 0 then PathDrawRect.Height := 0;

    var RadiusForFillPath: Single;
    RadiusForFillPath := Max(0, LCurrentRadiusEffective - PathInset);

    LGPFillPath := CreateGPRoundedRectPath(PathDrawRect, RadiusForFillPath);
    try
      if LUseGradientFill and FOwnerControl.Enabled then
      begin
        if (PathDrawRect.Width > 0) and (PathDrawRect.Height > 0) then
        begin
          LGPBrush := TGPLinearGradientBrush.Create(
            MakePoint(PathDrawRect.X, PathDrawRect.Y),
            MakePoint(PathDrawRect.X, PathDrawRect.Y + PathDrawRect.Height),
            ColorToARGB(LCurrentFillGradientStart),
            ColorToARGB(LCurrentFillGradientEnd));
          try
            LGPGraphics.FillPath(LGPBrush, LGPFillPath);
          finally
            LGPBrush.Free;
          end;
        end;
      end
      else if LCurrentFillColor <> clNone then
      begin
        var FillAlpha: Byte := 255;
        if LCurrentButtonType = fbtOutline then FillAlpha := 0;

        LGPBrush := TGPSolidBrush.Create(ColorToARGB(LCurrentFillColor, FillAlpha));
        try
          LGPGraphics.FillPath(LGPBrush, LGPFillPath);
        finally
          LGPBrush.Free;
        end;
      end;
    finally
      LGPFillPath.Free;
    end;

    if LCurrentBorderThickness > 0 then
    begin
      if LUseGradientBorderEnabled and FOwnerControl.Enabled then
      begin
        LGPBorderPath := CreateGPRoundedRectBorderPath(LGPRectClient, LCurrentRadiusEffective, LCurrentBorderThickness);
        try
          if LGPBorderPath.GetPointCount > 0 then
          begin
            LGPBrush := TGPLinearGradientBrush.Create(
              MakePoint(LGPRectClient.X, LGPRectClient.Y),
              MakePoint(LGPRectClient.X, LGPRectClient.Y + LGPRectClient.Height),
              ColorToARGB(LCurrentBorderGradientStart),
              ColorToARGB(LCurrentBorderGradientEnd));
            try
              LGPGraphics.FillPath(LGPBrush, LGPBorderPath);
            finally
              LGPBrush.Free;
            end;
          end;
        finally
          LGPBorderPath.Free;
        end;
      end
      else if LCurrentBorderColorSolid <> clNone then
      begin
        LGPPen := TGPPen.Create(ColorToARGB(LCurrentBorderColorSolid), LCurrentBorderThickness.ToSingle);
        try
          case LCurrentBorderStyle of
            psDash: LGPPen.SetDashStyle(DashStyleDash);
            psDot: LGPPen.SetDashStyle(DashStyleDot);
            psDashDot: LGPPen.SetDashStyle(DashStyleDashDot);
            psDashDotDot: LGPPen.SetDashStyle(DashStyleDashDotDot);
          else
            LGPPen.SetDashStyle(DashStyleSolid);
          end;
          // Use the same LGPFillPath that was created for the background fill
          LGPGraphics.DrawPath(LGPPen, LGPFillPath);
        finally
          LGPPen.Free;
        end;
      end;
    end;

    var
      ContentRect, ImageRect, TextRect: TRect;
      ImageVisible: Boolean;
      CaptionToDraw: string;
      TextSize: TSize;
      ImageWidth, ImageHeight, Spacing, TotalContentWidth, FreeSpace, StartX, InterItemSpacing: Integer;

    CaptionToDraw := FCaption;
    ContentRect := LRectVCL;
    ImageVisible := Assigned(FImage) and FImage.Visible and Assigned(FImage.Picture.Graphic) and (FImage.Picture.Width > 0);

    // Get dimensions
    if ImageVisible then
    begin
      ImageWidth := FImage.Picture.Width;
      ImageHeight := FImage.Picture.Height;
      Spacing := FImage.Spacing;
      if FImage.Position = ipCenter then
      begin
        CaptionToDraw := '';
        Spacing := 0;
      end;
    end else
    begin
      ImageWidth := 0;
      ImageHeight := 0;
      Spacing := 0;
    end;

    if Length(CaptionToDraw) > 0 then
      GetTextExtentPoint32(ACanvas.Handle, PChar(CaptionToDraw), Length(CaptionToDraw), TextSize)
    else
      TextSize := TSize.Create(0,0);

    // --- Layout Calculation ---
    if FImage.Position in [ipTop, ipBottom] and ImageVisible then
    begin
      // Vertical Layout: JustifyContent applies to horizontal alignment of each item
      // Horizontally align image
      FreeSpace := ContentRect.Width - ImageWidth;
      case FJustifyContent of
        jcfFlexStart: StartX := ContentRect.Left;
        jcfCenter, jcfSpaceAround, jcfSpaceEvenly: StartX := ContentRect.Left + FreeSpace div 2;
        jcfFlexEnd, jcfSpaceBetween: StartX := ContentRect.Left + FreeSpace;
      end;
      if FImage.Position = ipTop then
        ImageRect := Rect(StartX, ContentRect.Top + Spacing, StartX + ImageWidth, ContentRect.Top + Spacing + ImageHeight)
      else
        ImageRect := Rect(StartX, ContentRect.Bottom - Spacing - ImageHeight, StartX + ImageWidth, ContentRect.Bottom - Spacing);

      // Horizontally align text
      FreeSpace := ContentRect.Width - TextSize.cx;
      case FJustifyContent of
        jcfFlexStart: StartX := ContentRect.Left;
        jcfCenter, jcfSpaceAround, jcfSpaceEvenly: StartX := ContentRect.Left + FreeSpace div 2;
        jcfFlexEnd, jcfSpaceBetween: StartX := ContentRect.Left + FreeSpace;
      end;
      if FImage.Position = ipTop then
        TextRect := Rect(StartX, ImageRect.Bottom + Spacing, StartX + TextSize.cx, ContentRect.Bottom)
      else
        TextRect := Rect(StartX, ContentRect.Top, StartX + TextSize.cx, ImageRect.Top - Spacing);
    end
    else
    begin
      // Horizontal Layout
      TotalContentWidth := ImageWidth + TextSize.cx;
      if ImageVisible and (Length(CaptionToDraw) > 0) then
        TotalContentWidth := TotalContentWidth + Spacing;

      FreeSpace := ContentRect.Width - TotalContentWidth;
      StartX := ContentRect.Left;
      InterItemSpacing := Spacing;

      case FJustifyContent of
        jcfFlexStart: StartX := ContentRect.Left;
        jcfCenter, jcfSpaceAround, jcfSpaceEvenly: StartX := ContentRect.Left + FreeSpace div 2;
        jcfFlexEnd: StartX := ContentRect.Left + FreeSpace;
        jcfSpaceBetween:
          begin
            StartX := ContentRect.Left;
            if ImageVisible and (Length(CaptionToDraw) > 0) then
              InterItemSpacing := Spacing + FreeSpace
            else
              InterItemSpacing := Spacing;
          end;
      end;

      var CurrentX := StartX;
      if FImage.Position = ipRight then
      begin // Text first
        TextRect := Rect(CurrentX, ContentRect.Top, CurrentX + TextSize.cx, ContentRect.Bottom);
        CurrentX := CurrentX + TextSize.cx + InterItemSpacing;
        ImageRect := Rect(CurrentX, ContentRect.Top + (ContentRect.Height - ImageHeight) div 2, 0, 0);
        ImageRect.Right := ImageRect.Left + ImageWidth;
        ImageRect.Bottom := ImageRect.Top + ImageHeight;
      end
      else // Image first (ipLeft, ipCenter, or no image)
      begin
        ImageRect := Rect(CurrentX, ContentRect.Top + (ContentRect.Height - ImageHeight) div 2, 0, 0);
        ImageRect.Right := ImageRect.Left + ImageWidth;
        ImageRect.Bottom := ImageRect.Top + ImageHeight;
        if ImageVisible then CurrentX := CurrentX + ImageWidth + InterItemSpacing;
        TextRect := Rect(CurrentX, ContentRect.Top, CurrentX + TextSize.cx, ContentRect.Bottom);
      end;
    end;

    // --- Drawing ---
    ACanvas.Brush.Style := bsClear;
    ACanvas.Font.Color := LCurrentTextColor;
    TextFlags := DT_VCENTER or DT_SINGLELINE or DT_NOCLIP;

    if ImageVisible then
      ACanvas.Draw(ImageRect.Left, ImageRect.Top, FImage.Picture.Graphic);

    if Length(CaptionToDraw) > 0 then
      DrawText(ACanvas.Handle, PChar(CaptionToDraw), -1, TextRect, TextFlags);

    if FOwnerControl.Focused and FOwnerControl.Enabled and not (csDesigning in FOwnerControl.ComponentState) then
    begin
      var FocusDrawRectVCL := LRectVCL;
      var FocusBorderInset: Integer;

      if LCurrentBorderThickness > 0 then
        FocusBorderInset := LCurrentBorderThickness + 1
      else if (LCurrentButtonType = fbtOutline) then
        FocusBorderInset := 1 + 1
      else
        FocusBorderInset := 2;

      InflateRect(FocusDrawRectVCL, -FocusBorderInset, -FocusBorderInset);

      if (FocusDrawRectVCL.Right > FocusDrawRectVCL.Left) and
         (FocusDrawRectVCL.Bottom > FocusDrawRectVCL.Top) then
      begin
        ACanvas.Pen.Color := clGrayText;
        ACanvas.Pen.Style := psDot;
        ACanvas.Pen.Width := 1;
        ACanvas.Brush.Style := bsClear;
        if LCurrentRadiusEffective > 0 then
        begin
          var FocusRadius: Integer;
          FocusRadius := Max(0, Round(LCurrentRadiusEffective) - FocusBorderInset);
          ACanvas.RoundRect(FocusDrawRectVCL.Left, FocusDrawRectVCL.Top,
                           FocusDrawRectVCL.Right, FocusDrawRectVCL.Bottom,
                           FocusRadius, FocusRadius);
        end
        else
          ACanvas.FrameRect(FocusDrawRectVCL);
      end;
    end;
  finally
    LGPGraphics.Free;
  end;
end;

procedure Register;
begin
  RegisterComponents('FLUI', [TFLUIButton]);
end;

initialization
finalization
end.
