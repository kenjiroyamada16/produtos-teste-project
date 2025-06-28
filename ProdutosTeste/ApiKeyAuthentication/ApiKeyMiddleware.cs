using System.Net;

public class ApiKeyMiddleware
{
  private readonly RequestDelegate _next;
  private readonly IConfiguration _configuration;

  public ApiKeyMiddleware(RequestDelegate next, IConfiguration configuration)
  {
    _next = next;
    _configuration = configuration;
  }

  public async Task InvokeAsync(HttpContext context)
  {
    if (!context.Request.Headers.TryGetValue(ApiKeyConstants.ApiKeyHeaderName, out var key))
    {
      context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
      return;
    }

    var apiKey = _configuration.GetValue<string>(ApiKeyConstants.ApiKeyConfigurationString);

    if (apiKey == null || !apiKey.Equals(key))
    {
      context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
      return;
    }

    await _next(context);
  }
}