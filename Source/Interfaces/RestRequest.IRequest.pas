unit RestRequest.IRequest;

interface

uses
  REST.Client,
  Data.DB,
  REST.Types,
  System.SysUtils,
  RestRequest.IResponse,
  System.JSON,
  System.Classes;

type
  IRequest<T> = interface
    ['{7842AB84-D8A3-42AC-9AA2-A83796096C34}']
    function AcceptEncoding: string; overload;
    function AcceptEncoding(const AAcceptEncoding: string): IRequest<T>; overload;
    function AcceptCharset: string; overload;
    function AcceptCharset(const AAcceptCharset: string): IRequest<T>; overload;
    function Accept: string; overload;
    function Accept(const AAccept: string = 'application/json'): IRequest<T>; overload;
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
    function AddQueryParam(const AName, AValue: string): IRequest<T>;
    function AddHeader(const AName, AValue: string; const AOptions: TRESTRequestParameterOptions = [TRESTRequestParameterOption.poDoNotEncode]): IRequest<T>;
    function ClearParams: IRequest<T>;
    function AddParam(const AName, AValue: string; const AKind: TRESTRequestParameterKind = TRESTRequestParameterKind.pkQUERY): IRequest<T>;
  end;

implementation

end.
