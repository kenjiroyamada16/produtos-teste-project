using Microsoft.AspNetCore.Mvc;
using ProdutosTeste.Models;

namespace ProdutosTeste.Controllers;

[ApiController]
[Route("[controller]")]
public class ProductsController : ControllerBase
{
  private readonly AppDbContext _dbContext;

  public ProductsController(AppDbContext dbContext)
  {
    _dbContext = dbContext;
  }

  [HttpGet]
  public async Task<ActionResult<PaginatedResponse<Product>>> GetProducts(
    [FromQuery]
    int page = 1,
    [FromQuery]
    int pageSize = 10,
    [FromQuery]
    string? query = null)
  {
    pageSize = Math.Min(pageSize, 20);

    var productsList = _dbContext.Products.AsQueryable();

    if (!string.IsNullOrWhiteSpace(query))
    {
      productsList = productsList.Where(product => product.Title.Contains(query));
    }

    var (data, pagy) = await productsList.AddPagination(page, pageSize);
    var response = new PaginatedResponse<Product>(data, pagy);

    return Ok(response);
  }

  [HttpPost]
  public async Task<IActionResult> AddProducts([FromBody] List<Product> newProductsList)
  {
    if (newProductsList == null || !newProductsList.Any()) return BadRequest("Informe produtos válidos");
    if (!ModelState.IsValid) return UnprocessableEntity(ModelState);

    _dbContext.Products.AddRange(newProductsList);
    await _dbContext.SaveChangesAsync();

    return Ok(newProductsList);
  }
}
