---
title: API Reference

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
  "scope": "business",
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

```json
{
  "grant_type" : "password",
  "email" : "client@teip.io",
  "password" : "ciao_billetera",
  "scope": "business"
}
```

> Respuesta:

```json
{
  "access_token": "HYuYuzsZpa-INLnikmf9qYJdo_lh8HAOXwFzBMfp6hE",
  "token_type": "Bearer",
  "expires_in": 600,
  "refresh_token": "8MXaztpGYG7p9VHlTSBBr9pOWGCR8PAkUuKCCTPBNBM",
  "scope": "business",
  "created_at": 1684796579
}
```

**Parametros**

Parametros | Descripción
--------- | -----------
grant_type | string, **requerido** <br/> por defecto: password
email | string, **requerido** <br/> correo de usuario.
password | string, **requerido** <br/> Contraseña de usuario
scope | string, **requerido** <br/> por defecto: business

# Pagar

**Crear un pago**

`POST /api/v1/pay`

```json
{
  "data" {
    "card_network": "mastercard",
    "card_number": "5129239627814527",
    "security_code": "123",
    "cardholder_name": "Jhon Doe",
    "expiration_month": "09",
    "expiration_year": "25",
    "subtotal_cents": 10000,
    "subtotal_currency": "USD",
    "billing_email": "customer@teip.io",
    "billing_name": "Jhon",
    "billing_country": "El Salvador",
    "billing_city": "San Salvador",
    "billing_address": "83 Avenida Norte y, 13 Calle Poniente 4260, San Salvador",
    "billing_postal_code": "1101",
    "reference_code": "1234567890"
	}
}
```
> Respuesta

```json
{
  "data"	{
    "id" : "6a31db5a-a0d8-4401-857c-9f321e8d83c8",
    "status" : "success",
    "amount_cents" : 10000,
    "amount_currency" : "USD",
    "response_code" : "00",
    "authorization_number" : "127512",
    "reference_code": "1234567890"
  }
}
```

**Parametros**

Parametros | Descripción
--------- | -----------
card_network | string, **requerido** <br/> opciones: mastercard, visa.
card_number | string, **requerido** <br/> número de tarjeta.
security_code | string, **requerido** <br/> código de seguridad.
cardholder_name | string, **requerido** <br/> nombre según tarjeta.
expiration_month | string, **requerido** <br/> mes de expiración.
expiration_year | string, **requerido** <br/> año de expiración.
subtotal_cents | integer, **requerido** <br/> subtotal de la cuenta.
subtotal_currency | string, **requerido** <br/> por defecto: USD.
billing_email | string, **requerido** <br/> correo electrónico.
billing_name | string <br/> nombre.
billing_country | string <br/> país.
billing_city | string <br/> ciudad.
billing_address | string <br/> dirección.
billing_postal_code | string <br/> código postal.
reference_code | string <br/> código de referencia.
