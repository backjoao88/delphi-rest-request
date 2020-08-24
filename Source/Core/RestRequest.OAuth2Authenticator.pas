unit RestRequest.OAuth2Authenticator;

interface

uses
  REST.Authenticator.OAuth,
  RestRequest.Request,
  RestRequest.OAuth2Configuration,
  RestRequest.IOAuth2Configuration,
  RestRequest.Token;
type

  TOAuth2Authenticator = class
      FOAuth2Configuration: IOAuth2Configuration;
    public
      constructor Create(const AOAuth2Configuration: IOAuth2Configuration = nil);
      destructor Destroy; override;
      class function New(const AOAuth2Configuration: IOAuth2Configuration = nil): TOAuth2Authenticator;
      function Authorize(const ACode: string): TToken;
      function RefreshAccessToken(const ARefreshToken: string): TToken;
  end;

implementation

{ TAuthorizationService }

function TOAuth2Authenticator.Authorize(const ACode: string): TToken;
begin
  if ACode = '' then
  begin
    Exit;
  end;

  Result := TRequest<TToken>
    .New
    .BaseUrl(FOAuth2Configuration.GetAccessTokenEndpoint)
    .AddHeader('content-type', 'application/x-www-form-urlencoded')
    .AddQueryParam('code', ACode)
    .AddQueryParam('client_id', FOAuth2Configuration.GetClientId)
    .AddQueryParam('client_secret', FOAuth2Configuration.GetClientSecret)
    .AddQueryParam('redirect_uri', FOAuth2Configuration.GetRedirectionEndpoint)
    .AddQueryParam('grant_type', 'authorization_code')
    .Post
    .Content;
end;

constructor TOAuth2Authenticator.Create(
  const AOAuth2Configuration: IOAuth2Configuration);
begin
  FOAuth2Configuration := AOAuth2Configuration;
end;

destructor TOAuth2Authenticator.Destroy;
begin
  inherited;
end;

class function TOAuth2Authenticator.New(
  const AOAuth2Configuration: IOAuth2Configuration): TOAuth2Authenticator;
begin
  Result := TOAuth2Authenticator.Create(AOAuth2Configuration);
end;

function TOAuth2Authenticator.RefreshAccessToken(
  const ARefreshToken: string): TToken;
begin
  if ARefreshToken = '' then
  begin
    Exit;
  end;
  Result := TRequest<TToken>
    .New
    .AddQueryParam('grant_type', 'refresh_token')
    .AddQueryParam('client_id', FOAuth2Configuration.GetClientId)
    .AddQueryParam('client_secret', FOAuth2Configuration.GetClientSecret)
    .AddQueryParam('refresh_token', ARefreshToken)
    .Post
    .Content;
end;

end.

