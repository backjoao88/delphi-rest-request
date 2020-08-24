unit RestRequest.Response;

interface

uses
  RestRequest.IResponse,
  REST.Client,
  REST.Json,
  System.SysUtils,
  System.JSON,
  System.Classes;

type
  TResponse<T: class, constructor> = class(TInterfacedObject, IResponse<T>)
  private
    FRestResponse: TRESTResponse;
    function SetRestResponse(ARestResponse: TRESTResponse): IResponse<T>;
    function Content: T;
    function ContentType: string;
    function ContentEncoding: string;
    function StatusCode: Integer;
    function Headers: TStrings;
  public
    constructor Create(const ARESTResponse: TRESTResponse);
  end;

implementation

{ TResponse<T> }

constructor TResponse<T>.Create(const ARestResponse: TRESTResponse);
begin
  FRestResponse := ARestResponse;
end;

function TResponse<T>.Content: T;
begin
  Result := TJson.JsonToObject<T>(FRestResponse.JSONText);
end;

function TResponse<T>.ContentEncoding: string;
begin
  Result := FRestResponse.ContentEncoding;
end;

function TResponse<T>.ContentType: string;
begin
  Result := FRestResponse.ContentType;
end;

function TResponse<T>.Headers: TStrings;
begin
  Result := FRestResponse.Headers;
end;

function TResponse<T>.SetRestResponse(
  ARestResponse: TRESTResponse): IResponse<T>;
begin
  Self.FRestResponse := ARestResponse;
end;

function TResponse<T>.StatusCode: Integer;
begin
  Result := FRestResponse.StatusCode;
end;

end.
