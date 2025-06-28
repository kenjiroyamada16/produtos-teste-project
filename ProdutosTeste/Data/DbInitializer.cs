using Microsoft.EntityFrameworkCore;

public static class DbInitializer
{
  public static async Task SeedAsync(DbContext context)
  {

    await context.Set<Product>().AddRangeAsync(
    [
      new Product { Title = "Caneta", Price = 3.5M },
      new Product { Title = "Caderno", Price = 15.0M },
      new Product { Title = "Lápis",   Price = 1.2M }
     ]);

    await context.SaveChangesAsync();
  }
}