unit RestRequest.IOAuth2Configuration;

interface

uses
  System.Generics.Collections, IdHTTPServer;

type
  IOAuth2Configuration = interface
    ['{8330A671-5F1B-4B2B-9A04-17A205A97EFB}']
    function SetClientId(const AValue: string): IOAuth2Configuration;
    function SetClientSecret(const AValue: string): IOAuth2Configuration;
    function SetRedirectionEndpoint(const AValue: string): IOAuth2Configuration;
    function SetAuthorizationEndpoint(const AValue: string): IOAuth2Configuration;
    function SetScope(const AValue: string): IOAuth2Configuration;
    function SetAccessTokenEndpoint(const AValue: string): IOAuth2Configuration;
    function GetClientID: string;
    function GetClientSecret: string;
    function GetRedirectionEndpoint: string;
    function GetAuthorizationEndpoint: string;
    function GetScope: string;
    function GetAccessTokenEndpoint: string;
    function GetAuthUrl: string;
  end;

implementation

end.

