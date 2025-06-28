using Microsoft.AspNetCore.Mvc;

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
  public async Task<ActionResult<Pagy<Product>>> GetProducts(
    [FromQuery]
    int page = 1,
    [FromQuery]
    int pageSize = 10)
  {
    pageSize = Math.Min(pageSize, 20);

    var paginatedData = await _dbContext.Products.AddPagination(page, pageSize);

    return Ok(paginatedData);
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
