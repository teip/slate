---
title: API partners Reference

language_tabs:
  - json

meta:
  - name: description
    content: Documentación API teip
---

# Introducción

En esta documentación, te proporcionaremos una descripción de los endpoints disponibles, así como los parámetros y opciones de configuración admitidos. Además, te mostraremos ejemplos de solicitudes y respuestas, lo que te ayudará a comprender cómo utilizar la API en tu propia aplicación.

<aside class="notice">
  Para la utilización de la API comunicarse con su asesor comercial para la entrega de <b>usuario, contraseña, código de cliente y url</b> para cada ambiente de desarrollo.
</aside>

# Autorización

**Crear código de autorización**

La API utiliza autorización PKCE (Proof Key for Code Exchange) es una extensión del flujo de código de autorización OAuth 2.0 que agrega una capa adicional de seguridad al proceso de autorización.

`POST /api/v1/oauth/application/authorize`

```json
{
  "client_id": "6jNrApfMbLyOivAfjU5W58bgYK-xKOb6wGyA1I8TlNI",
  "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
  "response_type": "code",
  "code_challenge": "IqkNRrXrwLGcyTX-QLG-V5K_s0L7AE_Sv1wUoJyTPiM",
  "code_challenge_method": "S256"
}
```

> Respuesta:

```json
{
  "status": "redirect",
    "redirect_uri": {
      "action": "show",
      "code": "k38vzvKmkmTZgm-QhP2TPPaNvJ3CIMZBJHQgFNNfv34"
  }
}
```

**Parametros**

Parametros | Descripción
--------- | -----------
client_id | string, **requerido** <br/> código de cliente.
redirect_uri | string, **requerido** <br/> por defecto: urn:ietf:wg:oauth:2.0:oob
response_type | string, **requerido** <br/> por defecto: code
code_challenge | string, **requerido** <br/> [generar code challenge S256](https://datatracker.ietf.org/doc/html/rfc7636#section-4.2)
code_challenge_method | string, **requerido** <br/> opciones: S256 o plain

# Token de autorización

**Crear token de autorización**

`POST /api/v1/oauth/application/token`

```json
{
  "client_id": "6jNrApfMbLyOivAfjU5W58bgYK-xKOb6wGyA1I8TlNI",
  "code": "woXg6GdX6nnebd_Vuv6s9iZpuoxZ7eQCpaIZFEdFXA4",
  "code_verifier": "0nsGofYNLgP-OMC-EV1XmwrqPcIsCMtf54yBQ8YUn0E",
  "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
  "grant_type": "authorization_code"
}
```

> Respuesta:

```json
{
  "access_token": "cw1y-Hk1vf7RByoJdTnj9z7_Kl6Y9vJS-rXW4PK9R84",
  "token_type": "Bearer",
  "expires_in": 600,
  "refresh_token": "kA7G7nH2kkGhoFFsQD-pq66QqDwjwPCHZZ8cDVs96i4",
  "scope": "partner",
  "created_at": 1684796557
}
```

**Parametros**

Parametros | Descripción
--------- | -----------
client_id | string, **requerido** <br/> código de cliente.
code | string, **requerido** <br/> Token creado en la acción de [autorización ](#autorizacion).
code_verifier | string, **requerido** <br/> [generar code verifier](https://datatracker.ietf.org/doc/html/rfc7636#section-4.1)
redirect_uri | string, **requerido** <br/> por defecto: urn:ietf:wg:oauth:2.0:oob
grant_type | string, **requerido** <br/> por defecto: authorization_code

# Autenticación

**Crear token de autenticación**

`POST api/v1/oauth/token`

> AUTORIZACION: Bearer Token

```json
{
  "grant_type" : "password",
  "email" : "client@teip.io",
  "password" : "ciao_billetera",
  "scope": "partner"
}
```

> Respuesta:

```json
{
  "access_token": "HYuYuzsZpa-INLnikmf9qYJdo_lh8HAOXwFzBMfp6hE",
  "token_type": "Bearer",
  "expires_in": 600,
  "refresh_token": "8MXaztpGYG7p9VHlTSBBr9pOWGCR8PAkUuKCCTPBNBM",
  "scope": "partner",
  "created_at": 1684796579
}
```

**Parametros**

Parametros | Descripción
--------- | -----------
grant_type | string, **requerido** <br/> por defecto: password
email | string, **requerido** <br/> correo de usuario.
password | string, **requerido** <br/> Contraseña de usuario
scope | string, **requerido** <br/> por defecto: partner


# Sucursales

**Obtener sucursales registradas**

`GET /api/v1/partners/branches`

```json
{
  "code": "C80X6T"
}
```

> Respuesta:

```json
{
  "data":	[
    {
      "id" : "6a31db5a-a0d8-4401-857c-9f321e8d83c8",
      "name" : "Sucursal 1"
    },
    {
      "id" : "9b736455-67cc-497c-8c9b-bdae8d31c757",
      "name" : "Sucursal 2"
    }
  ]
}
```

**Parametros**

Parametros | Descripción
--------- | -----------
code | string, **requerido** <br/> Código asociado al comercio para realizar la integración con el punto de ventas.


# Banco

### Listado de bancos

> AUTORIZACION: Bearer Token

`GET /api/v1/partners/banks`

> Respuesta

```json
{
  "data":	[
    {
      "id" : "6a31db5a-a0d8-4401-857c-9f321e8d83c8",
      "name" : "Agrícola"
    }
  ]
}
```

# Comercio

### Listado de tipos de comercios

> AUTORIZACION: Bearer Token

`GET /api/v1/partners/commerce_kinds`

> Respuesta

```json
{
  "data":	[
    {
      "id" : "9b736455-67cc-497c-8c9b-bdae8d31c757",
      "name" : "Comida"
    }
  ]
}
```

# Compañia

### Crear compañia

> AUTORIZACION: Bearer Token

`POST /api/v1/partners/companies`

```json
{
  "data": {
    "business_name": "Shields, Kerluke and O'Hara",
    "business_nit": "407-75-5793",
    "business_nrc": "856-32-0924",
    "commerce_name": "Lind-Wintheiser",
    "commerce_kind_id": "0b519b29-2ac5-4f47-9a1b-6d8fb185a978",
    "company_kind": "legal",
    "line": "Law Enforcement",
    "address_summary": "3039 Toi Station, Lake Mechellemouth, MN 80074",
    "address_state_code": "SV-SS",
    "address_municipality": "San Salvador",
    "name": "Turner Inc",
    "email": "kris.conn@gmail.com",
    "phone": "+8096042544937",
    "dui": "438-96-9823",
    "nit": "500-69-5628",
    "nrc": "887-24-2151",
    "accountant_contact_name": "Ankunding, Greenholt and Morar",
    "accountant_contact_email": "bradly@hotmail.com",
    "accountant_contact_phone": "+26914176142896",
    "bank_account": {
      "account_type": "current",
      "bank_id": "ae41a653-3a23-4a52-9289-d9bd43d196a7",
      "account_holder": "Rep. Lisabeth Greenholt",
      "account_number": "5320573224",
      "billing_type": "final_consumer"
    },
    "branches": [
      {
        "name": "Executive Office",
        "address": "32547 Mona Islands, Port Michelle, LA 70565-2509",
        "phone": "+16704621339538",
        "contact_name": "Hyun",
        "contact_phone": "+2362034755337",
        "code": "msuoxqiych"
      }
    ]
  }
}
```
> Respuesta

```json
{
  "data": {
    "id": "c5e5d96b-2020-4dd5-b277-d7ea86e9571f",
    "branches": [
      {
        "id": "540e1199-488e-478c-9423-8e1c29c417b5",
        "name": "Executive Office",
        "code": "msuoxqiych"
      }
    ]
  }
}
```

**Parametros**

Parametros | Descripción
--------- | -----------
business_name | string, máximo: 32 caracteres <br/> Nombre de la razon social <br/> (obligatorio si company_kind es legal)
business_nit | string, máximo: 32 caracteres <br/> NIT de la razon social <br/> (obligatorio si company_kind es legal) <br/>
business_nrc | string, máximo: 32 caracteres <br/> NRC de la razon social <br/> (obligatorio si company_kind es legal) <br/>
commerce_name | string, **requerido** <br/> Nombre del comercio
commerce_kind_id | string (uuid), **requerido** <br/> Tipo de comercio
company_kind | string, **requerido** <br/> Tipo de empresa <br/> opciones: [legal, natural]
line | string, **requerido** <br/> Giro o actividad principal
address_summary | string, **requerido** <br/> Dirección de oficina central
address_state_code | string, **requerido** <br/> Departamento de oficina central
address_municipality | string, **requerido** <br/> Municipio de oficina central
name | string, **requerido** <br/> Nombre del representante legal/propietario
email | string, **requerido** <br/> Correo electrónico del representante legal/propietario
phone | string, **requerido** <br/> Teléfono del representante legal/propietario <br/> formato: +58668624482
dui | string, **requerido** <br/> DUI del representante legal/propietario
nit | string, **requerido** <br/> NIT del representante legal/propietario
nrc | string <br/> NRC del propietario
accountant_contact_name | string <br/> Nombre de quien recibira los estados de cuenta
accountant_contact_email | string <br/> Correo electronico de quien recibira los estados de cuenta
accountant_contact_phone | string <br/> Teléfono de quien recibira los estados de cuenta <br/> formato: +58668624482
nit_document_front | string, **requerido** <br/> Base64 de la imagen del NIT del representante legal/propietario
nit_document_back | string, **requerido** <br/> Base64 de la imagen del NIT del representante legal/propietario (reverso)
dui_document_front | string, **requerido** <br/> Base64 de la imagen del DUI del representante legal/propietario
dui_document_back | string, **requerido** <br/> Base64 de la imagen del DUI del representante legal/propietario (reverso)
nrc_document_front | string <br/> Base64 de la imagen del NRC del representante legal/propietario
nrc_document_back | string <br/> Base64 de la imagen del NRC del representante legal/propietario (reverso)
business_nit_document_front | string <br/> Base64 de la imagen del NIT de la razon social
business_nit_document_back | string <br/> Base64 de la imagen del NIT de la razon social (reverso)
business_nrc_document_front | string <br/> Base64 de la imagen del DUI de la razon social
business_nrc_document_back | string <br/> Base64 de la imagen del DUI de la razon social (reverso)
bank_account | objeto company.bank_account, **requerido** <br/>
branches | array de objetos company.branch, **requerido**

**Objeto company.bank_account**

Parametros | Descripción
--------- | -----------
account_type | string, **requerido** <br/> Tipo de cuenta <br/> opciones: [current, savings]
bank_id | string (uuid), **requerido** <br/> Banco
account_holder | string, **requerido** <br/> Titular de la cuenta
account_number | string, **requerido** <br/> Número de la cuenta
billing_type | string, **requerido** <br/> Tipo de facturación <br/> opciones: [final_consumer, fiscal_credit]

**Objeto company.branch**

Parametros | Descripción
--------- | -----------
name | string, **requerido** <br/> Nombre de sucursal
address | string, **requerido** <br/> Dirección de sucursal
phone | string <br/> Teléfono de sucursal <br/> formato: +58668624482
contact_name | string, **requerido** <br/> Nombre del encargado
contact_phone | string, **requerido** <br/> Teléfono del encargado <br/> formato: +58668624482
code | string, **requerido** <br/> Codigo de la sucursal

# Ordenes

### Crear orden

> AUTORIZACION: Bearer Token

`POST /api/v1/partners/orders`

```json
{
  "data": {
    {
      "branch_id": "4402a1c1-cfd9-48c2-9545-07a4aa6cd6fe",
      "subtotal_cents": 10000,
      "subtotal_currency": "USD",
      "tip_cents": 1000,
      "tip_percentage": 10
      "tip_currency": "USD",
      "exempt": false,
      "reference_code": "727249"
    }
  }
}
```
> Respuesta

```json
  {
    "data": {
      "id": "3a63f9e6-2382-40ef-83cf-222fadedb47c",
      "subtotal_cents": 10000,
      "tip_cents": 1000,
      "tip_percentage": 10
      "reference_code": "727249"
      "url": "https://links.teip.io/paylink/turner-inc--executive-office?o=3a63f9e6-2382-40ef-83cf-222fadedb47c"
    }
  }
```

**Parametros**

Parametros | Descripción
--------- | -----------
branch_id | string (uuid), **requerido** <br/> uuid de sucursal
subtotal_cents | integer, **requerido** <br/> monto total de la orden
subtotal_currency | string, **requerido** <br/> moneda de la orden <br/> por defecto: "USD"
tip_cents | integer, **requerido** <br/> monto de la propina
tip_currency | string (uuid), **requerido** <br/> moneda de la propina <br/> por defecto: "USD"
tip_percentage | integer, **requerido** <br/> porcentaje de la propina
exempt | boolean, **requerido** <br/> Excento <br/> opciones: [true, false]
reference_code | string, **requerido** <br/> Número de referencia de la orden del propietario

### Actualizar orden

> AUTORIZACION: Bearer Token

`PUT /api/v1/partners/orders/{id}`

```json
{
  "data": {
    {
      "subtotal_cents": 10000,
      "subtotal_currency": "USD",
      "tip_cents": 1000,
      "tip_currency": "USD"
    }
  }
}
```
> Respuesta

```json
  {
    "data": {
      "id": "3a63f9e6-2382-40ef-83cf-222fadedb47c",
      "subtotal_cents": 10000,
      "tip_cents": 1000,
      "tip_percentage": 10,
      "reference_code": "727249"
      "url": "https://links.teip.io/paylink/turner-inc--executive-office?o=3a63f9e6-2382-40ef-83cf-222fadedb47c"
    }
  }
```

**Parametros**

Parametros | Descripción
--------- | -----------
subtotal_cents | integer, **requerido** <br/> monto total de la orden
subtotal_currency | string, **requerido** <br/> moneda de la orden <br/> por defecto: "USD"
tip_cents | integer, **requerido** <br/> monto de la propina
tip_currency | string (uuid), **requerido** <br/> moneda de la propina <br/> por defecto: "USD"


### Completar orden

> AUTORIZACION: Bearer Token

`PUT /api/v1/partners/orders/{id}/complete`


> Respuesta

```json
  {
    "data": {
      "id": "3a63f9e6-2382-40ef-83cf-222fadedb47c",
      "status": "completed"
    }
  }
```

**Parametro URL**

Parametros | Descripción
--------- | -----------
id | string (uuid), **requerido** <br/> uuid de orden

# Webhooks

Se enviará información de cada una de los pagos realizadas a una URL proporcionada por el cliente.
La informacion que se enviara en cada llamada del webhook es la siguiente:

`POST [URL CLIENTE]`

> Respuesta 200

```json
  {
    "data": {
      "order_reference_number": "ATD23",
      "status": "success",
      "date": "20230105",
      "time": "102344",
      "user_name": "Juan Quesada Maldonado",
      "user_email": "kenny_little@zemlak.net",
      "subtotal_cents":10000,
      "tip_cents":1000
    }
  }
```

