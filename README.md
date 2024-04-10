Acesse [https://emanuel-braz.github.io/flutter_sp_social/](https://emanuel-braz.github.io/flutter_sp_social/)

Para adicionar novos QRCodes, crie um novo arquivo `{numero_da_edição_do_meetup}.json` dentro da pasta `data`.

Por exemplo o 16º meetup ficaria `./data/16.json`.

Para visualizar o QRCode criado, acesse o app utilizando a query param `id`. 

Exemplo: https://emanuel-braz.github.io/flutter_sp_social?id=16  

Json de exemplo:
```json
{
    "eventName": "16º Flutter SP",
    "eventDate": "2019-01-01",
    "social_qr_codes": [
        {
            "title": "Se inscreva no meetup",
            "qr_code": "https://www.meetup.com/pt-BR/fluttersp/",
            "icon": "https://upload.wikimedia.org/wikipedia/commons/6/6b/Meetup_Logo.png"
        },
    ]
}
```
