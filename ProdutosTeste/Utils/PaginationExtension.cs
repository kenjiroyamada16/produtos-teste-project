using Microsoft.EntityFrameworkCore;

public static class PaginationExtension
{
  public static async Task<(List<T> Data, Pagy Pagy)> AddPagination<T>(this IQueryable<T> query, int page, int pageSize)
  {
    var totalItems = await query.CountAsync();
    var data = await query.Skip((page - 1) * pageSize).Take(pageSize).ToListAsync();
    var pagy = new Pagy(totalItems, page, pageSize);

    return (data, pagy);
  }
}