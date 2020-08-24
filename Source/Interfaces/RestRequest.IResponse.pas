unit RestRequest.IResponse;

interface

uses
  System.SysUtils,
  System.JSON,
  REST.Client,
  System.Classes;

type
  IResponse<T> = interface
    ['{D7D9B8A7-EDE5-49F5-A57F-F513B3389CFE}']
    function SetRestResponse(ARestResponse: TRESTResponse): IResponse<T>;
    function Content: T;
    function ContentType: string;
    function ContentEncoding: string;
    function StatusCode: Integer;
    function Headers: TStrings;
  end;

implementation

end.
