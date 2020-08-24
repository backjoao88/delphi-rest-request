# Delphi REST Request

Delphi REST Request is a simple API to consume REST services written in any programming language. 

This API has support only to OAuth2 Authentication.

This version take advantage of Generics Methods.

## :wrench: Manual Installation

* To use this API, add the followings directories to the search path of your project:

```
../delphi-rest-request/Source/Core
../delphi-rest-request/Interfaces
```


## :pencil2: Samples

* **GET**

```pascal
TRequest<CLASS-TYPE>
  .New
  .BaseUrl('BASE-URL')
  .Resource('RESOURCE')
  .Get
  .Content;
```

* **POST**

```pascal
TRequest<CLASS-TYPE>
  .New
  .BaseUrl('BASE-URL')
  .Resource('RESOURCE')
  .AddBody('BODY')
  .Post
  .Content;
```

## :key: OAuth2 Authentication

Set the credentials using the ```TOAuth2Configuration``` class. 

```
AuthConfig = TOAuth2Configuration
  .New
  .SetClientId('CLIENT-ID')
  .SetClientSecret('CLIENT-SECRET')
  .SetRedirectionEndpoint('REDIRECT-URI')
  .SetAuthorizationEndpoint('AUTHORIZATION-ENDPOINT')
  .SetScope('SCOPE')
  .SetAccessTokenEndpoint('ACCESS-TOKEN-ENDPOINT');
```

Use the ```Authorize``` method present on ```TOAuth2Authenticator``` class to get the access token.

```
Token := TOAuth2Authenticator
  .New(AuthConfig)
  .Authorize('AUTH-CODE');
```

