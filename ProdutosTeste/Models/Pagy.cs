public class Pagy
{
  public int CurrentPage { get; set; }
  public int PageSize { get; set; }
  public int TotalItems { get; set; }
  public int TotalPages { get; set; }

  public Pagy(int totalItems, int currentPage, int pageSize)
  {
    TotalItems = totalItems;
    CurrentPage = currentPage;
    PageSize = pageSize;
    TotalPages = (int)Math.Ceiling(totalItems / (double)pageSize);
  }
}