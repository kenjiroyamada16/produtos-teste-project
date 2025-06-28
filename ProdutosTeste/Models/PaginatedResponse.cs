namespace ProdutosTeste.Models;

public class PaginatedResponse<T>
{
  public List<T> Data { get; set; }
  public Pagy Pagy { get; set; }

  public PaginatedResponse(List<T> data, Pagy pagy)
  {
    Data = data;
    Pagy = pagy;
  }
}
