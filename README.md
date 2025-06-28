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

- Para isso, não há configurações iniciais específicas, apenas garanta que a rota a ser utilizada seja a mesma da especificada no `api_host.dart`!

  ```sh
  flutter run
  ```

  ou `Run and Debug` do VSCode.