unit RestRequest.OAuth2Configuration;

interface

uses
  REST.Utils,
  System.Generics.Collections,
  RestRequest.IOAuth2Configuration;
type

  TOAuth2Configuration = class(TInterfacedObject, IOAuth2Configuration)
  private
    FClientId: string;
    FClientSecret: string;
    FRedirectionEndpoint: string;
    FAuthorizationEndpoint: string;
    FAccessTokenEndpoint: string;
    FScope: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IOAuth2Configuration;
    function SetClientId(const AValue: string): IOAuth2Configuration;
    function SetClientSecret(const AValue: string): IOAuth2Configuration;
    function SetRedirectionEndpoint(const AValue: string): IOAuth2Configuration;
    function SetAuthorizationEndpoint(const AValue: string): IOAuth2Configuration;
    function SetScope(const AValue: string): IOAuth2Configuration;
    function SetAccessTokenEndpoint(const AValue: string): IOAuth2Configuration;
    function GetClientSecret: string;
    function GetRedirectionEndpoint: string;
    function GetAuthorizationEndpoint: string;
    function GetScope: string;
    function GetClientID: string;
    function GetAccessTokenEndpoint: string;
    function GetAuthUrl: string;
  end;

implementation

constructor TOAuth2Configuration.Create;
begin
  inherited;
end;

destructor TOAuth2Configuration.Destroy;
begin
  inherited;
end;

class function TOAuth2Configuration.New: IOAuth2Configuration;
begin
  Result := TOAuth2Configuration.Create;
end;

function TOAuth2Configuration.SetClientId(const AValue: string): IOAuth2Configuration;
begin
  if AValue <> FClientId then
  begin
    FClientId := AValue;
  end;
  Result:= Self;
end;

function TOAuth2Configuration.SetClientSecret(const AValue: string): IOAuth2Configuration;
begin
  Result:= Self;
  if AValue <> FClientSecret then
  begin
    FClientSecret := AValue;
  end;
end;

function TOAuth2Configuration.SetRedirectionEndpoint(const AValue: string): IOAuth2Configuration;
begin
  Result:= Self;
  if AValue <> FRedirectionEndpoint then
  begin
    FRedirectionEndpoint := AValue;
  end;
end;

function TOAuth2Configuration.SetAccessTokenEndpoint(
  const AValue: string): IOAuth2Configuration;
begin
  Result:= Self;
  if AValue <> FAccessTokenEndpoint then
  begin
    FAccessTokenEndpoint := AValue;
  end;
end;

function TOAuth2Configuration.SetAuthorizationEndpoint(const AValue: string): IOAuth2Configuration;
begin
  Result:= Self;
  if AValue <> FAuthorizationEndpoint then
  begin
    FAuthorizationEndpoint := AValue;
  end;
end;

function TOAuth2Configuration.SetScope(const AValue: string): IOAuth2Configuration;
begin
  Result:= Self;
  if AValue <> FScope then
  begin
    FScope := AValue;
  end;
end;

function TOAuth2Configuration.GetClientID: string;
begin
  Result := FClientId;
end;

function TOAuth2Configuration.GetClientSecret: string;
begin
  Result := FClientSecret;
end;

function TOAuth2Configuration.GetRedirectionEndpoint: string;
begin
  Result := FRedirectionEndpoint;
end;

function TOAuth2Configuration.GetAccessTokenEndpoint: string;
begin
  Result := FAccessTokenEndpoint;
end;

function TOAuth2Configuration.GetAuthorizationEndpoint: string;
begin
  Result := FAuthorizationEndpoint;
end;

function TOAuth2Configuration.GetScope: string;
begin
  Result := FScope;
end;

function TOAuth2Configuration.GetAuthUrl: string;
var AuthorizationEndpoint: string;
begin
  Result := AuthorizationEndpoint;
  Result := Result + '?response_type=' + URIEncode('code');
  if Self.GetClientId <> '' then
    Result := Result + '&client_id=' + URIEncode(Self.GetClientId);
  if Self.GetRedirectionEndpoint <> '' then
    Result := Result + '&redirect_uri=' + URIEncode(Self.GetRedirectionEndpoint);
  if Self.GetScope <> '' then
    Result := Result + '&scope=' + URIEncode(Self.GetScope);
end;

end.



