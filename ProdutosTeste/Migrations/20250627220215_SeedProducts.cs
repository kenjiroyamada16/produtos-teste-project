using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProdutosTeste.Migrations
{
  /// <inheritdoc />
  public partial class SeedProducts : Migration
  {

    private readonly bool _isDevelopment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") == "Development";
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder)
    {
      if (!_isDevelopment) return;

      migrationBuilder.Sql(
        "INSERT INTO Products (Title, Price, ImageUrl) VALUES " +
        "('Caneta', 3.5, 'https://acdn-us.mitiendanube.com/stores/001/675/550/products/1321-a67b08627ad0f5c3a616360550476867-640-0.png'), " +
        "('Caderno', 15.0, 'https://rlv.zcache.com.br/caderno_espiral_grafico_de_corrente_de_alienigena_ben_10-r4ab75bc4c1c04810a4f1d17df7ec0656_adghc_8byvr_644.jpg'), " +
        "('Lápis', 1.2, 'https://images.vexels.com/media/users/3/153265/isolated/preview/631005e89f6ff9017d236113be33ba85-ilustracao-de-escola-de-lapis.png');"
    );
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder)
    {
      if (!_isDevelopment) return;

      migrationBuilder.Sql("DELETE FROM Products WHERE Name IN ('Caneta','Caderno','Lápis');");
    }
  }
}
