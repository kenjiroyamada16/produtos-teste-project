using Microsoft.EntityFrameworkCore;

public static class PaginationExtension
{
  public static async Task<Pagy<T>> AddPagination<T>(this IQueryable<T> query, int page, int pageSize)
  {
    var totalItems = await query.CountAsync();
    var data = await query.Skip((page - 1) * pageSize).Take(pageSize).ToListAsync();

    return new Pagy<T>(data, totalItems, page, pageSize);
  }
}