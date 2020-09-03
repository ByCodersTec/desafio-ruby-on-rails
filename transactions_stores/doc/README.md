# API

## Requests

### **GET** - /v1/financial_transactions

#### CURL

```sh
curl -X GET "http://127.0.0.1:3000/v1/financial_transactions\
?store_name=BAR%20DO%20JO%C3%83O"
```

#### Query Parameters

- **store_name** Name of store. Could be pass space and special characters. Should respect the following schema:

```
{
  "type": "string",
  "enum": [
    "BAR DO JOÃO"
  ],
  "default": "BAR DO JOÃO"
}
```

#### Axios

```
axios({
  "method": "GET",
  "url": "http://127.0.0.1:3000/v1/financial_transactions",
  "params": {
    "store_name": "BAR DO JOÃO"
  }
})
```

#### Response

```
[
  {
    "id": 1,
    "formatted_amount": "R$ 142,00",
    "formatted_occurred_in": "01/03/2019 15:34:53",
    "store": {
      "id": 2,
      "name": "BAR DO JOÃO",
      "owner": "JOÃO MACEDO"
    },
    "recipient": {
      "id": 1,
      "cpf": "09620676017",
      "card": "4753****3153"
    },
    "transaction_type": {
      "id": 3,
      "description": "Financiamento",
      "formatted_origin": "Saída"
    }
  },
  {
    "id": 4,
    "formatted_amount": "R$ 112,00",
    "formatted_occurred_in": "01/03/2019 23:42:34",
    "store": {
      "id": 2,
      "name": "BAR DO JOÃO",
      "owner": "JOÃO MACEDO"
    },
    "recipient": {
      "id": 4,
      "cpf": "09620676017",
      "card": "3648****0099"
    },
    "transaction_type": {
      "id": 2,
      "description": "Boleto",
      "formatted_origin": "Saída"
    }
  },
  {
    "id": 5,
    "formatted_amount": "R$ 152,00",
    "formatted_occurred_in": "01/03/2019 23:30:00",
    "store": {
      "id": 2,
      "name": "BAR DO JOÃO",
      "owner": "JOÃO MACEDO"
    },
    "recipient": {
      "id": 5,
      "cpf": "09620676017",
      "card": "1234****7890"
    },
    "transaction_type": {
      "id": 1,
      "description": "Débito",
      "formatted_origin": "Saída"
    }
  }
]
```