unit RestRequest.Token;

interface

uses
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TToken = class abstract
  private
    [JSONName('access_token')]
    FAccess_Token: string;
    [JSONName('expires_in')]
    FExpires_In: Integer;
    [JSONName('refresh_token')]
    FRefresh_Token: string;
    [JSONName('user_id')]
    FUser_Id: Int64;
  public
    function SetAccessToken(const AAccessToken: string): TToken;
    function SetExpiresIn(const AExpireIn: Integer): TToken;
    function SetRefreshToken(const ARefreshToken: string): TToken;
    function SetUserId(const AUserId: Int64): Integer;
    function GetAccessToken: string;
    function GetRefreshToken: string;
    function GetExpiresIn: Integer;
    function GetUserId: Int64;
  published
    property Access_Token: string read GetAccessToken;
    property Expires_In: Integer read GetExpiresIn;
    property Refresh_Token: string read GetRefreshToken;
    property User_Id: Int64 read GetUserId;
  end;

implementation

{ TToken }

function TToken.GetAccessToken: string;
begin
  Result := FAccess_Token;
end;

function TToken.GetExpiresIn: Integer;
begin
  Result := FExpires_In;
end;

function TToken.GetRefreshToken: string;
begin
  Result := FRefresh_Token;
end;

function TToken.GetUserId: Int64;
begin
  Result := FUser_Id;
end;

function TToken.SetAccessToken(const AAccessToken: string): TToken;
begin
  FAccess_Token := AAccessToken;
end;

function TToken.SetExpiresIn(const AExpireIn: Integer): TToken;
begin
  FExpires_In := AExpireIn;
end;

function TToken.SetRefreshToken(const ARefreshToken: string): TToken;
begin
  FRefresh_Token := ARefreshToken;
end;

function TToken.SetUserId(const AUserId: Int64): Integer;
begin
  FUser_Id := AUserId;
end;

end.
