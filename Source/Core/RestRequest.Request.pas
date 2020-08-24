unit RestRequest.Request;

interface

uses
  RestRequest.IRequest,
  RestRequest.IResponse,
  RestRequest.Response,
  REST.Client,
  REST.Types,
  System.SysUtils,
  System.JSON,
  REST.Json,
  Data.DB,
  IPPeerClient,
  REST.Response.Adapter,
  System.Classes;

type TRequest<T: class, constructor> = class(TInterfacedObject, IRequest<T>)
  private
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;
    FHeaders: TStrings;
    FParams: TStrings;
    FToken: string;
    FResponse: IResponse<T>;
 public
    procedure DoAfterExecute(Sender: TCustomRESTRequest);
    function AcceptEncoding: string; overload;
    function AcceptEncoding(const AAcceptEncoding: string): IRequest<T>; overload;
    function AcceptCharset: string; overload;
    function AcceptCharset(const AAcceptCharset: string): IRequest<T>; overload;
    function Accept: string; overload;
    function Accept(const AAccept: string): IRequest<T>; overload;
    function BaseURL(const ABaseURL: string): IRequest<T>; overload;
    function BaseURL: string; overload;
    function Resource(const AResource: string): IRequest<T>; overload;
    function Resource: string; overload;
    function Token(const AToken: string): IRequest<T>;
    function Get: IResponse<T>;
    function Post: IResponse<T>;
    function Put: IResponse<T>;
    function Delete: IResponse<T>;
    function ClearBody: IRequest<T>;
    function AddBody(const AContent: T; const AContentType: TRESTContentType = ctAPPLICATION_JSON): IRequest<T>; overload;
    function AddHeader(const AName, AValue: string; const AOptions: TRESTRequestParameterOptions = []): IRequest<T>;
    function ClearParams: IRequest<T>;
    function AddParam(const AName, AValue: string; const AKind: TRESTRequestParameterKind = TRESTRequestParameterKind.pkGETorPOST): IRequest<T>;
    function AddQueryParam(const AName, AValue: string): IRequest<T>;
    constructor Create;
    class function New: TRequest<T>;
    destructor Destroy; override;
  end;

implementation

{ TRequest<T> }

constructor TRequest<T>.Create;
begin
  FRestRequest := TRESTRequest.Create(nil);
  FRestResponse := TRESTResponse.Create(nil);
  FRestClient := TRESTClient.Create(nil);
  FRestRequest.ResetToDefaults;
  FRestResponse.ResetToDefaults;
  FRestClient.ResetToDefaults;
  FParams := TStringList.Create;
  FHeaders := TStringList.Create;
  FResponse := TResponse<T>.Create(FRestResponse);
  FRestRequest.Client := FRESTClient;
  FRestRequest.Response := FRESTResponse;
  FRestRequest.OnAfterExecute := DoAfterExecute;
end;

destructor TRequest<T>.Destroy;
begin
  FreeAndNil(FParams);
  FreeAndNil(FHeaders);
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTResponse);
  inherited;
end;

class function TRequest<T>.New: TRequest<T>;
begin
  Result := TRequest<T>.Create;
end;

procedure TRequest<T>.DoAfterExecute(Sender: TCustomRESTRequest);
begin
  FResponse.SetRestResponse(Self.FRestResponse);
end;

function TRequest<T>.Accept(const AAccept: string): IRequest<T>;
begin
  Result := Self;
  FRESTRequest.Accept := 'application/json';
  if not AAccept.Trim.IsEmpty then
  begin
    FRESTRequest.Accept := AAccept;
  end;
end;

function TRequest<T>.Accept: string;
begin
  Result := FRestRequest.Accept;
end;

function TRequest<T>.AcceptCharset: string;
begin
  Result := FRestRequest.AcceptCharset;
end;

function TRequest<T>.AcceptCharset(const AAcceptCharset: string): IRequest<T>;
begin
  Result := Self;
  FRestRequest.AcceptCharset := 'UTF-8';
  if not AAcceptCharset.IsEmpty then
  begin
    FRestRequest.AcceptCharset := AAcceptCharset;
  end;
end;

function TRequest<T>.AcceptEncoding(const AAcceptEncoding: string): IRequest<T>;
begin
  Result := Self;
  FRestRequest.AcceptEncoding := AAcceptEncoding;
end;

function TRequest<T>.AcceptEncoding: string;
begin
  Result := FRestRequest.AcceptEncoding;
end;

function TRequest<T>.AddBody(const AContent: T;
  const AContentType: TRESTContentType): IRequest<T>;
begin
  if Assigned(AContent) then
  begin
    FRestRequest.Method := rmPOST;
    FRestRequest.Body.Add(TJson.ObjectToJsonString(AContent).Trim, AContentType);
  end;
  Result := Self;
end;

function TRequest<T>.AddHeader(const AName, AValue: string;
  const AOptions: TRESTRequestParameterOptions): IRequest<T>;
begin
  Result := Self;
  if (not AName.Trim.IsEmpty) and (not AValue.Trim.IsEmpty) then
  begin
    FRestRequest.Params.AddHeader(AName, AValue);
    FRestRequest.Params.ParameterByName(AName).Options := AOptions;
  end;
end;

function TRequest<T>.AddParam(const AName, AValue: string;
  const AKind: TRESTRequestParameterKind): IRequest<T>;
begin
  Result := Self;
  if (not AName.Trim.IsEmpty) and (not AValue.Trim.IsEmpty) then
  begin
    FParams.Add(AName);
    FRestRequest.AddParameter(AName, AValue);
  end;
end;

function TRequest<T>.BaseURL(const ABaseURL: string): IRequest<T>;
begin
  if not ABaseURL.Trim.IsEmpty then
  begin
    FRestClient.BaseURL := ABaseURL;
  end;
  Result := Self;
end;

function TRequest<T>.BaseURL: string;
begin
  Result := FRestClient.BaseURL;
end;

function TRequest<T>.ClearBody: IRequest<T>;
begin
  Result := Self;
  FRestRequest.ClearBody;
end;

function TRequest<T>.ClearParams: IRequest<T>;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Pred(FParams.Count) do
  begin
    FRESTRequest.Params.Delete(FRESTRequest.Params.ParameterByName(FParams[I]));
  end;
end;

function TRequest<T>.Delete: IResponse<T>;
begin
  Result := FResponse;
  FRESTRequest.Method := rmDELETE;
  FRESTRequest.Execute;
end;

function TRequest<T>.Get: IResponse<T>;
begin
  Result := FResponse;
  FRESTRequest.Method := rmGET;
  FRESTRequest.Execute;
end;

function TRequest<T>.Post: IResponse<T>;
begin
  Result := FResponse;
  FRESTRequest.Method := rmPOST;
  FRESTRequest.Execute;
end;

function TRequest<T>.Put: IResponse<T>;
begin
  Result := FResponse;
  FRESTRequest.Method := rmPUT;
  FRESTRequest.Execute;
end;

function TRequest<T>.Resource(const AResource: string): IRequest<T>;
begin
  Result := Self;
  if not AResource.Trim.IsEmpty then
  begin
    FRestRequest.Resource := AResource;
  end;
end;

function TRequest<T>.Resource: string;
begin
  Result := FRestRequest.Resource;
end;

function TRequest<T>.Token(const AToken: string): IRequest<T>;
begin
  Result := Self;
  if not AToken.Trim.IsEmpty then
  begin
    FToken := AToken;
    AddQueryParam('access_token', AToken);
  end;
end;

function TRequest<T>.AddQueryParam(const AName, AValue: string): IRequest<T>;
begin
  Result := Self;
  if not FRestClient.BaseURL.Contains('?') then
  begin
  FRestClient.BaseURL :=
    FRestRequest.GetFullRequestURL(True) +
    '?' +
    AName+
    '=' +
    AValue;
  end
  else
  begin
  FRestClient.BaseURL :=
    FRestRequest.GetFullRequestURL(True) +
    '&' +
    AName+
    '=' +
    AValue;
  end;
end;

end.
