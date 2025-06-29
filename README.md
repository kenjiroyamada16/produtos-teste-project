## Projeto Produtos Teste

- Esse repositório contém as soluções mobile (com Flutter) e backend (com C# .NET) para a listagem e visualização de produtos;
- Além dos passos a seguir para a visualização dos itens, também é possível adicionar uma lista de produtos por meio da rota `POST` `/api/Produtos` com o seguinte body:

  ```json
  [
    {
      "title": "Nome do produto",
      "price": 10.59,
      "imageUrl": "https://url-da-imagem.png"
    },
    {
      "title": "Nome do produto",
      "price": 10.59,
      "imageUrl": "https://url-da-imagem.png"
    }
  ]
  ```

___

### Como executar a API

1. Primeiramente, garanta que o servidor MySQL de seu dispositivo esteja sendo executado corretamente, rodando os seguintes comandos no respectivo terminal do seu sistema operacional:

    - Windows (como administrador):
      ```sh
      cd ProdutosTeste
      net start mysql
      net start MySQL80
      ```

    - Linux:
      ```sh
      cd ProdutosTeste
      sudo systemctl start mysqld
      sudo systemctl status mysqld
      ```

2. Em seguida, inicialize uma instância de banco de dados de acordo com as credenciais:

    ```
    Name: Produtos
    User: root
    Password: secret123
    ```

3. Com o banco de dados pronto, podemos executar as migrations do projeto. Esse comando também irá popular o seu banco com 3 mocks de produtos:

    ```sh
    dotnet ef database update
    ```

4. Está tudo pronto para você executar o projeto! Apenas rode o comando abaixo ou utilize o `Run and Debug` do VSCode para adicionar e debuggar breakpoints. Ao realizar uma das duas ações, você será direcionado para a página web contendo a representação da API em Swagger, onde você poderá visualizar as rotas e utilizá-las:

    ```sh
    dotnet run
    ```

___

### Rodando o projeto Flutter

- Para garantir a visualização correta da lista, precisamos deixar a rota para a nossa API disponível à nossa aplicação Flutter. Para testar com aplicativos próprios para isso como Postman ou Insomnia, você apenas precisa realizar as etapas acima porém, para disponibilizar a rota sem problemas para o nosso Frontend, precisaremos do [ngrok](https://ngrok.com/downloads/windows).

  - Após inicializar a API:
    ```sh
    ngrok http 5258 (ou outro port onde a API esteja rodando)
    ```
  - Em seguida, com o comando acima, uma URL será disponibilizada, parecida com esta: `https://788f-200-152-81-65.ngrok-free.app`. Copie-a e adicione ao `api_host.dart` do projeto Flutter como `baseUrl`.

  - Feito! Seus projetos estão conectados e você já pode inicializar a parte mobile:

    ```sh
    flutter run
    ```

    ou `Run and Debug` do VSCode.

___

- Obs: Tenho ciência de que deixei a ApiKey desprotegida. Implementei dessa forma para facilitar os testes e análise do projeto por terceiros e também para manter o foco na funcionalidade em vez de investir tempo na segurança de um projeto que não vai para o ambiente de produção. Obrigado!