using System.ComponentModel.DataAnnotations;

public class Product
{
  [Key]
  public int Id { get; init; }

  [Required(ErrorMessage = "O campo Title é obrigatório")]
  [MaxLength(50, ErrorMessage = "O campo Title precisa ter, no máximo, 50 caracteres")]
  public string Title { get; set; } = string.Empty;

  [Required(ErrorMessage = "O campo Price é obrigatório")]
  [Range(0.0, double.MaxValue, ErrorMessage = "O campo Price precisa ser um valor positivo")]
  public decimal Price { get; set; }
  public string ImageUrl { get; set; } = string.Empty;
}