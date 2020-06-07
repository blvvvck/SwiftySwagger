# SwiftySwagger

SwiftySwagger это библиотека и интрумент командной строки для генерации кода на основе [OpenAPI/Swagger 3.0](https://swagger.io/specification) спецификации

#### Swift template
`SwiftySwagger` - включает в себя 3 встроенных шаблона.
Существуют на основе Alamofire, Moya и URLSession 

### CocoaPods

pod 'SwiftySwaggerPod' 

### Swift Package Manager

#### 

```sh
$ git clone https://github.com/blvvvck/SwiftySwagger.git
$ cd SwiftySwagger
$ swift run
```
## Usage As CLI

```
Commands:
  generate        Generates a template from a Swagger spec
```

### generate

```sh
swiftyswagger generate path_to_spec template_name
```

Example:

```
swift run swiftyswagger generate https://petstore3.swagger.io/api/v3/openapi.yaml Alamofire"
```

## Usage in Project
```
DefaultGenerator().generate(with: try? Swagger(url: URL(string: `specification_url`)!), path: Path.current, templateName: `template_name`
```
### Swift Template

Кроме того, пользователь может написать свой шаблон для генерации выходных файлов. Для этого нужно файл в формате .stencil положить в папку “Templates”, которая находится в корневой директории инструмента. Пользователь в своем шаблоне может использовать массив промежуточных моделей, который называется “models”. Каждый элемент массива промежуточных моделей имеет следующие поля:

“name” – строка, содержащая название операции, которая соответствует полю “operationId” в спецификации;

“url” – строка, которая содержит путь, по которому производится HTTP- запрос;

“method” – строка, которая содержит название HTTP-метода;

“parameters” – содержит словарь ключ-значение, ключом является название параметра, значением является тип параметра;

“rawParameters” – строка, которая содержит через запятую все названия параметров и их тип, например: “pet: Pet, tagId: Int”;

“rawParametersWithoutType” – строка, которая содержит через запятую все названия параметров;

“requestBodyString” – строка, которая содержит название параметра в теле запроса;

“requestBodyStringValueName” – строка, которая содержит тип параметра в теле запроса;

“responseBodyString” – строка, которая содержит название параметра, который должен прийти в ответе сервера;

“responseBodyStringValueName” – строка, которая содержит тип, возвращаемый сервером;

“queryParametersStringDictPresentation” – строка, которая содержит параметры, которые нужно отправить на сервер в query-части запроса, например: “[“petId”: id, “tagId”: tagId]”;

“queryParameters” – массив моделей запросов, которые используются в query-части запроса. Каждая модель имеет поле “name”, которое содержит в себе строку с названием параметра и поле “type”, которое содержит в себе строку с типом параметра;

“pathParameters” – массив моделей запросов, которые используются в path-части запроса. Модели аналогичны тем, что возвращает “queryParameters”.

Простые модели данных, которые необходимы для отправки на сервер или получения ответа, генерируются для всех шаблонов одинаково, потому что они не зависят от шаблона для клиент-серверного взаимодействия, так как всегда имеют только название и массив названий полей с их типами.

## Output Languages
    В данный момент поддерживает **Swift** версии 5.0
---

## Contributions
Интсрумент открыт к pull request'ам и issies'ам

## License

SwagGen is licensed under the MIT license. See [LICENSE](LICENSE) for more info.
